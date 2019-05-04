package com.cn.Service;

import com.cn.DAO.ExstatisticDAO;
import com.cn.POJO.Exstatistic;

import net.sf.json.JSONObject;

public class ExstatisticService {

	private ExstatisticDAO exstatisticDAO;
	public void setExstatisticDAO(ExstatisticDAO exstatisticDAO) {
		this.exstatisticDAO = exstatisticDAO;
	}
	public ExstatisticDAO getExstatisticDAO() {
		return exstatisticDAO;
	}
	
	public void save(Exstatistic exstatistic){
		exstatisticDAO.save(exstatistic);
	}
	
	public JSONObject statictisResult(Integer pid){
		return exstatisticDAO.statictisResult(pid);
	}
}
