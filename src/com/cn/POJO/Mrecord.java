package com.cn.POJO;

import java.sql.Timestamp;

/**
 * Mrecord entity. @author MyEclipse Persistence Tools
 */

public class Mrecord implements java.io.Serializable {

	// Fields

	private Integer rid;
	private Patient patient;
	private Doctor doctor;
	private Timestamp time;
	private Integer part;
	private String description;
	private String content;

	// Constructors

	/** default constructor */
	public Mrecord() {
	}

	/** minimal constructor */
	public Mrecord(Patient patient, Doctor doctor, Timestamp time) {
		this.patient = patient;
		this.doctor = doctor;
		this.time = time;
	}

	/** full constructor */
	public Mrecord(Patient patient, Doctor doctor, Timestamp time, Integer part, String description, String content) {
		this.patient = patient;
		this.doctor = doctor;
		this.time = time;
		this.part = part;
		this.description = description;
		this.content = content;
	}

	// Property accessors

	public Integer getRid() {
		return this.rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
	}

	public Patient getPatient() {
		return this.patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

	public Doctor getDoctor() {
		return this.doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public Integer getPart() {
		return this.part;
	}

	public void setPart(Integer part) {
		this.part = part;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}