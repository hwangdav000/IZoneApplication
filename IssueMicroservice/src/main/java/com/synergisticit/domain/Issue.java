package com.synergisticit.domain;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Issue {
	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	Long issueId;
	Long projectId;
	
	String assignee;
	String reporter;
	
	@Enumerated(EnumType.STRING)
	private IssueType issueType;
	
	@Enumerated(EnumType.STRING)
	private Priority priority;
	
	@Enumerated(EnumType.STRING)
	private IssueStatus issueStatus;
	
	String issueName;
	String issueSummary;
	@DateTimeFormat(iso=DateTimeFormat.ISO.DATE_TIME)
	private LocalDateTime createdDateTime;
	
	@OneToMany(mappedBy = "commentIssue")
	private List<Comment> comments = new ArrayList<>();
	@OneToMany(mappedBy = "documentIssue")
	private List<Document> documents = new ArrayList<>();
}
