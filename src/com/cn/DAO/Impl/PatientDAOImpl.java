package com.cn.DAO.Impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.BaseDAO;
import com.cn.DAO.PatientDAO;
import com.cn.POJO.Patient;

public class PatientDAOImpl extends HibernateDaoSupport implements PatientDAO {

	
//	@Override
//	public Patient findByPid(String pid) {
//		System.out.println("查找患者");
//		String hql = "from Patient where pid = ?";
//		List<Patient> query = (List<Patient>) this.getHibernateTemplate().load(Patient.class, pid);
//		System.out.println("执行");
//		if (query.size() > 0) {
//			System.out.println("查找完成");
//			return (Patient) query.get(0);
//		}
//		return null;
//	}

	@Override
	public void save(Patient patient) {
		//this.getHibernateTemplate().setCheckWriteOperations(false);
		try {
			this.getHibernateTemplate().save(patient);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		
//		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
//		try {
//			session.flush();
//			session.saveOrUpdate(patient);
////			session.save(patient);
//			//session.flush();
//		} catch (HibernateException e) {
//			e.printStackTrace();
//		} finally {
//			session.close();
//		}
	}

	@Override
	public void update(Patient patient) {
//		this.getHibernateTemplate().setCheckWriteOperations(false);
//		this.getHibernateTemplate().update(patient);
		
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		try {
			session.flush();
			session.update(patient);
			session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public void delete(Patient patient) {
//		this.getHibernateTemplate().setCheckWriteOperations(false);
//		this.getHibernateTemplate().delete(patient);
		
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		try {
			session.flush();
			session.delete(patient);
			session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public Patient findByPid(String pid) {
		Patient patient = this.getHibernateTemplate().get(Patient.class, Integer.parseInt(pid));
		return patient;
	}

	
}
