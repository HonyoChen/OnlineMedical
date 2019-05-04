package com.cn.Service;

import java.math.BigInteger;
import java.sql.Timestamp;

import com.cn.DAO.ExrecordDAO;
import com.cn.POJO.Exrecord;

import net.sf.json.JSONArray;

public class ExrecordService {

	private ExrecordDAO exrecordDAO;
	public ExrecordDAO getExrecordDAO() {
		return exrecordDAO;
	}
	public void setExrecordDAO(ExrecordDAO exrecordDAO) {
		this.exrecordDAO = exrecordDAO;
	}
	
	public void saveExrecord(Exrecord exrecord){
		exrecordDAO.save(exrecord);
	}
	
	public void deleteExrecord(String rid){
		exrecordDAO.delete(rid);
	}
	
	public JSONArray findRecordsByPid(String pid){
		return exrecordDAO.findExrecordsByPid(pid);
	}
	
	public String findLastRecordByPid(Integer pid){
		return exrecordDAO.findLastRecordByPid(pid);
	}
	
	public Integer countOnSpecialDay(Integer pid, Integer day){
		return exrecordDAO.countOnSpecialDay(pid, day);
	}
	
	public Integer countOnTimePeriod(Integer pid, Integer day){
		return exrecordDAO.countOnTimePeriod(pid, day);
	}
	
	public Exrecord findExrecord(String eid){
		return exrecordDAO.findExrecord(eid);
	}
	
	public void updateConfirm(Exrecord exrecord){
		exrecordDAO.updateConfirm(exrecord);
	}
	
}
