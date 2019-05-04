package com.cn.DAO.Impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.MrecordDAO;
import com.cn.POJO.Mrecord;

public class MrecordDAOImpl extends HibernateDaoSupport implements MrecordDAO {

	@Override
	public void save(Mrecord mrecord) {
		this.getHibernateTemplate().save(mrecord);
	}

	@Override
	public List<Mrecord> findByPid(String pid) {
		//System.out.println("Mrecord findByPid");
		String hql = "from Mrecord where pid = ?";
		return (List<Mrecord>) this.getHibernateTemplate().find(hql, pid);
	}

	@Override
	public List<Mrecord> findByDid(String did) {
		String hql = "from Mrecord where did = ?";
		return (List<Mrecord>) this.getHibernateTemplate().find(hql, did);
	}

	@Override
	public void delete(Mrecord mrecord) {
		this.getHibernateTemplate().delete(mrecord);
	}

}
