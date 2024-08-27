package com.synergisticit.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.synergisticit.domain.Role;
import com.synergisticit.domain.User;
import com.synergisticit.service.RoleService;
import com.synergisticit.service.UserService;

import jakarta.validation.Valid;

@Controller
public class UserController {
	
	@Autowired RoleService roleService;
	@Autowired UserService userService;

	
	
	@RequestMapping("userForm")
	public String userForm(User user, Model model) {
		
		model.addAttribute("roles", roleService.findAll());
		model.addAttribute("users", userService.findAll());
		return "userForm";
	}
	
	@RequestMapping("saveUser")
	public String savesTheUser(User user, Model model, Principal principal) {
		if (principal == null) {
			Role r = roleService.findByRoleName("USER");
			List<Role> rList = new ArrayList<>();
			rList.add(r);
			user.setUserRoles(rList);
		}
		// make sure to add validation later
		
		model.addAttribute("roles", roleService.findAll());
		model.addAttribute("users", userService.findAll());
		return "redirect:login";
		
	}
	
	
	@RequestMapping("updateUser")
	public String updateTheUser(User user, Model model) {

		
		User retrievedUser = userService.findById(user.getUserId());
		model.addAttribute("roles", roleService.findAll());
		model.addAttribute("users", userService.findAll());
		model.addAttribute("u", retrievedUser);
		model.addAttribute("retrievedRoles",retrievedUser.getUserRoles());
		return "userForm";
	}

	@RequestMapping("deleteUser")
	public String deletesTheUser(User user, Model model) {
		
		userService.deleteById(user.getUserId());
		model.addAttribute("roles", roleService.findAll());
		model.addAttribute("users", userService.findAll());
	
		return "userForm"; 
	}
}
