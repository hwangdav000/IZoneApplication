package com.synergisticit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.synergisticit.domain.Comment;
@Repository
public interface CommentRepository extends JpaRepository<Comment, Long>{

}
