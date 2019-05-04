package com.cn.Action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Dandp;
import com.cn.POJO.Doctor;
import com.cn.POJO.Mrecord;
import com.cn.POJO.Patient;
import com.cn.POJO.User;
import com.cn.Service.DandpService;
import com.cn.Service.DoctorService;
import com.cn.Service.MrecordService;
import com.cn.Service.PatientService;
import com.cn.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

public class MrecordAction extends ActionSupport {

	private MrecordService mrecordService;
	public MrecordService getMrecordService() {
		return mrecordService;
	}
	public void setMrecordService(MrecordService mrecordService) {
		this.mrecordService = mrecordService;
	}
	
	private UserService userService;
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	private DoctorService doctorService;
	public DoctorService getDoctorService() {
		return doctorService;
	}
	public void setDoctorService(DoctorService doctorService) {
		this.doctorService = doctorService;
	}
	
	private PatientService patientService;
	public PatientService getPatientService() {
		return patientService;
	}
	public void setPatientService(PatientService patientService) {
		this.patientService = patientService;
	}
	
	private DandpService dandpService;
	public DandpService getDandpService() {
		return dandpService;
	}
	public void setDandpService(DandpService dandpService) {
		this.dandpService = dandpService;
	}
	
	private int result;
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	
	private List<Mrecord> list = new ArrayList<Mrecord>();
	public List<Mrecord> getList() {
		return list;
	}
	public void setList(List<Mrecord> list) {
		this.list = list;
	}
	
	public String addMrecord(){
		System.out.println("进入添加病历Action");
		String id = ServletActionContext.getRequest().getParameter("id");
		String content = ServletActionContext.getRequest().getParameter("content");
		
//		String id = "4";
//		String content = "诊断结果";
		
		System.out.println("id:" + id);
//		System.out.println("Pid:" + pid);
//		System.out.println("发病部位：" + part);
//		System.out.println("病情描述：" + desc);
		System.out.println("填写内容：" + content);
		
//		Patient patient = patientService.findByPid(pid);
		
//		Doctor doctor = userService.findByUid(did).getDoctor();
		
		Dandp dandp = dandpService.dandpById(id);
		System.out.println("查询完成dandp对象");
		
//		User user = userService.findByWhat("uid", pid);
//		System.out.println("Username:" + user.getUsername());
//		Patient patient = user.getPatient();
////		Patient patient = patientService.findByPid(pid);
//		System.out.println(patient.getName());
//		Doctor doctor = userService.findByWhat("uid", did).getDoctor();
//		System.out.println(doctor.getName());
		
		System.out.println(dandp.getDoctor().getName());
		System.out.println(dandp.getPatient().getName());
		System.out.println(dandp.getPart());
		
		Mrecord mrecord = new Mrecord();
		mrecord.setDoctor(dandp.getDoctor());
		mrecord.setPatient(dandp.getPatient());
		mrecord.setTime(new Timestamp(new Date().getTime()));
		mrecord.setPart(dandp.getPart());
		mrecord.setDescription(dandp.getDescription());
		mrecord.setContent(content);
		
		System.out.println(mrecord.getDoctor().getName());
		System.out.println(mrecord.getDescription());
		System.out.println(mrecord.getContent());
		
		mrecordService.save(mrecord);
		dandpService.delete(dandp);
		
		System.out.println("执行完成");
		
		result = 1;
		
		return "SUCCESS";
	}
	
	public String findHistoryRecordByPid(){
		list.clear();
		System.out.println("进入findHistoryRecordByPid");
		String pid = ServletActionContext.getRequest().getParameter("pid");
		list = mrecordService.findHistoryRecordByPid(pid);
		if(list.size() != 0){
			for(Mrecord mrecord : list){
				mrecord.setPatient(null);
				Doctor doctor = mrecord.getDoctor();
				doctor.setDandps(null);
				doctor.setMrecords(null);
				doctor.setUser(null);
				doctor.setCfiles(null);
				mrecord.setDoctor(doctor);
			}
		}else {
			list = null;
		}
		
		return "SUCCESS";
	}
	
	public String findHistoryRecordByDid(){
		list.clear();
		String did = ServletActionContext.getRequest().getParameter("did");
		System.out.println("Did=" + did);
		list = mrecordService.findHistoryRecordByDid(did);
		if(list.size() != 0){
			for(Mrecord mrecord : list){
				mrecord.setDoctor(null);
				Patient patient = mrecord.getPatient();
				patient.setDandps(null);
				patient.setMrecords(null);
				patient.setUser(null);
				patient.setExrecords(null);
				mrecord.setPatient(patient);
			}
		}else {
			list = null;
		}
		return "SUCCESS";
	}
	
	public String saveDandp(){
		String pid = ServletActionContext.getRequest().getParameter("pid");
		String did = ServletActionContext.getRequest().getParameter("did");
		String part = ServletActionContext.getRequest().getParameter("part");
		String content = ServletActionContext.getRequest().getParameter("content");
		
		System.out.println("获取参数：" + pid + ";" + did + ";" + part + ";" + content);
		
		Patient patient = userService.findByUid(pid).getPatient();
		Doctor doctor = userService.findByUid(did).getDoctor();
		
		Dandp dandp = new Dandp();
		dandp.setDescription(content);
		dandp.setDoctor(doctor);
		dandp.setPart(Integer.parseInt(part));
		dandp.setPatient(patient);
		dandp.setTime(new Timestamp(new Date().getTime()));
		
		dandpService.save(dandp);
		System.out.println("保存完毕");
		
		result = 1;
		return "SUCCESS";
	}
	
	public String deleteDandp(){
		String pid = ServletActionContext.getRequest().getParameter("pid");
		
		Dandp dandp = dandpService.dandpByPid(pid);
		dandpService.delete(dandp);
		result = 1;
		return "SUCCESS";
	}
	
	public String updateDandp(){
		String id = ServletActionContext.getRequest().getParameter("id");
		String part = ServletActionContext.getRequest().getParameter("part");
		String desc = ServletActionContext.getRequest().getParameter("desc");
		
		Dandp dandp = dandpService.dandpById(id);
		dandp.setPart(Integer.parseInt(part));
		dandp.setDescription(desc);
		dandpService.update(dandp);
		result = 1;
		return "SUCCESS";
	}
	
	public String deleteDandpById(){
		String id = ServletActionContext.getRequest().getParameter("id");
		
		Dandp dandp = dandpService.dandpById(id);
		dandpService.delete(dandp);
		result = 1;
		return "SUCCESS";
	}
	
	public String batchDeleteDandps(){
		String arr = ServletActionContext.getRequest().getParameter("ids");
		String[] ids = arr.split("\\s+");
		for (String id : ids) {
			Dandp dandp = dandpService.dandpById(id);
			dandpService.delete(dandp);
		}
		result = 1;
		return "SUCCESS";
	}
}
