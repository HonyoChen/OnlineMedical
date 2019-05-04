package com.cn.Action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import org.apache.struts2.ServletActionContext;
import com.cn.POJO.Dandp;
import com.cn.POJO.Patient;
import com.cn.Service.DandpService;
import com.cn.Service.DoctorService;
import com.cn.Service.PatientService;
import com.opensymphony.xwork2.ActionSupport;

public class DoctorAction extends ActionSupport {

	private DoctorService doctorService;
	public DoctorService getDoctorService() {
		return doctorService;
	}
	public void setDoctorService(DoctorService doctorService) {
		this.doctorService = doctorService;
	}
	
	private DandpService dandpService;
	public DandpService getDandpService() {
		return dandpService;
	}
	public void setDandpService(DandpService dandpService) {
		this.dandpService = dandpService;
	}
	
	private PatientService patientService;
	public PatientService getPatientService() {
		return patientService;
	}
	public void setPatientService(PatientService patientService) {
		this.patientService = patientService;
	}

	// ajax数据传输
	private List<Dandp> list = new ArrayList<Dandp>();
	public List<Dandp> getList() {
		return list;
	}
	public void setList(List<Dandp> list) {
		this.list = list;
	}

	public String findAllPatients() {
		System.out.println("查找医生所有病人");
		list.clear();

		String did = ServletActionContext.getRequest().getParameter("did");
		
		System.out.println("查找到医生");
		
		list = dandpService.dandpsByDid(did);
		
		System.out.println("list元素个数：" + list.size());
		Collections.sort(list, new Comparator<Dandp>(){
			@Override
			public int compare(Dandp dp1, Dandp dp2) {
				return dp2.getTime().compareTo(dp1.getTime());
			}
		});
		
		for (Dandp dandp : list) {
			Patient patient = dandp.getPatient();
			patient.setUser(null);
			patient.setDandps(null);
			patient.setMrecords(null);
			patient.setExrecords(null);
			dandp.setPatient(patient);
			dandp.setDoctor(null);
		}
		
		return "SUCCESS";
	}
	
//	public String filter(){
//		System.out.println("筛选患者列表");
//		list.clear();
//		
//		String did = ServletActionContext.getRequest().getParameter("did");
//		String sex = ServletActionContext.getRequest().getParameter("sex");
//		String age = ServletActionContext.getRequest().getParameter("age");
//		System.out.println("Did:" + did + ",Sex:" + sex + ",Age:" + age);
//		
////		Doctor doctor = doctorService.findByDid(did);
//		List<Dandp> tmpList = dandpService.patientsAllByDid(did);//获取当前医生下所有患者
//		Calendar calendar = Calendar.getInstance();
//		calendar.setTime(new Date());
//		
//		if (sex == null || sex.equals("")) {
//			if (age == null || age.equals("")) {
//				list = tmpList;
//			}else if("7".equals(age)){
//				int to = 10 * Integer.parseInt(age);
//				calendar.add(Calendar.YEAR, -to);
//				calendar.add(Calendar.DATE, 1);//日期上界加1
//				Date upperDate = calendar.getTime();
//				for(Dandp dandp : tmpList){
//					Patient patient = dandp.getPatient();
//					if (patient.getBirthday().before(upperDate)) {
//						list.add(dandp);
//					}
//				}
//			}else {
//				int from = 10 * (Integer.parseInt(age)+1);
//				int to = 10 * Integer.parseInt(age);
//				calendar.add(Calendar.YEAR, -from);
//				Date lowerDate = calendar.getTime();
//				calendar.setTime(new Date());
//				calendar.add(Calendar.YEAR, -to);
//				calendar.add(Calendar.DATE, 1);
//				Date upperDate = calendar.getTime();
//				for(Dandp dandp : tmpList){
//					Patient patient = dandp.getPatient();
//					if (patient.getBirthday().after(lowerDate) && patient.getBirthday().before(upperDate)) {
//						list.add(dandp);
//					}
//				}
//			}
//		}else {
//			if (age == null || age.equals("")) {
//				for (Dandp dandp : tmpList) {
//					Patient patient = dandp.getPatient();
//					String psex = patient.getSex().toString();
//					if (sex.equals(psex)) {
//						list.add(dandp);
//					}
//				}
//			}else if("7".equals(age)){
//				int to = 10 * Integer.parseInt(age);
//				calendar.add(Calendar.YEAR, -to);
//				calendar.add(Calendar.DATE, 1);//日期上界加1
//				Date upperDate = calendar.getTime();
//				for(Dandp dandp : tmpList){
//					Patient patient = dandp.getPatient();
//					if (sex.equals(patient.getSex().toString()) && patient.getBirthday().before(upperDate)) {
//						list.add(dandp);
//					}
//				}
//			}else {
//				int from = 10 * (Integer.parseInt(age)+1);
//				int to = 10 * Integer.parseInt(age);
//				calendar.add(Calendar.YEAR, -from);
//				Date lowerDate = calendar.getTime();
//				calendar.setTime(new Date());
//				calendar.add(Calendar.YEAR, -to);
//				calendar.add(Calendar.DATE, 1);
//				Date upperDate = calendar.getTime();
//				for(Dandp dandp : tmpList){
//					Patient patient = dandp.getPatient();
//					if (sex.equals(patient.getSex().toString()) && patient.getBirthday().after(lowerDate) && patient.getBirthday().before(upperDate)) {
//						list.add(dandp);
//					}
//				}
//			}
//		}
//		
//		return "SUCCESS";
//	}
	
	public String findByPatientName(){
		System.out.println("按姓名查找病人");
		list.clear();
		
		String patientName = ServletActionContext.getRequest().getParameter("patientName");
		String did = ServletActionContext.getRequest().getParameter("did");
		
		List<Dandp> tmpList = dandpService.dandpsByDid(did);//获取当前医生下所有患者
		for(Dandp dandp : tmpList){
			Patient patient = dandp.getPatient();
			if (patient.getName().equals(patientName)) {
				list.add(dandp);
			}
		}
		return "SUCCESS";
	}
}
