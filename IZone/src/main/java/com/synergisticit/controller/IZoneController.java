package com.synergisticit.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.synergisticit.client.IZoneClient;
import com.synergisticit.domain.Issue;
import com.synergisticit.domain.Project;
import com.synergisticit.domain.User;
import com.synergisticit.service.UserService;

import jakarta.servlet.http.HttpSession;

@RestController
public class IZoneController {
	public static final String UPLOAD_ISSUE_DIR = "C:/SynergisticIT/IZoneIssues";
	
	@Autowired IZoneClient izClient;
	@Autowired UserService uService;
	
	@GetMapping("issues/{issueId}")
	public JsonNode getIssues(@PathVariable Long issueId) {
		return izClient.getIssueById(issueId);
	}
	
	@PostMapping("saveComment/{issueId}")
	public ResponseEntity<JsonNode> saveComment( @PathVariable Long issueId, @RequestBody JsonNode node, Principal p) {
		node = ((ObjectNode) node).put("issueId", issueId);
		node = ((ObjectNode) node).put("submitter", p.getName());
		
		JsonNode issue = izClient.saveComment(node);
		return ResponseEntity.ok(issue);
	}
	
	
	@PostMapping("updateIssue/{issueId}")
	public ResponseEntity<JsonNode> updateIssue( @PathVariable Long issueId, @RequestBody JsonNode node, Principal p) {
		JsonNode issue = izClient.updateIssue(node, issueId);
		return ResponseEntity.ok(issue);
	}
	
	
	// get the information of the document from local storage
    @GetMapping("/downloader")
    public ResponseEntity<?> downloader(@RequestParam String filePath) throws IOException { 
    	Path path = Paths.get(filePath);
    	byte[] bytes = Files.readAllBytes(path);
    	return new ResponseEntity<byte[]>(bytes, HttpStatus.OK);
    }
    
    @PostMapping("saveIssueAttachments")
    public ResponseEntity<?> saveIssueAttachments(@RequestParam("issueId") Long issueId,
    		@RequestParam("attachments") List<MultipartFile> attachments,
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
                    return ResponseEntity.badRequest().body("file size exceeded"); 
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "File upload failed");
            return ResponseEntity.badRequest().body("file upload failed"); 
        }

    	// Create a Map to hold the request parameters
        Map<String, Object> requestParams = new HashMap<>();
        requestParams.put("projectId", projectId);
        requestParams.put("issueId", issueId);
        requestParams.put("documentName", documentNames);
        requestParams.put("documentPath", documentPaths);
        
        // Convert the Map to a JsonNode using an ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.valueToTree(requestParams);
        
        
        // need to do error checking to see if project name is unique
        JsonNode node = izClient.saveIssueAttachment(jsonNode);
        
        return ResponseEntity.ok("called attachment method");
    }
	
	
}
