package com.cn.DAO.Impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.ArticleDAO;
import com.cn.POJO.Article;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ArticleDAOImpl extends HibernateDaoSupport implements ArticleDAO {

	@Override
	public void save(Article article) {
		this.getHibernateTemplate().save(article);
	}

	@Override
	public List<Article> articles() {
		String hql = "from Article";
		List<Article> list = (List<Article>) this.getHibernateTemplate().find(hql);
		return list;
	}
	
	@Override
	public JSONArray allArticles() {
		JSONArray array = new JSONArray();
		String hql = "from Article ORDER BY time DESC";
		List<Article> list = (List<Article>) this.getHibernateTemplate().find(hql);
		for (Article article : list) {
			JSONObject object = new JSONObject();
			object.put("aid", article.getAid());
			object.put("category", article.getCategory());
			object.put("time", article.getTime());
			object.put("title", article.getTitle());
			object.put("author", article.getUser().getUsername());
			array.add(object);
		}
		return array;
	}

	@Override
	public JSONArray articlesInCategory(String category) {
		JSONArray array = new JSONArray();
		String hql = "from Article WHERE category = ? ORDER BY time DESC";
		List<Article> list = (List<Article>) this.getHibernateTemplate().find(hql, category);
		for (Article article : list) {
			JSONObject object = new JSONObject();
			object.put("aid", article.getAid());
			object.put("category", article.getCategory());
			object.put("time", article.getTime());
			object.put("title", article.getTitle());
			object.put("author", article.getUser().getUsername());
			array.add(object);
		}
		return array;
	}
	
	@Override
	public JSONArray articlesByKeyword(String keyword) {
		String string = "\"%" + keyword + "%\"";
		JSONArray array = new JSONArray();
		String hql = "SELECT aid, uid, title, category, time from Article WHERE title LIKE \"%" + keyword + "%\" ORDER BY time DESC";
		Session session = this.getHibernateTemplate().getSessionFactory().openSession();
		List<Object[]> list = new ArrayList<Object[]>();
		try {
			//session.flush();
			Query query = session.createSQLQuery(hql);
			list = query.list();
			for (Object[] objects : list) {
				JSONObject object = new JSONObject();
				object.put("aid", objects[0]);
				Article article = this.getHibernateTemplate().get(Article.class, (Integer) objects[1]);
				object.put("author", article.getUser().getUsername());
				object.put("title", objects[2]);
				object.put("category", objects[3]);
				object.put("time", objects[4]);
				array.add(object);
			}
			//session.flush();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return array;
	}
	
	@Override
	public List<Article> topTenSolu() {//查找最新10篇最新病情解答文章
		String hql = "SELECT aid, title, time FROM Article WHERE category = 0 ORDER BY time DESC LIMIT 10";
		//默认查询出来的list里存放的是一个Object数组，还需要转换成对应的javaBean。
		List<Object[]> list = (List<Object[]>) this.getHibernateTemplate().find(hql);
		List<Article> articles = new ArrayList<Article>();
		for(Object[] object : list){
			Article article = new Article();
			article.setAid((Integer) object[0]);
			article.setTitle((String) object[1]);
			article.setTime((Timestamp) object[2]);
			
			article.setCategory(0);
			article.setComments(null);
			article.setContent(null);
			article.setUser(null);
			articles.add(article);
		}
		return articles;
	}

	@Override
	public List<Article> topTenKnow() {//查找最新10篇知识共享文章
		String hql = "SELECT aid, title, time FROM Article WHERE category = 1 ORDER BY time DESC LIMIT 10";
		//默认查询出来的list里存放的是一个Object数组，还需要转换成对应的javaBean。
		List<Object[]> list = (List<Object[]>) this.getHibernateTemplate().find(hql);
		List<Article> articles = new ArrayList<Article>();
		for(Object[] object : list){
			Article article = new Article();
			article.setAid((Integer) object[0]);
			article.setTitle((String) object[1]);
			article.setTime((Timestamp) object[2]);
			
			article.setCategory(0);
			article.setComments(null);
			article.setContent(null);
			article.setUser(null);
			articles.add(article);
		}
		return articles;
	}

	@Override
	public JSONObject findArticleById(String aid) {
		JSONObject json = new JSONObject();
		Article article = this.getHibernateTemplate().get(Article.class, Integer.parseInt(aid));
		json.put("title", article.getTitle());
		json.put("author", article.getUser().getUsername());
		json.put("time", article.getTime());
		json.put("content", article.getContent());
		json.put("category", article.getCategory());
		json.put("aid", article.getAid());
		return json;
	}

	@Override
	public JSONArray findArticlesByUid(String uid) {//通过用户ID查询文章
		JSONArray array = new JSONArray();
		String hql = "from Article where uid = ? ORDER BY time DESC";
		List<Article> list = (List<Article>) this.getHibernateTemplate().find(hql, uid);
		if (list != null || list.size() > 0) {
			for (Article article : list) {
				JSONObject json = new JSONObject();
				json.put("aid", article.getAid());
				json.put("category", article.getCategory());
				//json.put("content", article.getContent());
				json.put("time", article.getTime());
				json.put("title", article.getTitle());
				array.add(json);
			}
			return array;
		}
		return null;
	}

	@Override
	public Article findArticleByAid(String aid) {
		Article article = this.getHibernateTemplate().get(Article.class, Integer.parseInt(aid));
		if (article != null) {
			return article;
		}
		return null;
	}

	@Override
	public void update(Article article) {
		this.getHibernateTemplate().update(article);
	}

	@Override
	public void delete(Article article) {
		this.getHibernateTemplate().delete(article);
	}

	@Override
	public JSONArray topFiveNewestArticles() {
		String hql = "from Article ORDER BY time DESC";
		JSONArray array = new JSONArray();
		List<Article> result = (List<Article>) this.getHibernateTemplate().find(hql);
		for (int i = 0; i < result.size() && i < 5; i++) {
			Article article = result.get(i);
			JSONObject object = new JSONObject();
			object.put("aid", article.getAid());
			object.put("category", article.getCategory());
			object.put("time", article.getTime());
			object.put("title", article.getTitle());
			object.put("author", article.getUser().getUsername());
			array.add(object);
		}
		return array;
	}
}
