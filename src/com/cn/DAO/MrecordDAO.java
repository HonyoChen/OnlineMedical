package com.cn.DAO;

import java.util.List;

import com.cn.POJO.Mrecord;

public interface MrecordDAO {
	
	// 保存病历对象
	public void save(Mrecord mrecord);
	
	// 根据患者id查询历史病历记录
	public List<Mrecord> findByPid(String pid);
	
	//根据医生id查询历史病历记录
	public List<Mrecord> findByDid(String did);
	
	// 删除病历
	public void delete(Mrecord mrecord);
}
