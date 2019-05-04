package com.cn.Util;

public class RealPatient {

	// private String patientID;//患者编号
	private Integer active;// 激活期数值
	private String status;// 患者实时状态

	public RealPatient(int active, String status) {
		this.active = active;
		this.status = status;
	}

	public Integer getActive() {
		return active;
	}

	public void setActive(Integer active) {
		this.active = active;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
