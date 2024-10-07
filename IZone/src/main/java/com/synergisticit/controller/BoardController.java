package com.synergisticit.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.synergisticit.client.IZoneClient;
import com.synergisticit.domain.Issue;
import com.synergisticit.domain.IssueStatus;
import com.synergisticit.domain.Project;

import jakarta.servlet.http.HttpSession;

@Controller
public class BoardController {
	@Autowired IZoneClient izClient;
	
    @PostMapping("board")
    public String postBoard(
            @RequestParam(value="projectName", required=true) String projectName, 
            @RequestParam(value="projectKey", required=true) String projectKey,
            HttpSession session,
            ModelMap model, 
            Principal principal) throws JsonProcessingException, IllegalArgumentException {
        if (principal == null) {
        	return "redirect:login";
        }
    	
        Map<String, Object> requestParams = new HashMap<>();
        requestParams.put("projectName", projectName);
        requestParams.put("projectKey", projectKey);
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode node = objectMapper.valueToTree(requestParams);
        
        JsonNode project = izClient.getPlan(node);
        
        if (project != null && (project.get("projectName") != null)) {
            Project p = objectMapper.treeToValue(project, Project.class);
            session.setAttribute("project", p);
            model.addAttribute("project", p);
            
            getIssues(model, session, principal);
            return "boardPage";
        }
        
        model.addAttribute("error", "Project Name OR project Key is Incorrect");
        return "actionPage";
    }
    
    @GetMapping("board")
    public String getBoard(HttpSession session, ModelMap model, Principal principal) {
    	Project p = (Project) session.getAttribute("project");
    	
        if (p != null) {
        	getIssues(model, session, principal);
            model.addAttribute("project", p);
            return "boardPage";
        }

        return "redirect:home"; 
    }
    
    public ModelMap getIssues(ModelMap mm, HttpSession session, Principal principal) {
    	Project p = (Project) session.getAttribute("project");
 	    Long projectId = p.getProjectId();
 	    
 	    // Fetch the JSON response as JsonNode
 	    JsonNode issueListNode = izClient.getIssuesByProjectId(projectId);
 	  
 	    
 	    ObjectMapper mapper = new ObjectMapper();
 	    mapper.registerModule(new JavaTimeModule());
	    List<Issue> todoIssues = new ArrayList<>();
	    List<Issue> inProgressIssues = new ArrayList<>();
	    List<Issue> doneIssues = new ArrayList<>();
 	    
 	    // Check if the JsonNode is an array
 	    if (issueListNode.isArray()) {
 	        for (JsonNode node : issueListNode) {
 	            // Convert each JsonNode item to an Issue object
 	            Issue issue = mapper.convertValue(node, Issue.class);
 	            if (issue.getIssueStatus() == IssueStatus.TODO) {
 	            	todoIssues.add(issue);
 	            	
 	            } else if (issue.getIssueStatus() == IssueStatus.INPROGRESS) {
 	            	inProgressIssues.add(issue);
 	            } else if (issue.getIssueStatus() == IssueStatus.DONE) {
 	            	doneIssues.add(issue);
 	            }
 	        }
 	    } else {
 	        // Handle the case where issueListNode is not an array
 	        System.out.println("Expected JSON array but received: " + issueListNode.toString());
 	    }
 	    
 	    
 	    mm.addAttribute("todoIssues", todoIssues);
	 	mm.addAttribute("inProgressIssues", inProgressIssues);
	 	mm.addAttribute("doneIssues", doneIssues);
 	    
 	    return mm;
    }
}
