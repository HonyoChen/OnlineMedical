package com.cn.POJO;

import java.sql.Timestamp;

/**
 * Dandp entity. @author MyEclipse Persistence Tools
 */

public class Dandp implements java.io.Serializable {

	// Fields

	private Integer id;
	private Patient patient;
	private Doctor doctor;
	private Timestamp time;
	private Integer part;
	private String description;

	// Constructors

	/** default constructor */
	public Dandp() {
	}

	/** minimal constructor */
	public Dandp(Patient patient, Doctor doctor, Timestamp time) {
		this.patient = patient;
		this.doctor = doctor;
		this.time = time;
	}

	/** full constructor */
	public Dandp(Patient patient, Doctor doctor, Timestamp time, Integer part, String description) {
		this.patient = patient;
		this.doctor = doctor;
		this.time = time;
		this.part = part;
		this.description = description;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
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

}