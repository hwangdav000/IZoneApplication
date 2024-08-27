package com.synergisticit.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.synergisticit.domain.Project;

public interface ProjectService {
	Project save(JsonNode node);
	Project getProject(JsonNode node);
	Project update(JsonNode node);
}
