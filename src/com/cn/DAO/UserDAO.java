package com.cn.DAO;

import java.util.List;

import com.cn.POJO.User;

public interface UserDAO {

	//用户名登录方法
	public User loginByUsername(User user);
	//用户邮箱登录方法
	public User loginByEmail(User user);
	//用户手机号登录方法
	public User loginByPhone(User user);
	
	//用户注册功能
	public void save(User user);
	
	// 用户删除方法
	public void delete(User user);
	
	//按用户名查询是否有该用户
	public User findByUsername(String username);
	
	//按邮箱查询是否有该用户
	public User findByEmail(String email);
	
	//按手机号查询是否有该用户
	public User findByPhone(String phone);
	
	//按code查询用户
	public User findByCode(String code);
	
	//按Uid查询用户
	public User findByUid(String uid);
	
	//更改账户信息
	public void update(User user);
	
	//查询所有非管理员用户
	public List<User> SysUsersNoAdmin();
	
}
