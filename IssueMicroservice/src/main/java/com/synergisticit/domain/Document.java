package com.synergisticit.domain;

import java.time.LocalDateTime;
import java.util.List;

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
@Entity
public class Document {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Long documentId;

    String documentName;
    String documentPath;

    @ManyToOne
    @JoinColumn(name = "documents") // Assuming you're sticking with the default convention
    @JsonBackReference
    private Issue documentIssue;

    // Constructor without documentIssue
    public Document(Long documentId, String documentName, String documentPath) {
        this.documentId = documentId;
        this.documentName = documentName;
        this.documentPath = documentPath;
    }
}
