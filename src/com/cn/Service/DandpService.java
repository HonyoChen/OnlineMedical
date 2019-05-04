package com.cn.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.cn.DAO.DandpDAO;
import com.cn.POJO.Dandp;

@Transactional
public class DandpService {

	private DandpDAO dandpDAO;
	public DandpDAO getDandpDAO() {
		return dandpDAO;
	}
	public void setDandpDAO(DandpDAO dandpDAO) {
		this.dandpDAO = dandpDAO;
	}
	
	// 获取所有挂号did医生的挂号列表
	public List<Dandp> dandpsByDid(String did){
		return dandpDAO.dandpsByDid(did);
	}
	
	// 获取患者的挂号信息
	public Dandp dandpByPid(String pid){
		System.out.println("进入患者挂号列表查询");
		return dandpDAO.dandpsByPid(pid);
	}
	
	//通过id获取挂号信息
	public Dandp dandpById(String id){
		return dandpDAO.dandpById(id);
	}
	
	//删除
	public void delete(Dandp dandp){
		dandpDAO.delete(dandp);
	}
	
	//保存
	public void save(Dandp dandp){
		dandpDAO.save(dandp);
	}
	
	//更新
	public void update(Dandp dandp){
		dandpDAO.update(dandp);
	}
	
	public String findDidByPid(String pid){
		return dandpDAO.findDidByPid(pid);
	}
}
