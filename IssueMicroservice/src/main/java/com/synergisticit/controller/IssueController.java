package com.synergisticit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.synergisticit.domain.Issue;
import com.synergisticit.service.IssueService;

@RestController
public class IssueController {
	
	@Autowired IssueService iService;
	
	@RequestMapping(value="/saveIssue", method=RequestMethod.POST)
	public Issue saveIssue(@RequestBody JsonNode node) {
		return iService.save(node);
	}
	
	@RequestMapping(value="/updateIssue/{issueId}", method=RequestMethod.POST)
	public Issue updateIssue(@RequestBody JsonNode node, @PathVariable Long issueId) {
		return iService.update(node, issueId);
	}
	
	@RequestMapping(value="/saveIssueAttachment", method=RequestMethod.POST)
	public Issue saveIssueAttachment(@RequestBody JsonNode node) {
		return iService.saveAttachment(node);
	}
	
	@RequestMapping(value="/saveComment", method=RequestMethod.POST)
	public Issue saveComment(@RequestBody JsonNode node) {
		return iService.saveComment(node);
	}
	
	
	@RequestMapping(value="/getIssue/{issueId}", method=RequestMethod.GET)
	public JsonNode getIssueById(@PathVariable Long issueId) {
		Issue issue = iService.findById(issueId);
		
		ObjectMapper mapper = new ObjectMapper();
		mapper.registerModule(new JavaTimeModule());
	    JsonNode issueNode = mapper.valueToTree(issue);
		return issueNode;
	}
	
	
	@RequestMapping(value="/getIssues", method=RequestMethod.GET)
	public List<Issue> getIssue() {
		return iService.findAll();
	}
	
	@RequestMapping(value="/getIssues/{projectId}", method=RequestMethod.GET)
	public JsonNode getIssue(@PathVariable Long projectId) {
		
		List<Issue> issues = iService.findByProjectId(projectId);
		// Convert the List<Issue> to a JsonNode
		ObjectMapper mapper = new ObjectMapper();
		mapper.registerModule(new JavaTimeModule());
	    JsonNode issueListNode = mapper.valueToTree(issues);
	    
	    
		return issueListNode;
	}
	

}
