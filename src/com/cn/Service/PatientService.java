package com.cn.Service;

import org.springframework.transaction.annotation.Transactional;

import com.cn.DAO.PatientDAO;
import com.cn.POJO.Patient;

@Transactional
public class PatientService {

	private PatientDAO patientDAO;
	public PatientDAO getPatientDAO() {
		return patientDAO;
	}
	public void setPatientDAO(PatientDAO patientDAO) {
		this.patientDAO = patientDAO;
	}
	
//	public Patient findByPid(String pid){
//		return patientDAO.findByPid(pid);
//	}
	
	public void save(Patient patient){
		patientDAO.save(patient);
	}
	
	public void update(Patient patient){
		patientDAO.update(patient);
	}
	
	public void deletePatient(Patient patient){
		patientDAO.delete(patient);
	}
	
	public Patient findByPid(String pid){
		return patientDAO.findByPid(pid);
	}
}
