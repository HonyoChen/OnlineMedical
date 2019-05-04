package com.cn.DAO;

import java.sql.Timestamp;

import com.cn.POJO.Exrecord;

import net.sf.json.JSONArray;

public interface ExrecordDAO {

	//新增异常记录
	public void save(Exrecord exrecord);
	
	//误诊，删除记录，传参为eid
	public void delete(String rid);
	
	//返回信息
	public JSONArray findExrecordsByPid(String pid);
	
	//返回患者最后一次发病时间
	public String findLastRecordByPid(Integer pid);
	
	//返回特定日子发病次数统计
	public Integer countOnSpecialDay(Integer pid, Integer day);
	
	//统计周期内发病次数
	public Integer countOnTimePeriod(Integer pid, Integer day);
	
	//根据EID返回Exrecord对象
	public Exrecord findExrecord(String eid);
	
	//更新确认状态
	public void updateConfirm(Exrecord exrecord);
	
}
