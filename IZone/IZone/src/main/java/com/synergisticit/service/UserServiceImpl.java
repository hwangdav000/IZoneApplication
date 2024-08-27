package com.synergisticit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.synergisticit.domain.Role;
import com.synergisticit.domain.User;
import com.synergisticit.repository.UserRepository;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserRepository userRepository ;
	
	@Autowired BCryptPasswordEncoder bCrypt;

	@Override
	public User save(User user) {
		user.setUserPassword(bCrypt.encode(user.getUserPassword()));
		
		return userRepository.save(user);
	}

	@Override
	public User findById(Long userId) {
		Optional<User> optUser = userRepository.findById(userId);
		if(optUser.isPresent()) {
			return optUser.get();
		}
		return null;
	}
	
	@Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

	@Override
	public List<User> findAll(String sortBy) {
		Sort sort = Sort.by(sortBy);
		return userRepository.findAll(sort);
	}

	@Override
	public void deleteById(Long userId) {
		userRepository.deleteById(userId);
	}

	@Override
	public User findUserByUsername(String username) {
		return userRepository.findByUsername(username);
	}
	
	@Override
	public Boolean findUserExists(String username) {
		if (userRepository.findByUsername(username) != null) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public Boolean userIsRole(String username, String role) {
		User u = this.findUserByUsername(username);
		List<Role> roles = u.getUserRoles();
		
		for (Role r : roles) {
			if (r.getRoleName().equals(role)) {
				return true;
			}
		}
		return false;
	}

}
