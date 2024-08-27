package com.synergisticit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.synergisticit.domain.User;

public interface UserRepository extends JpaRepository<User, Long> {
	@Query("SELECT COALESCE(MAX(u.userId), 0) FROM User u")
	Long getMaxId();
	
	User findByUsername(String username);
}
