package com.cn.POJO;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Exrecord entity. @author MyEclipse Persistence Tools
 */

public class Exrecord implements java.io.Serializable {

	// Fields

	private Integer eid;
	private Patient patient;
	private Timestamp time;
	private Boolean isConfirmed;
	private Set exstatistics = new HashSet(0);

	// Constructors

	/** default constructor */
	public Exrecord() {
	}

	/** full constructor */
	public Exrecord(Patient patient, Timestamp time, Boolean isConfirmed, Set exstatistics) {
		this.patient = patient;
		this.time = time;
		this.isConfirmed = isConfirmed;
		this.exstatistics = exstatistics;
	}

	// Property accessors

	public Integer getEid() {
		return this.eid;
	}

	public void setEid(Integer eid) {
		this.eid = eid;
	}

	public Patient getPatient() {
		return this.patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public Boolean getIsConfirmed() {
		return this.isConfirmed;
	}

	public void setIsConfirmed(Boolean isConfirmed) {
		this.isConfirmed = isConfirmed;
	}

	public Set getExstatistics() {
		return this.exstatistics;
	}

	public void setExstatistics(Set exstatistics) {
		this.exstatistics = exstatistics;
	}

}