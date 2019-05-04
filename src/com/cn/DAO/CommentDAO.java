package com.cn.DAO;

import com.cn.POJO.Comment;

import net.sf.json.JSONArray;

public interface CommentDAO {

	public JSONArray findCommentsByAid(String aid);
	
	public void save(Comment comment);
	
	//查询评论列表中评论最多的文章编号及评论数
	public JSONArray findArticlesWithMaxComments();
	
	//根据ID查找评论
	public Comment findById(String id);
	
	//根据文章ID计算评论数
	public Integer countByAid(String aid);
}
