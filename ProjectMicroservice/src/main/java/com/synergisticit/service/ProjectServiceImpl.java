package com.synergisticit.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.domain.Project;
import com.synergisticit.repository.ProjectRepository;

@Service
public class ProjectServiceImpl implements ProjectService {
	@Autowired EmailService emailService;
	@Autowired ProjectRepository pRepo;

	@Override
	public Project save(JsonNode node) {
		
		String projectName = node.get("projectName").asText();
		String projectKey = node.get("projectKey").asText();
		String leadEmail = node.get("leadEmail").asText();
		
		JsonNode emailNode = node.get("userEmails");
		
		List<String> emailList = new ArrayList<>();
		for (int i = 0; i < emailNode.size(); i++) {
			emailList.add(emailNode.get(i).asText());
		}
		// set Project
		Project project = new Project(null, projectName, projectKey, leadEmail, emailList);
		Project saved = pRepo.save(project);
		
		// need to send email for each invited user uncomment when in use
		for (String email : emailList) {
			String subject = "You have been invited to " + projectName;
			String body = "Please create an account at IZONE. \nProject Key: " + projectKey;
			emailService.sendEmail(email, subject, body);
		}
		
		return saved;
	}


	@Override
	public Project getProject(JsonNode node) {
		String projectName = node.get("projectName").asText();
		String projectKey = node.get("projectKey").asText();
		
		return pRepo.findByProjectNameAndProjectKey(projectName, projectKey);
	}

	@Override
	public Project updateProject(JsonNode node) {
	    JsonNode projectKeyCheck = node.get("projectId");
	    String projectKey;
	    
	    JsonNode emailNode = node.get("userEmails");        
	    String projectName = node.get("projectName").asText();
	    Project p = pRepo.findByProjectName(projectName);
	    
	    // update project key if needed
	    if (projectKeyCheck != null) {
	        projectKey = projectKeyCheck.asText();
	        p.setProjectKey(projectKey);
	    } else {
	        projectKey = p.getProjectKey();
	    }
	    
	    // add new emails to list
	    List<String> originalEmailList = new ArrayList<>(p.getUserEmails()); // Create a copy of the original list
	    List<String> emailList = p.getUserEmails(); // This is the list to modify
	    
	    for (int i = 0; i < emailNode.size(); i++) {
	        String userEmail = emailNode.get(i).asText();
	        
	        if (!emailList.contains(userEmail)) {
	            emailList.add(userEmail); // Only modify the emailList
	        }
	    }
	    
	    // update project
	    Project saved = pRepo.save(p);
	    
	    // need to send email for each invited user uncomment when in use
	    for (String email : emailList) {
	        // project key has not changed
	        // skip original email list
	        if (projectKeyCheck == null && originalEmailList.contains(email)) {
	            continue;
	        }
	        String subject = "You have been invited to " + projectName;
	        String body = "Please create an account at IZONE. \nProject Key: " + projectKey;
	        emailService.sendEmail(email, subject, body);
	    }
	    
	    return saved;
	}


	@Override
	public Project deleteEmail(JsonNode node) {
		// delete case + update case
		JsonNode projectIdCheck = node.get("projectId");
		
		if (projectIdCheck != null) {
			Long projectId = projectIdCheck.asLong();
			Optional<Project> project = pRepo.findById(projectId);
			
			if (project.isEmpty()) return null;
			
			Project p = project.get();
			
			// reset user emails
			JsonNode emailNode = node.get("userEmails");
			List<String> emailList = new ArrayList<>();
			for (int i = 0; i < emailNode.size(); i++) {
				emailList.add(emailNode.get(i).asText());
			}
			
			p.setUserEmails(emailList);
			
			return pRepo.save(p);
		} 
		return null;
	}
}
