package com.cn.Action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Doctor;
import com.cn.POJO.Message;
import com.cn.POJO.Patient;
import com.cn.POJO.User;
import com.cn.Service.MessageService;
import com.cn.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

import sun.print.resources.serviceui;

public class MessageAction extends ActionSupport {

	private MessageService messageService;
	public MessageService getMessageService() {
		return messageService;
	}
	public void setMessageService(MessageService messageService) {
		this.messageService = messageService;
	}
	private UserService userService;
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	private int result;
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	
	//ajax返回数据
	private List<Message> list;
	public List<Message> getList() {
		return list;
	}
	public void setList(List<Message> list) {
		this.list = list;
	}
	
	public String allMessages(){
		System.out.println("进入查询留言Action");
		list = messageService.findAllMessages();
		for(Message message : list){
			User user = message.getUser();
			if (user != null) {
				user.setArticles(null);
				user.setComments(null);
				user.setMessages(null);
				if (user.getRole() == 0) {
					Patient patient = user.getPatient();
					patient.setDandps(null);
					patient.setMrecords(null);
					patient.setUser(null);
					patient.setExrecords(null);
					user.setPatient(patient);
				}else if(user.getRole() == 1){
					Doctor doctor = user.getDoctor();
					doctor.setDandps(null);
					doctor.setMrecords(null);
					doctor.setUser(null);
					doctor.setCfiles(null);
					user.setDoctor(doctor);
				}
			}
		}
		return "SUCCESS";
	}
	
	public String saveMessage(){
		String method = ServletActionContext.getRequest().getParameter("method");
		Message message = new Message();
		if ("0".equals(method)) {
			String username = ServletActionContext.getRequest().getParameter("username");
			String email = ServletActionContext.getRequest().getParameter("email");
			String phone = ServletActionContext.getRequest().getParameter("phone");
			String title = ServletActionContext.getRequest().getParameter("title");
			String category = ServletActionContext.getRequest().getParameter("category");
			String content = ServletActionContext.getRequest().getParameter("content");
			
			message.setUser(null);
			message.setTime(new Timestamp(new Date().getTime()));
			message.setUsername(username);
			message.setPhone(phone);
			message.setEmail(email);
			message.setTitle(title);
			message.setCategory(Integer.parseInt(category));
			message.setContent(content);
			message.setStatus(0);
		}else {
			String uid = ServletActionContext.getRequest().getParameter("uid");
			String type = ServletActionContext.getRequest().getParameter("type");
			String title = ServletActionContext.getRequest().getParameter("title");
			String content = ServletActionContext.getRequest().getParameter("content");
			
			User user = userService.findByUid(uid);
			message.setUser(user);
			message.setTime(new Timestamp(new Date().getTime()));
			message.setUsername(null);
			message.setPhone(null);
			message.setEmail(null);
			message.setTitle(title);
			message.setCategory(Integer.parseInt(type));
			message.setContent(content);
			message.setStatus(0);
		}
		messageService.saveMessage(message);
		result = 1;
		return "SUCCESS";
	}
	
	public String changeStatus(){
		String mid = ServletActionContext.getRequest().getParameter("mid");
		Message message = messageService.findByMid(mid);
		int status = message.getStatus();
		status = (status + 1) % 2;
		message.setStatus(status);
		messageService.updateMessage(message);
		result = 1;
		return "SUCCESS";
	}
	
	public String batchChangeStatus(){
		String arr = ServletActionContext.getRequest().getParameter("ids");
		String[] ids = arr.split("\\s+");
		for (String mid : ids) {
			Message message = messageService.findByMid(mid);
			message.setStatus((message.getStatus() + 1 ) % 2);
			messageService.updateMessage(message);
		}
		result = 1;
		return "SUCCESS";
	}
	
	public String deleteMessage(){
		String mid = ServletActionContext.getRequest().getParameter("mid");
		Message message = messageService.findByMid(mid);
		messageService.deleteMessage(message);
		result = 1;
		return "SUCCESS";
	}
	
	public String batchDeleteMessage(){
		String arr = ServletActionContext.getRequest().getParameter("ids");
		String[] ids = arr.split("\\s+");
		for (String mid : ids) {
			Message message = messageService.findByMid(mid);
			messageService.deleteMessage(message);
		}
		result = 1;
		return "SUCCESS";
	}
}
