package com.cn.DAO;

import com.cn.POJO.Exstatistic;

import net.sf.json.JSONObject;

public interface ExstatisticDAO {

	public void save(Exstatistic exstatistic);
	
	//返回统计结果
	public JSONObject statictisResult(Integer pid);
}
