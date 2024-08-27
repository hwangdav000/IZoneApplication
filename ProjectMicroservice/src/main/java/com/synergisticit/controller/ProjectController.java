package com.synergisticit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.domain.Project;
import com.synergisticit.service.ProjectService;

@RestController
public class ProjectController {
	
	@Autowired ProjectService pService;
	
	@RequestMapping(value="/saveProject", method=RequestMethod.POST)
	public Project saveProject(@RequestBody JsonNode node) {
		return pService.save(node);
	}
	
	@RequestMapping(value="/getProject", method=RequestMethod.POST)
	public Project getProject(@RequestBody JsonNode node) {
		return pService.getProject(node);
	}
	
//	@RequestMapping(value="/updateProject", method=RequestMethod.PUT)
//	public ProjectupdateProjectItems(@RequestBody JsonNode node) {
//		return pService.updateProjectItems(node);
//	}
}
