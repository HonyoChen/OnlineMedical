package com.cn.Action;

import java.io.IOException;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.components.Else;

import com.cn.POJO.Dandp;
import com.cn.POJO.Doctor;
import com.cn.POJO.Message;
import com.cn.POJO.Mrecord;
import com.cn.POJO.Patient;
import com.cn.POJO.User;
import com.cn.Service.DandpService;
import com.cn.Service.DoctorService;
import com.cn.Service.MessageService;
import com.cn.Service.MrecordService;
import com.cn.Service.PatientService;
//import com.cn.POJO.Contact;
//import com.cn.POJO.Userprofile;
//import com.cn.Service.ContactService;
//import com.cn.Service.UserprofileService;
import com.cn.Service.UserService;
import com.cn.Util.RandomUUID;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

//用户模块Action类
public class UserAction extends ActionSupport implements ModelDriven<User>{
	
	//模型驱动使用对象
	private User user = new User();
	@Override
	public User getModel() {
		return user;
	}
	
	//ajax数据传输
	private int result;
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	
	private List<User> userList;
	public List<User> getUserList() {
		return userList;
	}
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	//注入UserService
	private UserService userService;
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	private PatientService patientService;
	public PatientService getPatientService() {
		return patientService;
	}
	public void setPatientService(PatientService patientService) {
		this.patientService = patientService;
	}
	private DoctorService doctorService;
	public DoctorService getDoctorService() {
		return doctorService;
	}
	public void setDoctorService(DoctorService doctorService) {
		this.doctorService = doctorService;
	}
	
	private DandpService dandpService;
	public DandpService getDandpService() {
		return dandpService;
	}
	public void setDandpService(DandpService dandpService) {
		this.dandpService = dandpService;
	}
	private MrecordService mrecordService;
	public MrecordService getMrecordService() {
		return mrecordService;
	}
	public void setMrecordService(MrecordService mrecordService) {
		this.mrecordService = mrecordService;
	}
	
