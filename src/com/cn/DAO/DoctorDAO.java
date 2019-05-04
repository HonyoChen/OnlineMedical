package com.cn.DAO;

import java.util.List;

import com.cn.POJO.Doctor;

public interface DoctorDAO {

	// 查询信息，此方法无效，需通过查询user，并通过getDoctor方法获取医生对象
//	public Doctor findByDid(String did);
	
	// 返回所有姓名不为空的医生列表，即所有注册完成的医生
	public List<Doctor> allDoctors();
	
	// 保存医生对象
	public void save(Doctor doctor);

	// 更改医生信息
	public void update(Doctor doctor);
	
	// 删除医生信息
	public void delete(Doctor doctor);
	
}
