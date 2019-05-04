package com.cn.POJO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Doctor entity. @author MyEclipse Persistence Tools
 */

public class Doctor implements java.io.Serializable {

	// Fields

	private Integer did;
	private User user;
	private String name;
	private Integer sex;
	private Date birthday;
	private Integer department;
	private Integer title;
	private String description;
	private Set mrecords = new HashSet(0);
	private Set cfiles = new HashSet(0);
	private Set dandps = new HashSet(0);

	// Constructors

	/** default constructor */
	public Doctor() {
	}

	/** minimal constructor */
	public Doctor(User user) {
		this.user = user;
	}

	/** full constructor */
	public Doctor(User user, String name, Integer sex, Date birthday, Integer department, Integer title,
			String description, Set mrecords, Set cfiles, Set dandps) {
		this.user = user;
		this.name = name;
		this.sex = sex;
		this.birthday = birthday;
		this.department = department;
		this.title = title;
		this.description = description;
		this.mrecords = mrecords;
		this.cfiles = cfiles;
		this.dandps = dandps;
	}

	// Property accessors

	public Integer getDid() {
		return this.did;
	}

	public void setDid(Integer did) {
		this.did = did;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return this.sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Date getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Integer getDepartment() {
		return this.department;
	}

	public void setDepartment(Integer department) {
		this.department = department;
	}

	public Integer getTitle() {
		return this.title;
	}

	public void setTitle(Integer title) {
		this.title = title;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set getMrecords() {
		return this.mrecords;
	}

	public void setMrecords(Set mrecords) {
		this.mrecords = mrecords;
	}

	public Set getCfiles() {
		return this.cfiles;
	}

	public void setCfiles(Set cfiles) {
		this.cfiles = cfiles;
	}

	public Set getDandps() {
		return this.dandps;
	}

	public void setDandps(Set dandps) {
		this.dandps = dandps;
	}

}