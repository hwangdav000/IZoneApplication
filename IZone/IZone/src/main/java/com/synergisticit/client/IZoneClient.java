package com.synergisticit.client;


import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

@Component
public class IZoneClient {
	private static final String issueMicroURL= "http://localhost:8484/";
	private static final String managementMicroURL= "http://localhost:8383/";
	
	public JsonNode saveProject(JsonNode node) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<String> request = new HttpEntity<String>(node.toString(), headers);	
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Object> responseEntity = restTemplate.postForEntity(managementMicroURL + "saveProject", request, Object.class);
		Object objects = responseEntity.getBody();
		
		ObjectMapper mapper = new ObjectMapper();
		
		JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
		return returnObj;
	}
	
	public JsonNode getPlan(JsonNode node) {
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    HttpEntity<String> request = new HttpEntity<>(node.toString(), headers);    

	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<Object> responseEntity = restTemplate.postForEntity(managementMicroURL + "getProject", request, Object.class);
	    Object objects = responseEntity.getBody();
	    
	    ObjectMapper mapper = new ObjectMapper();
	    
	    JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
	    return returnObj;
	}
	
	public JsonNode saveIssue(JsonNode node) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<String> request = new HttpEntity<String>(node.toString(), headers);	
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Object> responseEntity = restTemplate.postForEntity(issueMicroURL + "saveIssue", request, Object.class);
		Object objects = responseEntity.getBody();
		
		ObjectMapper mapper = new ObjectMapper();
		
		JsonNode returnObj = mapper.convertValue(objects, JsonNode.class);
		return returnObj;
	}
	
	public JsonNode getIssuesByProjectId(Long projectId) {
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> responseEntity = restTemplate.getForEntity(issueMicroURL + "getIssues/" + projectId, String.class);
	    
	    ObjectMapper mapper = new ObjectMapper();
	    // Register JavaTimeModule to handle LocalDateTime and other Java 8 date/time types
	    mapper.registerModule(new JavaTimeModule());
	    
	    JsonNode returnObj = null;
	    try {
	        // Convert JSON string to JsonNode
	        returnObj = mapper.readTree(responseEntity.getBody());
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return returnObj;
	}
	
	public JsonNode getIssueById(Long issueId) {
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> responseEntity = restTemplate.getForEntity(issueMicroURL + "getIssue/" + issueId, String.class);
	    ObjectMapper mapper = new ObjectMapper();
	    
	    // Register JavaTimeModule to handle LocalDateTime and other Java 8 date/time types
	    mapper.registerModule(new JavaTimeModule());
	    
	    JsonNode returnObj = null;
	    try {
	        // Convert JSON string to JsonNode
	        returnObj = mapper.readTree(responseEntity.getBody());
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
		return returnObj;
	}
	
}