	private MessageService messageService;
	public MessageService getMessageService() {
		return messageService;
	}
	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}
	
	
	//登录方法
	public String login(){
		
		User loginUser = userService.login(user);
		if (loginUser != null) {
			if (loginUser.getRole() == 0) {
				Patient patient = loginUser.getPatient();
				patient.setUser(null);
				patient.setDandps(null);
				patient.setMrecords(null);
				patient.setExrecords(null);
				loginUser.setPatient(patient);
				loginUser.setDoctor(null);
			}else if(loginUser.getRole() == 1){
				loginUser.setPatient(null);
				Doctor doctor = loginUser.getDoctor();
				doctor.setUser(null);
				doctor.setDandps(null);
				doctor.setMrecords(null);
				doctor.setCfiles(null);
				loginUser.setDoctor(doctor);
			}else {
				loginUser.setPatient(null);
				loginUser.setDoctor(null);
			}
			
			//Session保持
			ServletActionContext.getRequest().getSession().setAttribute("loginUser", loginUser);
			return "SUCCESS";
		}else {
			return "ERROR";
		}
	}
	
	/*
	 * 患者注册方法
	 * 连接user表和patient表，设置相关属性
	 */
	public String register(){
		System.out.println("开始注册");
		String uuid = RandomUUID.getRandomUUID();
		user.setRole(0);
		user.setUuid(uuid);
		userService.register(user);//保存user
		System.out.println("user注册完成");
		
		Patient patient = new Patient();
		patient.setPid(user.getUid());
		patientService.save(patient);
		System.out.println("注册患者完成");
		//Patient p = user.getPatient();
		//System.out.println(patient.getUser().getUsername());
//		patient.setPid(user.getUid());
		patient.setUser(user);
		patientService.update(patient);
		//多表连接
		user.setPatient(patient);
		userService.update(user);
		System.out.println(patient.getUser().getUsername());
		System.out.println(user.getPatient().getPid());
		System.out.println("彻底完成");
		
//		System.out.println("阶段性完成");
		User loginUser = userService.login(user);
		ServletActionContext.getRequest().getSession().setAttribute("loginUser", loginUser);
		return "RSUCCESS";
	}
	
	//退出登录，不用执行数据库操作
	public String quit(){
		System.out.println("退出登录");
		//销毁session
		ServletActionContext.getRequest().getSession().invalidate();
		return "QUIT";
	}
	
	//ajax验证用户名、邮箱、手机号是否被注册
	public String isRegister() throws IOException{
		System.out.println("进入验证Action");
		//获取ajax传递的参数
		String method = ServletActionContext.getRequest().getParameter("method");
		String parameter = ServletActionContext.getRequest().getParameter("parameter");
		
		System.out.println("查询方法:" + method);
		System.out.println("查询参数:" + parameter);
		User rUser = userService.findByWhat(method, parameter);
		if(rUser == null){
			this.result = 0;
		}else {
			this.result = 1;
		}
		//ServletActionContext.getResponse().getWriter().write(this.result);
		
		return "SUCCESS";
	}
	
	/**
	 * 管理员更新用户信息
	 */
	public String updateByAdmin(){
		String username = ServletActionContext.getRequest().getParameter("username");
		String phone = ServletActionContext.getRequest().getParameter("phone");
		String email = ServletActionContext.getRequest().getParameter("email");
		System.out.println("获取User参数：" + username + "," + phone + "," + email);
		
		User cUser = userService.findByWhat("username", username);
		if(cUser.getRole() == 0){
			String address = ServletActionContext.getRequest().getParameter("address");
			String cname = ServletActionContext.getRequest().getParameter("cname");
			String crelation = ServletActionContext.getRequest().getParameter("crelation");
			String cphone = ServletActionContext.getRequest().getParameter("cphone");
			
			System.out.println("Patient参数：" + address + "," + cname + "," + crelation + "," + cphone);
			
			Patient patient = cUser.getPatient();
			patient.setAddress(address);
			patient.setCname(cname);
			patient.setCphone(cphone);
			patient.setCrelation(crelation);
			patientService.update(patient);
		}else {
			String department = ServletActionContext.getRequest().getParameter("department");
			String title = ServletActionContext.getRequest().getParameter("title");
			String desc = ServletActionContext.getRequest().getParameter("desc");
			
			Doctor doctor = cUser.getDoctor();
			doctor.setDepartment(Integer.parseInt(department));
			doctor.setTitle(Integer.parseInt(title));
			doctor.setDescription(desc);
			doctorService.update(doctor);
		}
		
		cUser.setPhone(phone);
		cUser.setEmail(email);
		userService.update(cUser);
		
		result = 1;
		return "SUCCESS";
	}
	
	public String SysUsersNoAdmin(){
		System.out.println("查找系统用户");
		userList = userService.SysUsersNoAdmin();
		try {
			for(User u : userList){
				u.setCode(null);
				u.setArticles(null);
				u.setComments(null);
				u.setMessages(null);
				if(u.getRole() == 0){
					u.setDoctor(null);
					Patient patient = u.getPatient();
					patient.setUser(null);
					patient.setDandps(null);
					patient.setMrecords(null);
					patient.setExrecords(null);
					u.setPatient(patient);
					//System.out.println(u.getUsername() + "," + u.getPatient().getName());
				}else {
					u.setPatient(null);
					Doctor doctor = u.getDoctor();
					doctor.setUser(null);
					doctor.setDandps(null);
					doctor.setMrecords(null);
					doctor.setCfiles(null);
					u.setDoctor(doctor);
					//System.out.println(u.getUsername() + "," + u.getDoctor().getName());
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "SUCCESS";
	}
	
	public String resetPwdByUsername(){
		String username = ServletActionContext.getRequest().getParameter("username");
		String password = ServletActionContext.getRequest().getParameter("resetpwd");
		
		User user = userService.findByWhat("username", username);
		user.setPassword(password);
		userService.update(user);
		result = 1;
		return "SUCCESS";
	}
	
	public String deleteUser(){
		String username = ServletActionContext.getRequest().getParameter("username");
		System.out.println("获取的用户名为：" + username);
		
		User user = userService.findByWhat("username", username);
		String uid = user.getUid().toString();
		
		//删除留言信息
		List<Message> messages = messageService.findMessagesByUid(uid);
		if(messages != null){
			for (Message message : messages) {
				messageService.deleteMessage(message);
			}
		}
		//保留：需要将article和comment中的uid置为空
		if (user.getRole() == 0) {
			//删除挂号信息
			Dandp dandp = dandpService.dandpByPid(uid);
			if (dandp != null) {
				dandpService.delete(dandp);
			}
			
			//删除就诊记录
			List<Mrecord> mrecords = mrecordService.findHistoryRecordByPid(uid);
			if (mrecords != null) {
				for (Mrecord mrecord : mrecords) {
					mrecordService.deleteMrecord(mrecord);
				} 
			}
			
			Patient patient = user.getPatient();
			patientService.deletePatient(patient);
		}else {
			List<Dandp> dandps = dandpService.dandpsByDid(uid);
			if (dandps != null) {
				for (Dandp dandp : dandps) {
					dandpService.delete(dandp);
				} 
			}
			List<Mrecord> mrecords = mrecordService.findHistoryRecordByDid(uid);
			if (mrecords != null) {
				for (Mrecord mrecord : mrecords) {
					mrecordService.deleteMrecord(mrecord);
				} 
			}
			
			Doctor doctor = user.getDoctor();
			doctorService.deleteDoctor(doctor);
		}
		
		userService.deleteUser(user);
		
		result = 1;
		return "SUCCESS";
	}
	
	public String batchDeleteUsers(){
		String arr = ServletActionContext.getRequest().getParameter("ids");
		String[] ids = arr.split("\\s+");
		
		for (String uid : ids) {
			User user = userService.findByUid(uid);
			//删除留言信息
			List<Message> messages = messageService.findMessagesByUid(uid);
			if(messages != null){
				for (Message message : messages) {
					messageService.deleteMessage(message);
				}
			}
			//保留：需要将article和comment中的uid置为空
			if (user.getRole() == 0) {
				//删除挂号信息
				Dandp dandp = dandpService.dandpByPid(uid);
				if (dandp != null) {
					dandpService.delete(dandp);
				}
				
				//删除就诊记录
				List<Mrecord> mrecords = mrecordService.findHistoryRecordByPid(uid);
				if (mrecords != null) {
					for (Mrecord mrecord : mrecords) {
						mrecordService.deleteMrecord(mrecord);
					} 
				}
				
				Patient patient = user.getPatient();
				patientService.deletePatient(patient);
			}else {
				List<Dandp> dandps = dandpService.dandpsByDid(uid);
				if (dandps != null) {
					for (Dandp dandp : dandps) {
						dandpService.delete(dandp);
					} 
				}
				List<Mrecord> mrecords = mrecordService.findHistoryRecordByDid(uid);
				if (mrecords != null) {
					for (Mrecord mrecord : mrecords) {
						mrecordService.deleteMrecord(mrecord);
					} 
				}
				
				Doctor doctor = user.getDoctor();
				doctorService.deleteDoctor(doctor);
			}
			userService.deleteUser(user);
		}
		
		result = 1;
		return "SUCCESS";
	}
	
}
