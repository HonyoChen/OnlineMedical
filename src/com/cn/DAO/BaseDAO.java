package com.cn.DAO;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class BaseDAO {

	//区分HttpSession 和 HibernateSession
	private SessionFactory sessionFactory;
	
	public Session getSession(){
		return getSessionFactory().getCurrentSession();
	}
	
//	//打开HibernateSession
//	public Session openSession(){
//		Session session = getSessionFactory().openSession();
//		return session;
//	}
//	
//	//获取当前打开的HibernateSession
//	public Session getCurrentSession(){
//		Session session = sessionFactory.getCurrentSession();
//		return session;
//	}
	
	//关闭HibernateSession
	public void closeSession(){
		Session session = sessionFactory.getCurrentSession();
		session.close();
	}
	
	public SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			System.out.println("进入GetSessionFactory");
			Configuration configuration = new Configuration().configure();
			ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()).buildServiceRegistry();
			sessionFactory = configuration.buildSessionFactory(serviceRegistry);
		}
		return sessionFactory;
	}
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	
}
