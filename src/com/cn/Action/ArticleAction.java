package com.cn.Action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Article;
import com.cn.POJO.User;
import com.cn.Service.ArticleService;
import com.cn.Service.CommentService;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ArticleAction extends ActionSupport {

	private ArticleService articleService;
	public ArticleService getArticleService() {
		return articleService;
	}
	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}
	
	private CommentService commentService;
	public CommentService getCommentService() {
		return commentService;
	}
	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	
	private List<Article> articles = new ArrayList<Article>();
	public List<Article> getArticles() {
		return articles;
	}
	public void setArticles(List<Article> articles) {
		this.articles = articles;
	}
	
	private JSONObject json;
	public JSONObject getJson() {
		return json;
	}
	public void setJson(JSONObject json) {
		this.json = json;
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
	
	public String allArticles(){
		System.out.println("查找文章Action");
		JSONArray jsonArray = articleService.allArticles();
		//JSONArray returnArray = new JSONArray();
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject object = jsonArray.getJSONObject(i);
			String aid = object.getString("aid");
			int count = commentService.countByAid(aid);
			object.put("count", count);
			//returnArray.add(object);
		}
		array = null;
		array = jsonArray;
		System.out.println(array.toString());
		return "SUCCESS";
	}
	
	public String articlesInCategory(){
		String category = ServletActionContext.getRequest().getParameter("category");
		JSONArray jsonArray = articleService.articlesInCategory(category);
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject object = jsonArray.getJSONObject(i);
			String aid = object.getString("aid");
			int count = commentService.countByAid(aid);
			object.put("count", count);
		}
		array = jsonArray;
		System.out.println(array.toString());
		return "SUCCESS";
	}
	
	public String articlesByKeyword(){
		String keyword = ServletActionContext.getRequest().getParameter("keyword");
		JSONArray jsonArray = articleService.articlesByKeyword(keyword);
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject object = jsonArray.getJSONObject(i);
			String aid = object.getString("aid");
			int count = commentService.countByAid(aid);
			object.put("count", count);
		}
		array = jsonArray;
		return "SUCCESS";
	}
	
	public String loadTopTenSolu(){
		articles = articleService.topTenSolu();
		return "SUCCESS";
	}
	
	public String loadTopTenKnow(){
		articles = articleService.topTenKnow();
		return "SUCCESS";
	}
	
	public String findArticleById(){
		String aid = ServletActionContext.getRequest().getParameter("aid");
		JSONObject object = articleService.findArticleByAid(aid);
		int count = commentService.countByAid(aid);
		object.put("count", count);
		json = object;
		return "SUCCESS";
	}
	
	public String findArticlesByUid(){
		String uid = ServletActionContext.getRequest().getParameter("uid");
		JSONArray returnArray = articleService.findArticlesByUid(uid);
		for (int i = 0; i < returnArray.size(); i++) {
			JSONObject object = returnArray.getJSONObject(i);
			String aid = object.getString("aid");
			int count = commentService.countByAid(aid);
			object.put("count", count);
		}
		array = null;
		array = returnArray;
		return "SUCCESS";
	}
	
	public String updateArticles(){
		String aid = ServletActionContext.getRequest().getParameter("aid");
		String title = ServletActionContext.getRequest().getParameter("title");
		String category = ServletActionContext.getRequest().getParameter("category");
		String content = ServletActionContext.getRequest().getParameter("content");
		
		Article article = articleService.findArticleByKEYId(aid);
		article.setCategory(Integer.parseInt(category));
		article.setTitle(title);
		article.setContent(content);
		article.setTime(new Timestamp(new Date().getTime()));
		try {
			articleService.updateArticle(article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		result = 1;
		return "SUCCESS";
	}
	
	public String deleteArticle(){
		String aid = ServletActionContext.getRequest().getParameter("aid");
		Article article = articleService.findArticleByKEYId(aid);
		try {
			articleService.deleteArticle(article);
		} catch (Exception e) {
			e.printStackTrace();
		}
		result = 1;
		return "SUCCESS";
	}
	
	public String findArticlesWithMaxComments(){//返回评论最多的文章信息
		JSONArray aids = commentService.findArticlesWithMaxComments();
		JSONArray returnArray = new JSONArray();
		for (int i = 0; i < aids.size() && i < 5; i++) {//最多返回5篇评论最多的文章信息
			JSONObject object = aids.getJSONObject(i);
			String aid = object.getString("aid");
			String count = object.getString("count");
			
			Article article = articleService.findArticleByKEYId(aid);
			
			JSONObject returnObject = new JSONObject();
			returnObject.put("aid", article.getAid());//文章ID
			returnObject.put("category",article.getCategory());//文章类别
			returnObject.put("time", article.getTime());//文章时间
			returnObject.put("title", article.getTitle());//文章标题
			returnObject.put("count", count);//文章评论数
			returnObject.put("author", article.getUser().getUsername());//文章作者名称
			
			returnArray.add(returnObject);
		}
		array = null;
		array = returnArray;
		System.out.println(array.toString());
		return "SUCCESS";
	}
	
	public String topFiveNewestArticles(){//最新的5篇文章的信息
		JSONArray jsonArray = articleService.topFiveNewestArticles();
		array = null;
		array = jsonArray;
		return "SUCCESS";
	}
}
