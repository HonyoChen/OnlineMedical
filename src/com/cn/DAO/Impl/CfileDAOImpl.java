package com.cn.DAO.Impl;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.CfileDAO;
import com.cn.POJO.Cfile;

public class CfileDAOImpl extends HibernateDaoSupport implements CfileDAO{

	@Override
	public Cfile cfileByFid(String fid) {
		Cfile query = this.getHibernateTemplate().get(Cfile.class, Integer.parseInt(fid));
		if (query != null) {
			return query;
		}
		return null;
	}

	@Override
	public void save(Cfile cfile) {
		this.getHibernateTemplate().save(cfile);
	}

	@Override
	public void delete(Cfile cfile) {
		this.getHibernateTemplate().delete(cfile);
	}

	@Override //根据父路径查询，获取父路径下所有未处于回收站状态的文件
	public List<Cfile> cfilesByParentPath(String pid) {
		String hql = "from Cfile where parentPath = ? and isDeleted <> 1 ORDER BY isDirectory DESC, time DESC";
		List<Cfile> query = (List<Cfile>) this.getHibernateTemplate().find(hql, pid);
		return query;
	}

	@Override
	public List<Cfile> cfilesInUserParentPath(String did, String parent) {
		String hql = "from Cfile where did = ? and parentPath = ? and isDeleted <> 1 ORDER BY isDirectory DESC, time DESC";
		List<Cfile> query = (List<Cfile>) this.getHibernateTemplate().find(hql, did, parent);
		System.out.println(query.size());
		return query;
	}

	@Override
	public void sharedOrCancelShared(String fid, String parent) {
		int fid_num = Integer.parseInt(fid);
		int pid_num = Integer.parseInt(parent);
		
		Cfile cfile = this.getHibernateTemplate().get(Cfile.class, fid_num);
		//由私密文件转共享文件
		if (pid_num >= 9) {
			Cfile cfile_parent = cfile.getCfile();//获取父路径
			int parent_path = cfile_parent.getFid();
			
			cfile.setRecoverPath(parent_path);
			cfile.setCfile(this.getHibernateTemplate().get(Cfile.class, pid_num-7));
		}else {
			//由共享文件转私密文件
			Integer recover = cfile.getRecoverPath();
			//之前有父目录
			if (recover != null) {
				cfile.setCfile(this.getHibernateTemplate().get(Cfile.class, recover));
				cfile.setRecoverPath(null);
			}else {
				//之前无父目录
				cfile.setCfile(this.getHibernateTemplate().get(Cfile.class, pid_num+7));
			}
		}
		this.getHibernateTemplate().update(cfile);
		
	}
	
	@Override
	public void inOrOutRecycleBin(String fid, String parent) {
		int fid_num = Integer.parseInt(fid);
		
		Cfile cfile = this.getHibernateTemplate().get(Cfile.class, fid_num);
		//恢复文件
		if (cfile.getCfile().getFid() == 8) {
			Cfile parent_cfile = this.getHibernateTemplate().get(Cfile.class, cfile.getRecoverPath());
			//如果父路径也放入回收站
			if (parent_cfile == null || parent_cfile.getCfile().getFid() == 8) {
				cfile.setCfile(this.getHibernateTemplate().get(Cfile.class, Integer.parseInt(parent)));
			}else {
				cfile.setCfile(parent_cfile);
			}
		}else {
			//放入回收站
			Cfile recycle = this.getHibernateTemplate().get(Cfile.class, 8);
			cfile.setRecoverPath(cfile.getCfile().getFid());
			cfile.setCfile(recycle);
		}
		this.getHibernateTemplate().update(cfile);
	}
	
	@Override
	public String findTreeMenu(String rootId, String did) {
		String hql = "SELECT getChildLst(" + rootId +"," + did + ")";
		
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		List<String> list = null;
		try {
			//session.flush();
			Query query = session.createSQLQuery(hql);
			list = query.list();
			//session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		if (list != null && list.size() > 0) {
			System.out.println(list.get(0).toString());
			return list.get(0);
		}else {
			return null;
		}
	}
	
	@Override
	public void changeParent(String fid, String changeParent) {
		int fid_num = Integer.parseInt(fid);
		Cfile cfile = this.getHibernateTemplate().get(Cfile.class, fid_num);
		int pid_num = Integer.parseInt(changeParent);
		Cfile parent = this.getHibernateTemplate().get(Cfile.class, pid_num);
		cfile.setCfile(parent);
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		try {
			session.flush();
//			session.saveOrUpdate(cfile);
			session.merge(cfile);//懒加载导致的开启多个session
			session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	
	@Override
	public void fileRename(String fid, String filename) {
		int fid_num = Integer.parseInt(fid);
		Cfile cfile = this.getHibernateTemplate().get(Cfile.class, fid_num);
		cfile.setFilename(filename);
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		try {
			session.flush();
			session.saveOrUpdate(cfile);
			session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
}
