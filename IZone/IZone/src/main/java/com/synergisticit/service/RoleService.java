package com.synergisticit.service;
import java.util.List;

import com.synergisticit.domain.Role;
import com.synergisticit.domain.User;


public interface RoleService {
	 
		Role save(Role role);
		List<Role> findAll();
		List<Role> findAll(String sortBy);
		Role findById(Long roleId);
		void delete(Long RoleId);
		Role findByRoleName(String roleName);
}
