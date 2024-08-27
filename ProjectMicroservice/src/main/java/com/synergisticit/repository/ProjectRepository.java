package com.synergisticit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.synergisticit.domain.Project;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Long>{
	
	Project findByProjectNameAndProjectKey(String projectName, String projectKey);
}
