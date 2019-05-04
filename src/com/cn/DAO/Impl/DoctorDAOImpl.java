package com.cn.DAO.Impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.BaseDAO;
import com.cn.DAO.DoctorDAO;
import com.cn.POJO.Doctor;

public class DoctorDAOImpl extends HibernateDaoSupport implements DoctorDAO {

	
//	@Override
//	public Doctor findByDid(String did) {
//		String hql = "from Doctor where did = ?";
//		List<Doctor> query = (List<Doctor>) this.getHibernateTemplate().find(hql, did);
//		if (query.size() > 0) {
//			return (Doctor) query.get(0);
//		}
//		return null;
//	}

	@Override
	public void save(Doctor doctor) {
//		this.getHibernateTemplate().setCheckWriteOperations(false);
//		this.getHibernateTemplate().save(doctor);
		
		try {
			this.getHibernateTemplate().save(doctor);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		
//		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
//		try {
//			session.flush();
////			session.saveOrUpdate(doctor);
//			session.save(doctor);
//			session.flush();
//		} catch (HibernateException e) {
//			e.printStackTrace();
//		} finally {
//			session.close();
//		}
	}

	@Override
	public void update(Doctor doctor) {
//		this.getHibernateTemplate().setCheckWriteOperations(false);
//		this.getHibernateTemplate().update(doctor);
		
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		try {
			session.flush();
			session.update(doctor);
			session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public List<Doctor> allDoctors() {
		List<Doctor> result = new ArrayList<Doctor>();
		
		String hql = "from Doctor where name <> null";
		result = (List<Doctor>) this.getHibernateTemplate().find(hql);
		return result;
	}

	@Override
	public void delete(Doctor doctor) {
//		this.getHibernateTemplate().setCheckWriteOperations(false);
		try {
			this.getHibernateTemplate().delete(doctor);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		
//		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
//		try {
//			session.flush();
//			session.delete(doctor);
//			session.flush();
//		} catch (HibernateException e) {
//			e.printStackTrace();
//		} finally {
//			session.close();
//		}
	}

	
}
