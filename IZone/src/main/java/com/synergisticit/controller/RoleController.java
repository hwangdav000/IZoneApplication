package com.synergisticit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.synergisticit.domain.Role;
import com.synergisticit.service.RoleService;

@Controller
public class RoleController {
	
	@Autowired RoleService roleService;
	
	@RequestMapping("roleForm")
	public String roleForm(Role role, Model model) {

		List<Role> roles = roleService.findAll();
		model.addAttribute("roles", roles);
		
		return "roleForm";
	}
	
	@RequestMapping("saveRole")
	public String savesTheRole(Role role, Model model) {
		
		roleService.save(role);
		List<Role> roles = roleService.findAll();
		model.addAttribute("roles", roles);
		
		
		return "roleForm";
	}
	
	@RequestMapping("deleteRole")
	public String deletesTheRole(Role role, Model model) {
		roleService.delete(role.getRoleId());
		List<Role> roles = roleService.findAll();
		model.addAttribute("roles", roles);
		
		return "roleForm";
	}
	
	@RequestMapping("updateRole")
	public String updatesTheRole(Role role, Model model) {
		Role r = roleService.findById(role.getRoleId());
		model.addAttribute("r", r);
		
		List<Role> roles = roleService.findAll();
		model.addAttribute("roles", roles);
		
		return "roleForm";
	}

}
