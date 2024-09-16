package com.synergisticit.validation;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.synergisticit.domain.User;


@Component
public class UserValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return User.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
	    User user = (User)target;
	    
	    if (user.getUsername() == null) {
			errors.rejectValue("username", "username.value","username is required");
		}
		
		if (user.getUserPassword() == null) {
			errors.rejectValue("userPassword", "userPassword.value","Password is required");
		}
		
		if (user.getUserEmail() == null) {
			errors.rejectValue("userEmail", "userEmail.value","Email is required");
		}
     
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "username.value", "username is empty");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userPassword", "password.value", "password is empty");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "userEmail", "email.value", "email is empty");
     
	}

}
