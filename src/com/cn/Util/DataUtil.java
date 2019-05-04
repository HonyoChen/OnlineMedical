package com.cn.Util;

/*
 * 用于作为数据监听的Util类
 */
public class DataUtil {

	private String userID;//保存用户ID
	private float[] ecgs;//保存当前ECG数据
	private int status;//保存用户当前患病状态
	private boolean flush;//刷新状态
	
	public boolean isFlush() {
		return flush;
	}
	public void setFlush(boolean flush) {
		this.flush = flush;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public float[] getEcgs() {
		return ecgs;
	}
	public void setEcgs(float[] ecgs) {
		this.ecgs = ecgs;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
