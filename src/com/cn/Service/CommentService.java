package com.cn.Service;

import com.cn.DAO.CommentDAO;
import com.cn.POJO.Comment;

import net.sf.json.JSONArray;

public class CommentService {

	private CommentDAO commentDAO;
	public CommentDAO getCommentDAO() {
		return commentDAO;
	}
	public void setCommentDAO(CommentDAO commentDAO) {
		this.commentDAO = commentDAO;
	}
	
	public JSONArray getCommentsByAid(String aid){
		return commentDAO.findCommentsByAid(aid);
	}
	
	public void addComment(Comment comment){
		commentDAO.save(comment);
	}
	
	public JSONArray findArticlesWithMaxComments(){
		return commentDAO.findArticlesWithMaxComments();
	}
	
	public Integer countByAid(String aid){
		return commentDAO.countByAid(aid);
	}
}
