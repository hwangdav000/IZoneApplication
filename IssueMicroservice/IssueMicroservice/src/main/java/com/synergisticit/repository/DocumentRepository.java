package com.synergisticit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.synergisticit.domain.Document;
@Repository
public interface DocumentRepository extends JpaRepository<Document, Long>{

}
