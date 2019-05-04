package com.cn.POJO;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Patient entity. @author MyEclipse Persistence Tools
 */

public class Patient implements java.io.Serializable {

	// Fields

	private Integer pid;
	private User user;
	private String name;
	private Integer sex;
	private Date birthday;
	private String profession;
	private String address;
	private String zipcode;
	private String signature;
	private String cname;
	private String crelation;
	private String cphone;
	private Set mrecords = new HashSet(0);
	private Set dandps = new HashSet(0);
	private Set exrecords = new HashSet(0);

	// Constructors

	/** default constructor */
	public Patient() {
	}

	/** minimal constructor */
	public Patient(User user) {
		this.user = user;
	}

	/** full constructor */
	public Patient(User user, String name, Integer sex, Date birthday, String profession, String address,
			String zipcode, String signature, String cname, String crelation, String cphone, Set mrecords, Set dandps,
			Set exrecords) {
		this.user = user;
		this.name = name;
		this.sex = sex;
		this.birthday = birthday;
		this.profession = profession;
		this.address = address;
		this.zipcode = zipcode;
		this.signature = signature;
		this.cname = cname;
		this.crelation = crelation;
		this.cphone = cphone;
		this.mrecords = mrecords;
		this.dandps = dandps;
		this.exrecords = exrecords;
	}

	// Property accessors

	public Integer getPid() {
		return this.pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
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

	public String getProfession() {
		return this.profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipcode() {
		return this.zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getSignature() {
		return this.signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCrelation() {
		return this.crelation;
	}

	public void setCrelation(String crelation) {
		this.crelation = crelation;
	}

	public String getCphone() {
		return this.cphone;
	}

	public void setCphone(String cphone) {
		this.cphone = cphone;
	}

	public Set getMrecords() {
		return this.mrecords;
	}

	public void setMrecords(Set mrecords) {
		this.mrecords = mrecords;
	}

	public Set getDandps() {
		return this.dandps;
	}

	public void setDandps(Set dandps) {
		this.dandps = dandps;
	}

	public Set getExrecords() {
		return this.exrecords;
	}

	public void setExrecords(Set exrecords) {
		this.exrecords = exrecords;
	}

}