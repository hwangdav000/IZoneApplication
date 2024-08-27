package com.synergisticit.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.synergisticit.domain.Issue;

@Repository
public interface IssueRepository extends JpaRepository<Issue, Long>{
	List<Issue> findByProjectId(Long projectId);
}
