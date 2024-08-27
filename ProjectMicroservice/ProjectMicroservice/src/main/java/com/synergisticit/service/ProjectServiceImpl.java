package com.synergisticit.service;

import java.util.ArrayList;
import java.util.List;

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
//		for (String email : emailList) {
//			String subject = "You have been invited to " + projectName;
//			String body = "Please create an account at IZONE. \nProject Key: " + projectKey;
//			emailService.sendEmail(email, subject, body);
//		}
		
		return saved;
	}

	@Override
	public Project update(JsonNode node) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Project getProject(JsonNode node) {
		String projectName = node.get("projectName").asText();
		String projectKey = node.get("projectKey").asText();
		
		return pRepo.findByProjectNameAndProjectKey(projectName, projectKey);
	}
}
