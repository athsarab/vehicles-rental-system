package services;

import models.UserModel;

import java.util.List;
import java.util.Map;

import dao.UserDao;

public class UserService {
    private UserDao userDao;

    public UserService() {
        this.userDao = new UserDao(); // Initialize UserDao (Assuming you have UserDao class)
    }

    public Map<String,String> login(String email, String password) {
        // Add logic to validate login credentials
        return userDao.validateUser(email, password);
    }

    public boolean createUser(UserModel user) {
        // Add logic to create a new user
        return userDao.createUser(user);
    }

    public boolean updateUser(UserModel user) {
        // Add logic to update user information
        return userDao.updateUser(user);
    }

    public boolean deleteUser(String email) {
        // Add logic to delete user
        return userDao.deleteUser(email);
    }

    public UserModel getUserByEmail(String email) {
        // Retrieve user from the database by email
        return userDao.getUserByEmail(email);
    }
    
    public List<UserModel> getAllUsers(){
    	return userDao.getAllUsers();
    }
}
