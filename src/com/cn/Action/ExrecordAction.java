package com.cn.Action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Dandp;
import com.cn.Service.DandpService;
import com.cn.Service.ExrecordService;
import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ExrecordAction extends ActionSupport {

	private JSONArray array;
	public JSONArray getArray() {
		return array;
	}
	public void setArray(JSONArray array) {
		this.array = array;
	}
	
	private int result;
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	
	private ExrecordService exrecordService;

	public ExrecordService getExrecordService() {
		return exrecordService;
	}

	public void setExrecordService(ExrecordService exrecordService) {
		this.exrecordService = exrecordService;
	}

	private DandpService dandpService;

	public DandpService getDandpService() {
		return dandpService;
	}

	public void setDandpService(DandpService dandpService) {
		this.dandpService = dandpService;
	}

	public String exrecordsByPid() {
		System.out.println("进入查询异常记录Action");
		String pid = ServletActionContext.getRequest().getParameter("pid");
		// array = null;
		array = exrecordService.findRecordsByPid(pid);
		return "SUCCESS";
	}

	// 查找过去七天医生对应患者七天内的发病记录数量
	public String findLastSevenDaysExNumsByDid() {
		JSONArray json = new JSONArray();
		String did = ServletActionContext.getRequest().getParameter("did");
		// 获取患者编号
		List<Dandp> pNums = dandpService.dandpsByDid(did);
		for (Dandp dandp : pNums) {
			JSONObject object = new JSONObject();
			Integer pid = dandp.getPatient().getPid();
			object.put("id", pid);
			object.put("name", dandp.getPatient().getName());
			object.put("age", getAgeByBirth(dandp.getPatient().getBirthday()));
			object.put("status", -1);
			// 获取最后一次发病记录
			object.put("last", exrecordService.findLastRecordByPid(pid));
			
			List<Integer> counts = new ArrayList<Integer>();
			for (int i = -7; i < 0; i++) {
				Integer c = exrecordService.countOnSpecialDay(pid, i);
				counts.add(c);
			}
			System.out.println(counts.toString());
			object.put("cycle", counts);
			json.add(object);
		}
		array = json;
		return "SUCCESS";
	}
	
	//查找患者在几个周期内发病次数
	public String countsOnTimePeriod(){
		String pid = ServletActionContext.getRequest().getParameter("pid");
		int[] periods = {-7, -30, -90, -180, -360};
		JSONObject object = new JSONObject();
		for (int num : periods) {
			int count = exrecordService.countOnTimePeriod(Integer.parseInt(pid), num);
			switch (num) {
			case -7:
				object.put("week", count);
				break;
			case -30:
				object.put("month", count);
				break;
			case -90:
				object.put("quarter", count);
				break;
			case -180:
				object.put("semester", count);
				break;
			case -360:
				object.put("year", count);
				break;
			default:
				break;
			}
		}
		System.out.println(object.toString());
		JSONArray ja = new JSONArray();
		ja.add(object);
		array = ja;
		return "SUCCESS";
	}
	
	public String deleteExrecord(){
		String eid = ServletActionContext.getRequest().getParameter("eid");
		exrecordService.deleteExrecord(eid);
		result = 1;
		return "SUCCESS";
	}
	
	public int getAgeByBirth(Date birthDay) {
        int age = 0;
        Calendar cal = Calendar.getInstance();
        if (cal.before(birthDay)) { //出生日期晚于当前时间，无法计算
            throw new IllegalArgumentException(
                    "The birthDay is before Now.It's unbelievable!");
        }
        int yearNow = cal.get(Calendar.YEAR);  //当前年份
        int monthNow = cal.get(Calendar.MONTH);  //当前月份
        int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH); //当前日期
        cal.setTime(birthDay);
        int yearBirth = cal.get(Calendar.YEAR);
        int monthBirth = cal.get(Calendar.MONTH);
        int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);
        age = yearNow - yearBirth;   //计算整岁数
        if (monthNow <= monthBirth) {
            if (monthNow == monthBirth) {
                if (dayOfMonthNow < dayOfMonthBirth) age--;//当前日期在生日之前，年龄减一
            } else {
                age--;//当前月份在生日之前，年龄减一
            }
        }
        return age;
    }
}
