package com.cn.POJO;

/**
 * Exstatistic entity. @author MyEclipse Persistence Tools
 */

public class Exstatistic implements java.io.Serializable {

	// Fields

	private Integer sid;
	private Exrecord exrecord;
	private Integer onset;
	private Integer factor;
	private Integer state;
	private Integer status;

	// Constructors

	/** default constructor */
	public Exstatistic() {
	}

	/** full constructor */
	public Exstatistic(Exrecord exrecord, Integer onset, Integer factor, Integer state, Integer status) {
		this.exrecord = exrecord;
		this.onset = onset;
		this.factor = factor;
		this.state = state;
		this.status = status;
	}

	// Property accessors

	public Integer getSid() {
		return this.sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public Exrecord getExrecord() {
		return this.exrecord;
	}

	public void setExrecord(Exrecord exrecord) {
		this.exrecord = exrecord;
	}

	public Integer getOnset() {
		return this.onset;
	}

	public void setOnset(Integer onset) {
		this.onset = onset;
	}

	public Integer getFactor() {
		return this.factor;
	}

	public void setFactor(Integer factor) {
		this.factor = factor;
	}

	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}