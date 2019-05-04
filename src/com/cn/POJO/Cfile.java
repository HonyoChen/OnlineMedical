package com.cn.POJO;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Cfile entity. @author MyEclipse Persistence Tools
 */

public class Cfile implements java.io.Serializable {

	// Fields

	private Integer fid;
	private Cfile cfile;
	private Doctor doctor;
	private String filename;
	private Long size;
	private Timestamp time;
	private String savepath;
	private Boolean isDirectory;
	private Boolean isShared;//数据库添加私密文件和共享文件路径，暂时弃用
	private Boolean isDeleted;
	private Integer recoverPath;
	private Set cfiles = new HashSet(0);

	// Constructors

	/** default constructor */
	public Cfile() {
	}

	/** full constructor */
	public Cfile(Cfile cfile, Doctor doctor, String filename, Long size, Timestamp time, String savepath,
			Boolean isDirectory, Boolean isShared, Boolean isDeleted, Integer recoverPath, Set cfiles) {
		this.cfile = cfile;
		this.doctor = doctor;
		this.filename = filename;
		this.size = size;
		this.time = time;
		this.savepath = savepath;
		this.isDirectory = isDirectory;
		this.isShared = isShared;
		this.isDeleted = isDeleted;
		this.recoverPath = recoverPath;
		this.cfiles = cfiles;
	}

	// Property accessors

	public Integer getFid() {
		return this.fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public Cfile getCfile() {
		return this.cfile;
	}

	public void setCfile(Cfile cfile) {
		this.cfile = cfile;
	}

	public Doctor getDoctor() {
		return this.doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}

	public String getFilename() {
		return this.filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public Long getSize() {
		return this.size;
	}

	public void setSize(Long size) {
		this.size = size;
	}

	public Timestamp getTime() {
		return this.time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getSavepath() {
		return this.savepath;
	}

	public void setSavepath(String savepath) {
		this.savepath = savepath;
	}

	public Boolean getIsDirectory() {
		return this.isDirectory;
	}

	public void setIsDirectory(Boolean isDirectory) {
		this.isDirectory = isDirectory;
	}

	public Boolean getIsShared() {
		return this.isShared;
	}

	public void setIsShared(Boolean isShared) {
		this.isShared = isShared;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public Integer getRecoverPath() {
		return this.recoverPath;
	}

	public void setRecoverPath(Integer recoverPath) {
		this.recoverPath = recoverPath;
	}

	public Set getCfiles() {
		return this.cfiles;
	}

	public void setCfiles(Set cfiles) {
		this.cfiles = cfiles;
	}

}