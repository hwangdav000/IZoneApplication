package com.synergisticit.domain;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Comment {

	@Id
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	Long commentId;
	
	String submitter;
	String content;
	
	@DateTimeFormat(iso=DateTimeFormat.ISO.DATE_TIME)
	private LocalDateTime createdDateTime;
	
	@ManyToOne
    @JoinColumn(name = "comments")
	@JsonBackReference
    private Issue commentIssue;
	
	public Comment(Long cId, String sub, String content, LocalDateTime dt) {
		this.commentId = cId;
		this.submitter = sub;
		this.content = content;
		this.createdDateTime = dt;
	}
}
