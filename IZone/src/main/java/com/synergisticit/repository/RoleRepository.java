package com.synergisticit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.synergisticit.domain.Role;

public interface RoleRepository extends JpaRepository<Role, Long> {
	@Query("SELECT COALESCE(MAX(r.roleId), 0) FROM Role r")
	Long getMaxId();
	
	Role findByRoleName(String name);
}
