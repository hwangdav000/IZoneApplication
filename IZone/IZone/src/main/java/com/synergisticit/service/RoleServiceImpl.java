package com.synergisticit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.synergisticit.domain.Role;
import com.synergisticit.repository.RoleRepository;

@Service
public class RoleServiceImpl implements RoleService{
	@Autowired RoleRepository roleRepository;

	@Override
	public Role save(Role role) {
		return roleRepository.save(role);
	}

	@Override
	public List<Role> findAll() {
		return roleRepository.findAll();
	}
	
	@Override
	public List<Role> findAll(String sortBy) {
		Sort sort = Sort.by(sortBy);
		return roleRepository.findAll(sort);
	}

	@Override
	public void delete(Long RoleId) {
		roleRepository.deleteById(RoleId);
	}

	@Override
	public Role findById(Long roleId) {
		
		Optional<Role> optionalRole = roleRepository.findById(roleId);
		if(optionalRole.isPresent()) {
			return optionalRole.get();
		}
		return null;
	}

	@Override
	public Role findByRoleName(String roleName) {
		return roleRepository.findByRoleName(roleName);
	}

}
