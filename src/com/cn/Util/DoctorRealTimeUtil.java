package com.cn.Util;

import java.util.HashMap;
import java.util.Map;
import net.sf.json.JSONObject;

/**
 * 医生实时类，用于监测医生实时在线患者数量及患者实时发病状态
 * @author Honyo
 *
 */

public class DoctorRealTimeUtil {

	//存储格式<'医生编号'：'患者Map集合'>，其中患者集合<'患者编号','患者等待次数'>
	private static Map<String, Map<String, RealPatient>> online = new HashMap<String, Map<String, RealPatient>>();
	//存储患者当前状态
//	private static Map<String, String> currentStatus = new HashMap<String, String>();
	
	//获取doctor_no医生的实时在线患者数量
	public static int getCurrentPatientNumber(String doctor_no){
		return online.get(doctor_no).size();
	}
	//获取doctor_no医生的患者编号集合
//	public static String[] getPatientsNo(String doctor_no){
//		Map<String, Integer> patients = online.get(doctor_no);
//		String[] patientsNo = new String[patients.keySet().size()];
//		patients.keySet().toArray(patientsNo);
//		return patientsNo;
//	}
	//获取患者在线状态及发病状态
	public static Map<String, RealPatient> getPatients(String doctor_no){
		return online.get(doctor_no);
	}
	
	//设置患者实时状态
	public static void setPatientCurrentStatus(String doctor_no, String patient_no, String status){
//		currentStatus.put(patient_no, status);
		RealPatient patient = new RealPatient(10, status);
		if (online.get(doctor_no) == null) {
			online.put(doctor_no, new HashMap<String, RealPatient>());
		}
		Map<String, RealPatient> patients = online.get(doctor_no);
		patients.put(patient_no, patient);
	}
	
	public static JSONObject getObject(String doctor_no){
		JSONObject outer = new JSONObject();
		Map<String, RealPatient> patients = getPatients(doctor_no);
		if (patients != null) {
			outer.put("number", patients.size());
			JSONObject inner = JSONObject.fromObject(patients);
			outer.put("patients", inner);
		}else {
			outer.put("number", 0);
			outer.put("patients", null);
		}
		return outer;
	}
	//获取患者实时状态
//	public static String getCurrentStatus(String patient_no){
//		return currentStatus.get(patient_no);
//	}
	
	//实时患者
//	public static void setRealTimePatient(String doctor_no, String patient_no){
////		Map<Integer, Integer> patientMap = new HashMap<Integer, Integer>();
////		patientMap.put(patient_no, 10);
//		//若未给医生建档
//		if (online.get(doctor_no) == null) {
//			Map<String, Integer> patient_set = new HashMap<String, Integer>();
//			online.put(doctor_no, patient_set);
//		}
//		//医生已经存在档案
//		Map<String, Integer> patient_set = online.get(doctor_no);//获取所有患者用户
////		if (patient_set.containsKey(patient_no)) {
//		patient_set.put(patient_no, 10);
////		}
//	}
	
	//30秒缓冲时间
	public static void reduce(){
		try {
			for(String doctor_no_key : online.keySet()){//遍历外部集合，即以医生编号作为索引
				Map<String, RealPatient> patients = online.get(doctor_no_key);//获取医生的患者集合
				for(String patient_no_key : patients.keySet()){
					RealPatient actsta = patients.get(patient_no_key);//获取患者的激活与实时状态
					actsta.setActive(actsta.getActive()-1);
					patients.put(patient_no_key, actsta);
					if(patients.get(patient_no_key).getActive() <= 0){
						patients.remove(patient_no_key);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
