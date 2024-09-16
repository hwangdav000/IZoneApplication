package com.synergisticit.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.domain.Comment;
import com.synergisticit.domain.Document;
import com.synergisticit.domain.Issue;
import com.synergisticit.domain.IssueStatus;
import com.synergisticit.domain.IssueType;
import com.synergisticit.domain.Priority;
import com.synergisticit.repository.CommentRepository;
import com.synergisticit.repository.DocumentRepository;
import com.synergisticit.repository.IssueRepository;

import jakarta.persistence.Embedded;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;

@Service
public class IssueServiceImpl implements IssueService {

	@Autowired IssueRepository iRepo;
	@Autowired DocumentRepository dRepo;
	@Autowired CommentRepository cRepo;
	
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
	
	@Override
	public Issue update(JsonNode node, Long issueId) {
		
		Issue issue = findById(issueId);
		
		IssueType issueType = IssueType.valueOf(node.get("issueType").asText());
		String assignee= node.get("assignee").asText();
		Priority priority= Priority.valueOf(node.get("priority").asText());
		IssueStatus issueStatus= IssueStatus.valueOf(node.get("issueStatus").asText());
		String issueName= node.get("issueName").asText();
		String issueSummary= node.get("issueSummary").asText();
		
		issue.setIssueType(issueType);
		issue.setAssignee(assignee);
		issue.setPriority(priority);
		issue.setIssueStatus(issueStatus);
		issue.setIssueName(issueName);
		issue.setIssueSummary(issueSummary);
		
		return iRepo.save(issue);
	}
	
	@Override
	public Issue saveAttachment(JsonNode node) {
		System.out.println("save attachment in issue");
		Long issueId = node.get("issueId").asLong();
		JsonNode documentNameNode = node.get("documentName");
		JsonNode documentPathNode = node.get("documentPath");
		List<Document> documents = new ArrayList<>();
		
		Issue issue = findById(issueId);
		
		for (int i = 0; i < documentNameNode.size(); i++) {
			String docName = documentNameNode.get(i).asText();
			String docPath = documentPathNode.get(i).asText();
			System.out.println("doc path" + docPath);
			
			Document document = new Document(null, docName, docPath);
			document.setDocumentIssue(issue);
			
			documents.add(dRepo.save(document));
		}
		
		
		issue.getDocuments().addAll(documents);
		
		return iRepo.save(issue);
	}
	
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



	@Override
	public Issue saveComment(JsonNode node) {
		Long issueId = node.get("issueId").asLong();
        String submitter = node.get("submitter").asText();
        String content = node.get("content").asText();
        LocalDateTime createdDateTime = LocalDateTime.now();

        Optional<Issue> issueOptional = iRepo.findById(issueId);
        if (issueOptional.isPresent()) {
            Issue issue = issueOptional.get();

            Comment comment = new Comment();
            comment.setSubmitter(submitter);
            comment.setContent(content);
            comment.setCreatedDateTime(createdDateTime);
            comment.setCommentIssue(issue);
            cRepo.save(comment);

            return issue;
        } else {
            throw new IllegalArgumentException("Issue not found with id: " + issueId);
        }
    }

	

}
