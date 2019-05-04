package com.cn.Action;

import java.sql.Timestamp;
import java.util.Date;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Article;
import com.cn.POJO.Comment;
import com.cn.POJO.User;
import com.cn.Service.ArticleService;
import com.cn.Service.CommentService;
import com.cn.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;

public class CommentAction extends ActionSupport {

	private CommentService commentService;
	public CommentService getCommentService() {
		return commentService;
	}
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	private UserService userService;
	private ArticleService articleService;
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public ArticleService getArticleService() {
		return articleService;
	}
	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}
	
	private JSONArray array;
	public JSONArray getArray() {
		return array;
	}
	public void setArray(JSONArray array) {
		this.array = array;
	}
	
	private int result;
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	
	public String findCommentsByAid(){
		String aid = ServletActionContext.getRequest().getParameter("aid");
		System.out.println("CommentAction中AID的值是：" + aid);
		array = commentService.getCommentsByAid(aid);
		return "SUCCESS";
	}
	
	public String addComment(){
		String uid = ServletActionContext.getRequest().getParameter("uid");
		String aid = ServletActionContext.getRequest().getParameter("aid");
		String content = ServletActionContext.getRequest().getParameter("content");
		
		Comment comment = new Comment();
		comment.setContent(content);
		comment.setTime(new Timestamp(new Date().getTime()));
		
		User user = userService.findByUid(uid);
		Article article = articleService.findArticleByKEYId(aid);
		comment.setArticle(article);
		comment.setUser(user);
		
		try {
			commentService.addComment(comment);
		} catch (Exception e) {
			e.printStackTrace();
		}
		result = 1;
		return "SUCCESS";
	}
}
