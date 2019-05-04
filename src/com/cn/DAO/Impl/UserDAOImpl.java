package com.cn.DAO.Impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.UserDAO;
import com.cn.POJO.User;

public class UserDAOImpl extends HibernateDaoSupport implements UserDAO {

	@Override
	public User loginByUsername(User user) {
		String hql = "from User where username = ? and password = ?";
		List<User> query = (List<User>) this.getHibernateTemplate().find(hql, user.getUsername(), user.getPassword());
		
		if (query.size() > 0 && query != null) {
			return (User) query.get(0);
		}
		return null;
	}
	
	@Override
	public User loginByEmail(User user) {
		String hql = "from User where email = ? and password = ?";
		List<User> query = (List<User>) this.getHibernateTemplate().find(hql, user.getEmail(), user.getPassword());
		
		if (query.size() > 0) {
			return (User) query.get(0);
		}
		return null;
	}
	
	@Override
	public User loginByPhone(User user) {
		String hql = "from User where phone = ? and password = ?";
		List<User> query = (List<User>) this.getHibernateTemplate().find(hql,
				user.getPhone(), user.getPassword());
		
		if (query.size() > 0) {
			return (User) query.get(0);
		}
		return null;
	}

	@Override
	public void save(User user) {
		System.out.println("进入UserDaoImpl save");
		this.getHibernateTemplate().setCheckWriteOperations(false);
		this.getHibernateTemplate().save(user);
	}
	
	@Override
	public void update(User user) {
//		this.getHibernateTemplate().setCheckWriteOperations(false);
//		this.getHibernateTemplate().update(user);
		
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		try {
			session.flush();
			session.update(user);
			session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public User findByUsername(String username) {
		String hql = "from User where username = ?";
		List<User> query = (List<User>) this.getHibernateTemplate().find(hql, username);
		if (query.size() > 0) {
			return (User) query.get(0);
		}
		return null;
	}

	@Override
	public User findByEmail(String email) {
		String hql = "from User where email = ?";
		List<User> query = (List<User>) this.getHibernateTemplate().find(hql, email);
		if (query.size() > 0) {
			return (User) query.get(0);
		}
		return null;
	}

	@Override
	public User findByPhone(String phone) {
		String hql = "from User where phone = ?";
		List<User> query = (List<User>) this.getHibernateTemplate().find(hql, phone);
		if (query.size() > 0) {
			return (User) query.get(0);
		}
		return null;
	}
	
	@Override
	public User findByCode(String code) {
		String hql = "from User where code = ?";
		List<User> query = (List<User>) this.getHibernateTemplate().find(hql, code);
		if (query.size() > 0) {
			return (User) query.get(0);
		}
		return null;
	}
	
	@Override
	public User findByUid(String uid) {
		User query =  this.getHibernateTemplate().get(User.class, Integer.parseInt(uid));
		if (query != null) {
			return query;
		}
		return null;
	}
	

	@Override
	public List<User> SysUsersNoAdmin() {
		String hql = "from User where role <> 2";
		List<User> list = (List<User>) this.getHibernateTemplate().find(hql);
		return list;
	}

	@Override
	public void delete(User user) {
		this.getHibernateTemplate().setCheckWriteOperations(false);
		this.getHibernateTemplate().delete(user);
	}


	
}
