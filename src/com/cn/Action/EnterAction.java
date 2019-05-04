package com.cn.Action;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class EnterAction extends ActionSupport {
	
	@Override
	public String execute() throws Exception {
		System.out.println("进入EnterAction");
		if (ServletActionContext.getRequest().getSession().getAttribute("loginUser") != null) {
			System.out.println("用户已登录");
			return "AlreadyLogin";
		}else {
			System.out.println("用户未登录");
			return "NotLogin";
		}
	}
}
