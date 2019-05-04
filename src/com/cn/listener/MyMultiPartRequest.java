package com.cn.listener;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.dispatcher.multipart.JakartaMultiPartRequest;

public class MyMultiPartRequest extends JakartaMultiPartRequest {

	@Override
	public void parse(HttpServletRequest request, String saveDir) throws IOException {
//		String url = request.getRequestURI().toString();
//		if (url.indexOf("uploadImage")>0) {
//			
//		}else {
//			super.parse(request, saveDir);
//		}
	}
}
