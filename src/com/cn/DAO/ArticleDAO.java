package com.cn.DAO;

import java.util.List;

import com.cn.POJO.Article;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public interface ArticleDAO {

	public void save(Article article);
	
	//返回所有文章，弃用
	public List<Article> articles();
	public JSONArray allArticles();
	
	//前十条病情解答帖子，弃用
	public List<Article> topTenSolu();
	
	//前十条知识共享帖子，弃用
	public List<Article> topTenKnow();
	
	//添加评论时查询文章用
	public Article findArticleByAid(String aid);
	
	//根据文章ID查找文章
	public JSONObject findArticleById(String aid);
	
	//查找用户所有文章
	public JSONArray findArticlesByUid(String uid);
	
	//修改文章
	public void update(Article article);
	
	//删除文章
	public void delete(Article article);
	
	//返回最新5篇文章信息
	public JSONArray topFiveNewestArticles();
	
	public JSONArray articlesInCategory(String category);
	
	public JSONArray articlesByKeyword(String keyword);
}
