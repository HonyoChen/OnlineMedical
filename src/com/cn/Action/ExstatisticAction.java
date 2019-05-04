package com.cn.Action;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Exrecord;
import com.cn.POJO.Exstatistic;
import com.cn.Service.ExrecordService;
import com.cn.Service.ExstatisticService;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONObject;

public class ExstatisticAction extends ActionSupport {

	private ExstatisticService exstatisticService;
	public ExstatisticService getExstatisticService() {
		return exstatisticService;
	}
	public void setExstatisticService(ExstatisticService exstatisticService) {
		this.exstatisticService = exstatisticService;
	}
	
	private ExrecordService exrecordService;
	public ExrecordService getExrecordService() {
		return exrecordService;
	}
	public void setExrecordService(ExrecordService exrecordService) {
		this.exrecordService = exrecordService;
	}
	
	private int result;
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	
	private JSONObject json;
	public JSONObject getJson() {
		return json;
	}
	public void setJson(JSONObject json) {
		this.json = json;
	}
	
	public String saveExstatistic(){
		String eid = ServletActionContext.getRequest().getParameter("eid");
		String onset = ServletActionContext.getRequest().getParameter("onset");
		String factor = ServletActionContext.getRequest().getParameter("factor");
		String state = ServletActionContext.getRequest().getParameter("state");
		String status = ServletActionContext.getRequest().getParameter("status");
		
		Exstatistic exstatistic = new Exstatistic();
		Exrecord exrecord = exrecordService.findExrecord(eid);
		exrecord.setIsConfirmed(true);
		exrecordService.updateConfirm(exrecord);
		exstatistic.setExrecord(exrecord);
		exstatistic.setOnset(Integer.parseInt(onset));
		exstatistic.setFactor(Integer.parseInt(factor));
		exstatistic.setState(Integer.parseInt(state));
		exstatistic.setStatus(Integer.parseInt(status));
		exstatisticService.save(exstatistic);
		result = 1;
		return "SUCCESS";
	}
	
	public String returnStatictisResult(){
		String pid = ServletActionContext.getRequest().getParameter("pid");
		System.out.println("获取统计结果参数为：" + pid);
		JSONObject object = exstatisticService.statictisResult(Integer.parseInt(pid));
		json = object;
		return "SUCCESS";
	}
}
