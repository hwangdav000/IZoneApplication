package com.synergisticit.service;

import java.util.List;

import com.synergisticit.domain.User;

public interface UserService {
    User save(User user);
    User findById(Long userId);
    List<User> findAll();
    List<User> findAll(String sortBy);
    void deleteById(Long userId);
    User findUserByUsername(String username);
    Boolean findUserExists(String username);
    Boolean userIsRole(String username , String role);
   
}
