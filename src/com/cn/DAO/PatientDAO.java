package com.cn.DAO;

import com.cn.POJO.Patient;

public interface PatientDAO {

	//查询信息，此方法无效，可通过查询user对象，并通过getPatient获取Patient对象
//	public Patient findByPid(String pid);
	
	//保存患者信息
	public void save(Patient patient);
	
	//更改患者信息
	public void update(Patient patient);
	
	//删除患者信息
	public void delete(Patient patient);
	
	//根据患者ID查询患者
	public Patient findByPid(String pid);
	
}
