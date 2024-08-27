package com.synergisticit.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.synergisticit.client.IZoneClient;
import com.synergisticit.domain.Project;
import com.synergisticit.domain.User;
import com.synergisticit.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProjectController {
	@Autowired IZoneClient izClient;
	@Autowired UserService uService;
	
	@GetMapping("projectForm")
	public String getProjectForm(Project project, Model model) {
		return "projectForm";
	}

    @PostMapping("/saveProject")
    public String saveProject(Project project, HttpSession session, Model model, Principal principal) {
    	User u = uService.findUserByUsername(principal.getName());
    	
    	model.addAttribute(project);
    	// Create a Map to hold the request parameters
        Map<String, Object> requestParams = new HashMap<>();
        requestParams.put("projectName", project.getProjectName());
        requestParams.put("projectKey", project.getProjectKey());
        requestParams.put("userEmails", project.getUserEmails());
        requestParams.put("leadEmail", u.getUserEmail());
        // Convert the Map to a JsonNode using an ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.valueToTree(requestParams);
        
        
        // need to do error checking to see if project name is unique
        JsonNode node = izClient.saveProject(jsonNode);
        
        session.setAttribute("project", project);
        model.addAttribute("project", project);
        
        return "boardPage"; // Redirect to board
    }
}
