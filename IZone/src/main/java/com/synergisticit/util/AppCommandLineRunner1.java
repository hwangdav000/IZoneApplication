package com.synergisticit.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.synergisticit.domain.User;
import com.synergisticit.domain.Role;
import com.synergisticit.repository.UserRepository;
import com.synergisticit.service.RoleService;
import com.synergisticit.service.UserService;
import com.synergisticit.repository.RoleRepository;

@Component
public class AppCommandLineRunner1 implements CommandLineRunner {

	@Autowired
	UserRepository uRepo;
	@Autowired
	RoleRepository rRepo;
	
	@Autowired
	UserService uService;
	@Autowired
	RoleService rService;
	
	@Override
	public void run(String... args) throws Exception {
		// CRUD operations
		if (uService.findById(1L) == null || uService.findById(1L) == null) {
			
			Role rAdmin = new Role(1L, "ADMIN", new ArrayList<>());
			Role rUser= new Role(2L, "USER", new ArrayList<>());
			List<Role> rList = new ArrayList<>();
			rList.add(rAdmin);
			
			User uDavid = new User(1L, "david", "password", "david@gmail.com", rList);
			
			List<Role> rList2 = new ArrayList<>();
			rList2.add(rUser);
			User uJoe = new User(2L, "joe", "password", "joe@gmail.com", rList2);
					
			// save role
			rService.save(rAdmin);
			rService.save(rUser);
			
			// save user
			uService.save(uDavid);
			uService.save(uJoe);
		
		}
	}
}
