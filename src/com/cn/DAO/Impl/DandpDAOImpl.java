package com.cn.DAO.Impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.DandpDAO;
import com.cn.POJO.Dandp;
import com.cn.POJO.Doctor;

public class DandpDAOImpl extends HibernateDaoSupport implements DandpDAO {

	
	@Override //查询挂号列表中当前医生账户下所有挂号信息
	public List<Dandp> dandpsByDid(String did) {
		String hql = "from Dandp where did = ?";
		List<Dandp> query = (List<Dandp>) this.getHibernateTemplate().find(hql, did);
		//System.out.println("查询完成");
		if(query.size() > 0 || query != null){
			return query;
		}
		return null;
	}

	@Override //查询挂号列表中患者挂号信息，仅一条
	public Dandp dandpsByPid(String pid) {
		System.out.println("查询挂号信息");
		String hql = "from Dandp where pid = ?";
		List<Dandp> query = (List<Dandp>) this.getHibernateTemplate().find(hql, pid);
		//System.out.println("查询完成");
		if(query.size() > 0){
			return query.get(0);
		}
		return null;
	}

	@Override
	public Dandp dandpById(String id) {
		Dandp result = this.getHibernateTemplate().get(Dandp.class, Integer.parseInt(id));
		if(result != null){
			return result;
		}
		return null;
	}

	@Override
	public void delete(Dandp dandp) {
		this.getHibernateTemplate().setCheckWriteOperations(false);
		this.getHibernateTemplate().delete(dandp);
	}

	@Override
	public void save(Dandp dandp) {
		this.getHibernateTemplate().setCheckWriteOperations(false);
		this.getHibernateTemplate().save(dandp);
	}

	@Override
	public void update(Dandp dandp) {
		this.getHibernateTemplate().update(dandp);
	}

	@Override
	public String findDidByPid(String pid) {
		String hql = "SELECT doctor FROM Dandp WHERE pid = ?";
		List<Object[]> list = (List<Object[]>) this.getHibernateTemplate().find(hql, pid);
		if (list != null && list.size()>0) {
			Object object = list.get(0);
			Doctor doctor = (Doctor) object;
			return doctor.getDid().toString();
		}else {
			return null;
		}
	}

}
