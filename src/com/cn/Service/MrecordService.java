package com.cn.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.cn.DAO.MrecordDAO;
import com.cn.POJO.Mrecord;
@Transactional
public class MrecordService {

	private MrecordDAO mrecordDAO;
	public MrecordDAO getMrecordDAO() {
		return mrecordDAO;
	}
	public void setMrecordDAO(MrecordDAO mrecordDAO) {
		this.mrecordDAO = mrecordDAO;
	}
	
	public void save(Mrecord mrecord){
		mrecordDAO.save(mrecord);
	}
	
	public List<Mrecord> findHistoryRecordByPid(String pid){
		return mrecordDAO.findByPid(pid);
	}
	
	public List<Mrecord> findHistoryRecordByDid(String did){
		return mrecordDAO.findByDid(did);
	}
	
	public void deleteMrecord(Mrecord mrecord){
		mrecordDAO.delete(mrecord);
	}
}
