package com.synergisticit.util;

import java.util.Optional;

import org.springframework.data.domain.AuditorAware;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

public class AuditorAwareImpl implements AuditorAware<String> {

	@Override
	public Optional<String> getCurrentAuditor() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth == null || !auth.isAuthenticated()) {
			return null;
		}
		
		String user = ((UserDetails)auth.getPrincipal()).getUsername();
		return Optional.of(user);
	}

}
