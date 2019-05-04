package com.cn.POJO;

import java.lang.reflect.Field;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Article entity. @author MyEclipse Persistence Tools
 */

public class Article implements java.io.Serializable {

	// Fields

	private Integer aid;
	private User user;
	private String title;
	private Integer category;
	private Timestamp time;
	private String content;
	private Set comments = new HashSet(0);

	// Constructors

	/** default constructor */
	public Article() {
	}

	/** full constructor */
	public Article(User user, String title, Integer category, Timestamp time, String content, Set comments) {
		this.user = user;
		this.title = title;
		this.category = category;
		this.time = time;
		this.content = content;
		this.comments = comments;
	}

	// Property accessors

	public Integer getAid() {
		return this.aid;
	}

	public void setAid(Integer aid) {
		this.aid = aid;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getCategory() {
		return this.category;
	}

	public void setCategory(Integer category) {
		this.category = category;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Set getComments() {
		return this.comments;
	}

	public void setComments(Set comments) {
		this.comments = comments;
	}
}