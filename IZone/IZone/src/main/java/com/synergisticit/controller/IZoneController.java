package com.synergisticit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.client.IZoneClient;

@RestController
public class IZoneController {
	@Autowired IZoneClient izClient;
	
	@GetMapping("issues/{issueId}")
	public JsonNode getIssues(@PathVariable Long issueId) {
		return izClient.getIssueById(issueId);
	}
	
	
}
