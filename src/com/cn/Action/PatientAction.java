package com.cn.Action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Dandp;
import com.cn.POJO.Doctor;
import com.cn.POJO.Patient;
import com.cn.POJO.User;
import com.cn.Service.DandpService;
import com.cn.Service.DoctorService;
import com.cn.Service.PatientService;
import com.cn.Service.UserService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class PatientAction extends ActionSupport {

	private PatientService patientService;

	public PatientService getPatientService() {
		return patientService;
	}

	public void setPatientService(PatientService patientService) {
		this.patientService = patientService;
	}

	private DoctorService doctorService;

	public DoctorService getDoctorService() {
		return doctorService;
	}

	public void setDoctorService(DoctorService doctorService) {
		this.doctorService = doctorService;
	}

	private UserService userService;

	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	private DandpService dandpService;

	public DandpService getDandpService() {
		return dandpService;
	}

	public void setDandpService(DandpService dandpService) {
		this.dandpService = dandpService;
	}

	private List<Doctor> res = new ArrayList<Doctor>();
	public List<Doctor> getRes() {
		return res;
	}
	public void setRes(List<Doctor> res) {
		this.res = res;
	}
	
	private int status;
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

	// 列表下查看医生
	public String findDoctors() {
		System.out.println("查找医生findDoctors");
		String pid = ServletActionContext.getRequest().getParameter("pid");
		System.out.println("PID值为：" + pid);

		Dandp dandp = dandpService.dandpByPid(pid);

		if (dandp == null) {
			System.out.println("当前患者没有挂号医生");
			res = doctorService.findAllDoctors();
			for (Doctor doctor : res) {
				doctor.setUser(null);
				doctor.setDandps(null);
				doctor.setMrecords(null);
				doctor.setCfiles(null);
			}
		} else {
			Set<Dandp> li = new HashSet<Dandp>();
			System.out.println("当前患者具有挂号医生");
			Doctor doctor = dandp.getDoctor();
			doctor.setUser(null);
			doctor.setMrecords(null);
			doctor.setCfiles(null);
			dandp.setPatient(null);
			dandp.setDoctor(null);
			System.out.println("获取病情描述：" + dandp.getDescription());
			li.add(dandp);
			doctor.setDandps(li);
			res.add(doctor);
		}
		return "SUCCESS";
	}
	
	public String isReg(){
		System.out.println("判断患者是否挂号");
		String pid = ServletActionContext.getRequest().getParameter("pid");
		System.out.println(pid);
		Dandp dandp = dandpService.dandpByPid(pid);
		if (dandp == null) {
			System.out.println("当前患者没有挂号医生");
			status = 0;
		}else {
			System.out.println("当前患者具有挂号医生");
			status = 1;
		}
		return "SUCCESS";
	}
}
