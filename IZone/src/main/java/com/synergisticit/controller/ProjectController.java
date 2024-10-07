package com.synergisticit.controller;

import java.security.Principal;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.synergisticit.client.IZoneClient;
import com.synergisticit.domain.Project;
import com.synergisticit.domain.Role;
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
	
	@GetMapping("projectEdit")
	public String getProjectEdit(Project project, Model model, HttpSession session, Principal p) {
		if (p == null) {
			return "redirect:login";
		}
		
		Project project1 = (Project) session.getAttribute("project");
		
		model.addAttribute("p", project1);
		
		return "projectEdit";
	}
	
	@PostMapping("/saveProjectEdit")
    public String saveProjectEdit(Project project, HttpSession session, Model model, Principal principal) {
    	if (principal == null) {
    		return "redirect:login";
    	}
    	
    	model.addAttribute(project);
    	
    	// Create a Map to hold the request parameters
        Map<String, Object> requestParams = new HashMap<>();
        
        requestParams.put("projectName", project.getProjectName());
        
        if (!project.getProjectKey().isEmpty()) {
        	requestParams.put("projectKey", project.getProjectKey());
        }
        
        if (!(project.getUserEmails().size() == 0)) {
        	// new user emails
            requestParams.put("userEmails", project.getUserEmails());
        }

        
        // Convert the Map to a JsonNode using an ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.valueToTree(requestParams);
        
        // need to do error checking to see if project name is unique
        JsonNode node = izClient.updateProject(jsonNode);
        
        session.setAttribute("project", project);
        model.addAttribute("project", project);
        
        return "projectEdit"; // Redirect to board
    }
	
	@RequestMapping("deleteProject")
	public String deletesProject(Project project, Model model) {
		// delete project
		// TODO
		
		return "redirect:login";
	}
	
	@RequestMapping("deleteEmail")
	public String deleteUserEmail(Project project, HttpSession session, Model model,
			@RequestParam String userEmail) {
		// delete email from project
		Project project1 = (Project) session.getAttribute("project");
		System.out.println(userEmail);
		List<String> emails = project1.getUserEmails();
		emails.remove(userEmail);
		
		System.out.println(Arrays.asList(emails));
		// Create a Map to hold the request parameters
        Map<String, Object> requestParams = new HashMap<>();
        requestParams.put("projectId", project.getProjectId());
        requestParams.put("userEmails", project.getUserEmails());
        
        // Convert the Map to a JsonNode using an ObjectMapper
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.valueToTree(requestParams);
        
        // need to do error checking to see if project name is unique
        JsonNode node = izClient.deleteEmail(jsonNode);
   
		return "redirect:projectEdit"; 
	}
	
	

    @PostMapping("/saveProject")
    public String saveProject(Project project, HttpSession session, Model model, Principal principal) {
    	if (principal == null) {
    		return "redirect:login";
    	}
    	
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
