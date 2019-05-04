package com.cn.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.cn.DAO.DoctorDAO;
import com.cn.POJO.Doctor;

@Transactional
public class DoctorService {

	private DoctorDAO doctorDAO;
	public DoctorDAO getDoctorDAO() {
		return doctorDAO;
	}
	public void setDoctorDAO(DoctorDAO doctorDAO) {
		this.doctorDAO = doctorDAO;
	}
	
//	//根据ID查询医生
//	public Doctor findByDid(String did){
//		return doctorDAO.findByDid(did);
//	}
	
	//保存医生信息
	public void save(Doctor doctor){
		doctorDAO.save(doctor);
	}
	
	//更新医生信息
	public void update(Doctor doctor){
		doctorDAO.update(doctor);
	}
	
	//查找所有医生
	public List<Doctor> findAllDoctors(){
		return doctorDAO.allDoctors();
	}
	
	// 删除医生
	public void deleteDoctor(Doctor doctor){
		doctorDAO.delete(doctor);
	}
}
