package com.cn.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.cn.DAO.UserDAO;
import com.cn.POJO.User;

@Transactional
//用户模块业务层代码
public class UserService {

	private UserDAO userDAO;
	public UserDAO getUserDAO() {
		return userDAO;
	}
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	//用户登录业务实现
	public User login(User user){
		User login = null;
		login = userDAO.loginByUsername(user);
		if (login != null) {
			return login;
		}else {
			login = userDAO.loginByEmail(user);
			if (login != null) {
				return login;
			}
		}
		return userDAO.loginByPhone(user);
	}
	
	//用户注册业务实现
	public void register(User user){
		System.out.println("进入UserService save");
		userDAO.save(user);
	}
	
	//查询用户名、邮箱、手机号是否可用
	public User findByWhat(String method, String parameter){
		if ("username".equals(method)) {
			return userDAO.findByUsername(parameter);
		}else if ("email".equals(method)) {
			return userDAO.findByEmail(parameter);
		}else if("phone".equals(method)) {
			return userDAO.findByPhone(parameter);
		}else if("uid".equals(method)){
			return userDAO.findByUid(parameter);
		}else {
			return userDAO.findByCode(parameter);
		}
	}
	
	//账户更新
	public void update(User user){
		userDAO.update(user);
	}
	
	//查询所有非管理员用户
	public List<User> SysUsersNoAdmin(){
		return userDAO.SysUsersNoAdmin();
	}
	
	public User findByUid(String uid){
		return userDAO.findByUid(uid);
	}
	
	public void deleteUser(User user){
		userDAO.delete(user);
	}
}
