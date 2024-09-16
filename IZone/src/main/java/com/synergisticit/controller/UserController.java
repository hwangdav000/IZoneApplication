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
	
	@RequestMapping("userSettingPage")
	public String userSettingForm(User user, ModelMap mm, Principal p) {
		if (p == null) {
			return "redirect:login";
		}
		getModel(mm, p);
		
		return "userSettingPage";
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
	
	@RequestMapping("saveUserSettingPage")
	public String saveUserSettingPage(@Valid User user, BindingResult br, ModelMap mm, Principal p) {
		uValidator.validate(user,  br);
		
		if (user != null && user.getUserId() == 0L) {
			mm.addAttribute("error", "unable to save changes");
			return "userSettingPage";
		}	
		
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
			
			return "userSettingPage";
		}
		
		userService.save(user);
		
		if ((p != null) && (userService.userIsRole(p.getName(), "ADMIN"))) {
			return "redirect:userSettingPage";
		} else {
			return "redirect:login";
		}
	}
	
	@RequestMapping("updateUserSettingPage")
	public String updateUserSettingPage(User user, ModelMap mm, Principal p) {

		
		getModel(mm, p);
		
		User retrievedUser = userService.findById(user.getUserId());
		mm.addAttribute("u", retrievedUser);
		mm.addAttribute("retrievedRoles",retrievedUser.getUserRoles());
		
		return "userSettingPage";
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
	
	@RequestMapping("deleteUserSettingPage")
	public String deleteUserSettingPage(User user, ModelMap mm, Principal p) {
		
		userService.deleteById(user.getUserId());
		getModel(mm, p);
	
		return "userSettingPage"; 
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
