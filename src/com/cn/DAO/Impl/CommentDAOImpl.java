package com.cn.DAO.Impl;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.cn.DAO.CommentDAO;
import com.cn.POJO.Article;
import com.cn.POJO.Comment;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class CommentDAOImpl extends HibernateDaoSupport implements CommentDAO {

	@Override
	public JSONArray findCommentsByAid(String aid) {
		JSONArray array = new JSONArray();
		String hql = "FROM Comment WHERE aid = ? ORDER BY time DESC";
		List<Comment> list = (List<Comment>) this.getHibernateTemplate().find(hql, aid);
		if (list != null || list.size() > 0) {
			for (Comment comment : list) {
				JSONObject json = new JSONObject();
				json.put("author", comment.getUser().getUsername());
				json.put("time", comment.getTime());
				json.put("content", comment.getContent());
				array.add(json);
			}
			return array;
		}
		return null;
	}

	@Override
	public void save(Comment comment) {
		this.getHibernateTemplate().setCheckWriteOperations(false);
		this.getHibernateTemplate().save(comment);
	}

	@Override
	public Comment findById(String id) {
		Comment comment = this.getHibernateTemplate().get(Comment.class, Integer.parseInt(id));
		if (comment != null) {
			return comment;
		}
		return null;
	}
	
	@Override
	public Integer countByAid(String aid) {
		String hql = "FROM Comment WHERE aid = ?";
		List<Comment> result = (List<Comment>) this.getHibernateTemplate().find(hql, aid);
		if (result != null && result.size() > 0) {
			return result.size();
		}
		return 0;
	}
	
	@Override
	public JSONArray findArticlesWithMaxComments() {
		JSONArray array = new JSONArray();
		String hql = "select id, count(aid) as count_num from Comment GROUP BY aid ORDER BY count_num DESC";
		List<Object[]> result = (List<Object[]>) this.getHibernateTemplate().find(hql);
		if (result != null && result.size() > 0) {
			for (Object[] object : result) {
				JSONObject jsonObject = new JSONObject();
				Comment comment = findById(object[0].toString());
				jsonObject.put("aid", comment.getArticle().getAid());
				jsonObject.put("count", object[1]);
				array.add(jsonObject);
			}
		}
		return array;
	}
}
