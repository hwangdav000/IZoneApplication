package com.synergisticit.config;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;


@EnableMethodSecurity(prePostEnabled = true, securedEnabled = true)
@Configuration
public class SecurityConfig {
	
	@Autowired DataSource dataSource;
	@Autowired BCryptPasswordEncoder bCrypt;
	@Autowired UserDetailsService userDetailsService;
	
	
	@Qualifier(value="ash1")
	@Autowired AuthenticationSuccessHandler ash;
	@Autowired AccessDeniedHandler accessDeniedHandler;
	
	@Bean
	DaoAuthenticationProvider authProvider() {
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
		authProvider.setUserDetailsService(userDetailsService);
		authProvider.setPasswordEncoder(bCrypt);
		return authProvider;
	}
	
	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
	    http.csrf().disable()
	    	.authorizeRequests()
	    	.requestMatchers(AntPathRequestMatcher.antMatcher("/")).permitAll()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/")).permitAll().and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/home")).permitAll().and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/userForm")).permitAll().and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/roleForm")).hasAnyAuthority("ADMIN").and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/actionPage")).hasAnyAuthority("ADMIN", "USER").and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/projectForm")).hasAnyAuthority("ADMIN", "USER").and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/boardPage")).hasAnyAuthority("ADMIN", "USER").and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/issueForm")).hasAnyAuthority("ADMIN", "USER").and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/issuePage")).hasAnyAuthority("ADMIN", "USER").and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/userEdit")).hasAnyAuthority("ADMIN", "USER").and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/projectEdit")).hasAnyAuthority("ADMIN", "USER").and().authorizeRequests()
	        .requestMatchers(AntPathRequestMatcher.antMatcher("/issues/**")).hasAnyAuthority("ADMIN", "USER").and().authorizeRequests()
	        .and()
	        .httpBasic(Customizer.withDefaults())
	        .formLogin()
	        	.loginPage("/login")
	        	.successHandler(ash)
		    .and()
	        .logout() 
	           // .logoutSuccessUrl("/home") 
	            .invalidateHttpSession(true)
	            .deleteCookies("JSESSIONID")
            .and()
            .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED);
	        
	    http.userDetailsService(userDetailsService);
	    return http.build();
	}

}

