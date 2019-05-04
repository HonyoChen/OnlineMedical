package com.cn.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.cn.DAO.ArticleDAO;
import com.cn.POJO.Article;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Transactional
public class ArticleService {

	private ArticleDAO articleDAO;
	public ArticleDAO getArticleDAO() {
		return articleDAO;
	}
	public void setArticleDAO(ArticleDAO articleDAO) {
		this.articleDAO = articleDAO;
	}
	
	public void saveArticle(Article article){
		System.out.println("进入ArticleService");
		articleDAO.save(article);
	}
	
	public JSONArray allArticles(){
		return articleDAO.allArticles();
	}
	
	public List<Article> topTenSolu(){
		return articleDAO.topTenSolu();
	}
	
	public List<Article> topTenKnow(){
		return articleDAO.topTenKnow();
	}
	
	//根据文章ID查询文章信息，用于前端显示
	public JSONObject findArticleByAid(String aid){
		return articleDAO.findArticleById(aid);
	}
	
	public JSONArray findArticlesByUid(String uid){
		return articleDAO.findArticlesByUid(uid);
	}
	
	//根据文章ID查询文章，有全部信息
	public Article findArticleByKEYId(String aid){
		return articleDAO.findArticleByAid(aid);
	}
	
	public void updateArticle(Article article){
		articleDAO.update(article);
	}
	
	public void deleteArticle(Article article){
		articleDAO.delete(article);
	}
	
	public JSONArray topFiveNewestArticles(){
		return articleDAO.topFiveNewestArticles();
	}
	
	public JSONArray articlesInCategory(String category){
		return articleDAO.articlesInCategory(category);
	}
	
	public JSONArray articlesByKeyword(String keyword){
		return articleDAO.articlesByKeyword(keyword);
	}
}
