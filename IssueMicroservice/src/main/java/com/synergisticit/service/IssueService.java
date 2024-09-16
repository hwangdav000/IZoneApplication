package com.synergisticit.service;

import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.domain.Issue;

public interface IssueService {
	Issue save(JsonNode node);
	Issue update(JsonNode node, Long issueId);
	Issue saveAttachment(JsonNode node);
	List<Issue> findAll();
	List<Issue> findByStatus(String status, String name);
	List<Issue> findByProjectId(Long projectId);
	Issue saveComment(JsonNode node);
	Issue findById(Long issueId);
	void delete(Long issueId);
	
}
