package com.synergisticit.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.domain.Document;
import com.synergisticit.domain.Issue;
import com.synergisticit.domain.IssueStatus;
import com.synergisticit.domain.IssueType;
import com.synergisticit.domain.Priority;
import com.synergisticit.repository.DocumentRepository;
import com.synergisticit.repository.IssueRepository;

import jakarta.persistence.Embedded;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;

@Service
public class IssueServiceImpl implements IssueService {

	@Autowired IssueRepository iRepo;
	@Autowired DocumentRepository dRepo;
	
	@Override
	public Issue save(JsonNode node) {
		IssueType issueType = IssueType.valueOf(node.get("issueType").asText());
		Long projectId = node.get("projectId").asLong();
		String assignee= node.get("assignee").asText();
		String reporter= node.get("reporter").asText();
		Priority priority= Priority.valueOf(node.get("priority").asText());
		IssueStatus issueStatus= IssueStatus.valueOf(node.get("issueStatus").asText());
		String issueName= node.get("issueName").asText();
		String issueSummary= node.get("issueSummary").asText();
		LocalDateTime createdDateTime= LocalDateTime.now();
		
		
		JsonNode documentNameNode = node.get("documentName");
		JsonNode documentPathNode = node.get("documentPath");
		List<Document> documents = new ArrayList<>();
		for (int i = 0; i < documentNameNode.size(); i++) {
			String docName = documentNameNode.get(i).asText();
			String docPath = documentPathNode.get(i).asText();
			
			documents.add(dRepo.save(new Document(null, docName, docPath)));
		}
		
		Issue issue = new Issue(null, projectId, assignee, reporter, issueType, priority, issueStatus,
				issueName, issueSummary, createdDateTime, null, documents);
		
		return iRepo.save(issue);
		
	}
	
	
	
//	List<Comment> comments = new ArrayList<>();
//	
//	JsonNode commentNode = node.get("comments");
//	for (int i = 0; i < commentNode.size(); i++) {
//		String submitter = commentNode.get(i).get("submitter").asText();
//		String content = commentNode.get(i).get("content").asText();
//		
//		comments.add(new Comment(submitter, content));
//	}
	@Override
	public List<Issue> findAll() {
		
		return iRepo.findAll();
	}

	@Override
	public List<Issue> findByStatus(String status, String name) {
		return null;
	}

	@Override
	public Issue findById(Long issueId) {
		return iRepo.findById(issueId).get();
	}

	@Override
	public void delete(Long issueId) {
		iRepo.deleteById(issueId);
	}



	@Override
	public List<Issue> findByProjectId(Long projectId) {
		return iRepo.findByProjectId(projectId);
	}

}
