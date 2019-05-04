package com.cn.DAO;

import java.util.List;

import com.cn.POJO.Dandp;

public interface DandpDAO {

	//某医生的所有病人
	public List<Dandp> dandpsByDid(String did);
	
	//某病人的所有医生
	public Dandp dandpsByPid(String pid);
	
	//通过id查找
	public Dandp dandpById(String id);
	
	//删除方法
	public void delete(Dandp dandp);
	
	//保存
	public void save(Dandp dandp);
	
	//修改
	public void update(Dandp dandp);
	
	//根据患者ID查询医生ID
	public String findDidByPid(String pid);
}
