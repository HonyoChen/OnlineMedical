package com.cn.POJO;

import java.util.HashSet;
import java.util.Set;

/**
 * User entity. @author MyEclipse Persistence Tools
 */

public class User implements java.io.Serializable {

	// Fields

	private Integer uid;
	private String username;
	private String password;
	private Integer role;
	private String email;
	private String phone;
	private String uuid;
	private String code;
	private Doctor doctor;
	private Set comments = new HashSet(0);
	private Set articles = new HashSet(0);
	private Set messages = new HashSet(0);
	private Patient patient;

	// Constructors

	/** default constructor */
	public User() {
	}

	/** minimal constructor */
	public User(String username, String password, Integer role, String email, String phone, String uuid) {
		this.username = username;
		this.password = password;
		this.role = role;
		this.email = email;
		this.phone = phone;
		this.uuid = uuid;
	}

	/** full constructor */
	public User(String username, String password, Integer role, String email, String phone, String uuid, String code,
			Doctor doctor, Set comments, Set articles, Set messages, Patient patient) {
		this.username = username;
		this.password = password;
		this.role = role;
		this.email = email;
		this.phone = phone;
		this.uuid = uuid;
		this.code = code;
		this.doctor = doctor;
		this.comments = comments;
		this.articles = articles;
		this.messages = messages;
		this.patient = patient;
	}

	// Property accessors

	public Integer getUid() {
		return this.uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getRole() {
		return this.role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getUuid() {
		return this.uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Doctor getDoctor() {
		return this.doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}

	public Set getComments() {
		return this.comments;
	}

	public void setComments(Set comments) {
		this.comments = comments;
	}

	public Set getArticles() {
		return this.articles;
	}

	public void setArticles(Set articles) {
		this.articles = articles;
	}

	public Set getMessages() {
		return this.messages;
	}

	public void setMessages(Set messages) {
		this.messages = messages;
	}

	public Patient getPatient() {
		return this.patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

}