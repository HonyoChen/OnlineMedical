package com.cn.DAO.Impl;

import com.cn.DAO.ExrecordDAO;
import com.cn.POJO.Exrecord;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import java.sql.Timestamp;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

public class ExrecordDAOImpl extends HibernateDaoSupport implements ExrecordDAO {

	@Override
	public void save(Exrecord exrecord) {
		this.getHibernateTemplate().setCheckWriteOperations(false);
		this.getHibernateTemplate().save(exrecord);
	}

	@Override
	public void delete(String rid) {
		Exrecord ex = this.getHibernateTemplate().get(Exrecord.class, Integer.parseInt(rid));
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		try {
			session.flush();
			session.delete(ex);
			session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public JSONArray findExrecordsByPid(String pid) {
		String hql = "SELECT eid, time FROM Exrecord WHERE pid = ? and isConfirmed = 0 ORDER BY time DESC";
		//默认查询出来的list里存放的是一个Object数组，还需要转换成对应的javaBean。
		System.out.println("PID为：" + pid);
		List<Object[]> list = (List<Object[]>) this.getHibernateTemplate().find(hql, pid);
		if (list != null && list.size() > 0) {
			JSONArray array = new JSONArray();
			for(Object[] object : list){
				JSONObject json = new JSONObject();
				json.put("id", (Integer) object[0]);
				json.put("time", (Timestamp) object[1]);
				array.add(json);
			}
			return array;
		}
		return null;
	}

	@Override
	public String findLastRecordByPid(Integer pid) {
		String hql = "FROM Exrecord WHERE pid = ? ORDER BY time DESC LIMIT 1";
		List<Exrecord> result = (List<Exrecord>) this.getHibernateTemplate().find(hql, pid);
		if (result != null && result.size() > 0) {
			return result.get(0).getTime().toString();
		}
		return null;
	}

	@Override
	public Integer countOnSpecialDay(Integer pid, Integer day) {
		String hql = "FROM Exrecord WHERE pid = ? AND DATEDIFF(time, NOW()) = ?";
		List<Exrecord> result = (List<Exrecord>) this.getHibernateTemplate().find(hql, pid, day);
		if (result != null && result.size() > 0) {
			return result.size();
		}
		return 0;
	}
	
	@Override
	public Integer countOnTimePeriod(Integer pid, Integer day) {
		String hql = "FROM Exrecord WHERE pid = ? AND DATEDIFF(time, NOW()) >= ? AND DATEDIFF(time, NOW()) < 0";
		List<Exrecord> result = (List<Exrecord>) this.getHibernateTemplate().find(hql, pid, day);
		if (result != null && result.size() > 0) {
			return result.size();
		}
		return 0;
	}
	
	@Override
	public Exrecord findExrecord(String eid) {
		Exrecord exrecord = this.getHibernateTemplate().get(Exrecord.class, Integer.parseInt(eid));
		return exrecord;
	}
	
	@Override
	public void updateConfirm(Exrecord exrecord) {
		Exrecord ex = this.getHibernateTemplate().get(Exrecord.class, exrecord.getEid());
		ex.setIsConfirmed(true);
		
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		try {
			session.flush();
			session.saveOrUpdate(ex);
			session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
}
