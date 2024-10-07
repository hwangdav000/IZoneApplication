package com.synergisticit.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.synergisticit.domain.Role;
import com.synergisticit.domain.User;
import com.synergisticit.service.RoleService;
import com.synergisticit.service.UserService;
import com.synergisticit.validation.UserValidator;

import jakarta.validation.Valid;

@Controller
public class UserController {
	
	@Autowired RoleService roleService;
	@Autowired UserService userService;

	@Autowired UserValidator uValidator;
	
	@RequestMapping("userForm")
	public String userForm(User user, Model model) {
		
		model.addAttribute("roles", roleService.findAll());
		model.addAttribute("users", userService.findAll());
		return "userForm";
	}
	
	@RequestMapping("userEdit")
	public String userEditForm(User user, ModelMap mm, Principal p) {
		if (p == null) {
			return "redirect:login";
		}
		
		getModel(mm, p);
		
		User u = userService.findUserByUsername(p.getName());
		mm.addAttribute("u", u);
		
		return "userEdit";
	}
	
	
	@RequestMapping("saveUser")
	public String savesTheUser(User user, Model model, Principal principal) {
		if (principal == null) {
			Role r = roleService.findByRoleName("USER");
			List<Role> rList = new ArrayList<>();
			rList.add(r);
			user.setUserRoles(rList);
		}
		
		userService.save(user);
		
		return "redirect:login";
	}
	
	@RequestMapping("saveUserEdit")
	public String saveUserEdit(@Valid User user, BindingResult br, ModelMap mm, Principal p) {
		uValidator.validate(user,  br);
		
		if (user != null && user.getUserRoles().size() == 0) {
			Role r = roleService.findByRoleName("USER");
			List<Role> rList = new ArrayList<>();
			rList.add(r);
			user.setUserRoles(rList);
		}
		
		if (br.hasErrors()) {
			
			if ((p != null) && (userService.userIsRole(p.getName(), "USER"))) {
				List<User> uList = new ArrayList<>();
				User u = userService.findUserByUsername(user.getUsername());
				uList.add(u);
				getModel(mm, p);
				
				
			}  else {
				getModel(mm, p);
			}
			
			return "userEdit";
		}
		
		userService.save(user);
		
		if ((p != null) && (userService.userIsRole(p.getName(), "ADMIN"))) {
			return "redirect:userEdit";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("updateUserEdit")
	public String updateUserEdit(User user, ModelMap mm, Principal p) {

		
		getModel(mm, p);
		
		User retrievedUser = userService.findById(user.getUserId());
		mm.addAttribute("u", retrievedUser);
		mm.addAttribute("retrievedRoles",retrievedUser.getUserRoles());
		
		return "userEdit";
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
	
	@RequestMapping("deleteUserEdit")
	public String deleteUserEdit(User user, ModelMap mm, Principal p) {
		User u = userService.findUserByUsername(p.getName());
		
		userService.deleteById(user.getUserId());
		getModel(mm, p);
	
		if ((p != null) && (userService.userIsRole(p.getName(), "ADMIN"))) {
			// if delete own account redirect to login
			if (u.getUsername().equals(p.getName())) {
				return "redirect:login";
			} else {
				return "redirect:userEdit";
			}
			
		} else {
			return "redirect:login";
		}
	}

	@RequestMapping("deleteUser")
	public String deletesTheUser(User user, Model model) {
		
		userService.deleteById(user.getUserId());
		model.addAttribute("roles", roleService.findAll());
		model.addAttribute("users", userService.findAll());
	
		return "userForm"; 
	}
	
	public ModelMap getModel(ModelMap mm, Principal p) {
		if ((p != null) && (userService.userIsRole(p.getName(), "USER"))) {
			List<User> uList = new ArrayList<>();
			User u = userService.findUserByUsername(p.getName());
			uList.add(u);
			mm.addAttribute("roles", roleService.findAll());
			mm.addAttribute("users", uList);
			
		}  else {
			
			mm.addAttribute("roles", roleService.findAll());
			mm.addAttribute("users", userService.findAll());
		}
	
		return mm;
	}
	
}
