package com.cn.DAO.Impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.MessageDAO;
import com.cn.POJO.Message;

public class MessageDAOImpl extends HibernateDaoSupport implements MessageDAO {

	@Override
	public List<Message> findAllMessages() {
		String hql = "from Message";
		return (List<Message>) this.getHibernateTemplate().find(hql);
	}

	@Override
	public List<Message> findMessagesByUid(String uid) {
		String hql = "from Message where uid = ?";
		return (List<Message>) this.getHibernateTemplate().find(hql, uid);
	}

	@Override
	public void delete(Message message) {
		this.getHibernateTemplate().delete(message);
	}

	@Override
	public void save(Message message) {
		this.getHibernateTemplate().save(message);
	}

	@Override
	public Message findByMid(String mid) {
		Message message = this.getHibernateTemplate().get(Message.class, Integer.parseInt(mid));
		if (message != null) {
			return message;
		}
		return null;
	}

	@Override
	public void update(Message message) {
		this.getHibernateTemplate().update(message);
	}

}
