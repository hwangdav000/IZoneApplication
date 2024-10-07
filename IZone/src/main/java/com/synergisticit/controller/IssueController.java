package com.synergisticit.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.synergisticit.client.IZoneClient;
import com.synergisticit.domain.Document;
import com.synergisticit.domain.Issue;
import com.synergisticit.domain.IssueType;
import com.synergisticit.domain.Priority;
import com.synergisticit.domain.Project;
import com.synergisticit.domain.IssueStatus;
import com.synergisticit.domain.User;
import com.synergisticit.service.UserService;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import jakarta.servlet.http.HttpSession;

@Controller
public class IssueController {
	
	public static final String UPLOAD_ISSUE_DIR = "C:/SynergisticIT/IZoneIssues";
	
	@Autowired IZoneClient izClient;
	@Autowired UserService uService;
	
	@GetMapping("backlog")
	public String getBacklog(HttpSession session, Model model) {
	    Project p = (Project) session.getAttribute("project");
	    
	    if (p == null) {
	    	return "redirect:login";
	    }
	    
	    Long projectId = p.getProjectId();
	    
	    // Fetch the JSON response as JsonNode
	    JsonNode issueListNode = izClient.getIssuesByProjectId(projectId);
	  
	    
	    ObjectMapper mapper = new ObjectMapper();
	    mapper.registerModule(new JavaTimeModule());
	    List<Issue> issues = new ArrayList<>();
	    
	    // Check if the JsonNode is an array
	    if (issueListNode.isArray()) {
	        for (JsonNode node : issueListNode) {
	            // Convert each JsonNode item to an Issue object
	            Issue issue = mapper.convertValue(node, Issue.class);
	            issues.add(issue);
	        }
	    } else {
	        // Handle the case where issueListNode is not an array
	        System.out.println("Expected JSON array but received: " + issueListNode.toString());
	    }
	    
	    model.addAttribute("issues", issues);
	    
	    return "backlog";
	}

	
	@GetMapping("issueForm")
	public String getIssueForm(Issue issue, Model model) {
		
		model.addAttribute("issueTypes", Arrays.asList(IssueType.values()));
		model.addAttribute("priorities", Arrays.asList(Priority.values()));
		model.addAttribute("issueStatuses", Arrays.asList(IssueStatus.values()));
		return "issueForm";
	}

    @PostMapping("saveIssue")
    public String saveIssue(@RequestParam("attachments") List<MultipartFile> attachments,
    		HttpSession session,
    		Issue issue, Model model, Principal principal) {
    	User u = uService.findUserByUsername(principal.getName());
    	Project p = (Project) session.getAttribute("project");
    	String projectName = p.getProjectName();
    	Long projectId = p.getProjectId();
    	
        List<String> documentNames = new ArrayList<>();
        List<String> documentPaths = new ArrayList<>();

        String UPLOAD_DIR_ISSUE = UPLOAD_ISSUE_DIR + "/" + projectName;

        try {
            // Create project folder if it doesn't exist
            Path projectDirPath = Paths.get(UPLOAD_DIR_ISSUE);
            if (!Files.exists(projectDirPath)) {
                Files.createDirectories(projectDirPath);
            }

            for (int i = 0; i < attachments.size(); i++) {
                MultipartFile file = attachments.get(i);

                // Check file size
                if (file.getSize() <= 5 * 1024 * 1024) { // 5MB limit in bytes
                    byte[] bytes = file.getBytes();

                    // Generate a unique file name to avoid conflicts
                    String fileName = projectName + "_" + i + "_" + System.currentTimeMillis();

                    // Determine the full path for the file
                    Path path = Paths.get(UPLOAD_DIR_ISSUE + "/" + fileName);

                    // Save the file to disk
                    Files.write(path, bytes);

                    // Add the file name and path to the lists
                    documentNames.add(file.getOriginalFilename());
                    documentPaths.add(path.toString());

                } else {
                    // Handle file size error
                    model.addAttribute("error", "File size exceeded limit (5MB)");
                    return "errorPage"; //TODO 
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "File upload failed");
            return "errorPage";  // TODO
        }

    	// Create a Map to hold the request parameters
        Map<String, Object> requestParams = new HashMap<>();
        requestParams.put("projectId", projectId);
        requestParams.put("issueType", issue.getIssueType());
        requestParams.put("priority", issue.getPriority());
        requestParams.put("assignee", issue.getAssignee());
        requestParams.put("reporter", u.getUserEmail());
        requestParams.put("issueStatus", issue.getIssueStatus());
        requestParams.put("issueName", issue.getIssueName());
        requestParams.put("issueSummary", issue.getIssueSummary());
        requestParams.put("documentName", documentNames);
        requestParams.put("documentPath", documentPaths);
        
        // Convert the Map to a JsonNode using an ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.valueToTree(requestParams);
        
        
        // need to do error checking to see if project name is unique
        JsonNode node = izClient.saveIssue(jsonNode);
        
        return "redirect:board"; // Redirect to board
    }
    
}
