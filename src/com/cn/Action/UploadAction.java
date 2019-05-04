package com.cn.Action;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Article;
import com.cn.POJO.User;
import com.cn.Service.ArticleService;
import com.cn.Service.UserService;
import com.cn.Util.MailUitl;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class UploadAction extends ActionSupport {

	private UserService userService;
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	private ArticleService articleService;
	public void setArticleService(ArticleService articleService) {
		this.articleService = articleService;
	}
	public ArticleService getArticleService() {
		return articleService;
	}
	
	private Map<String, String> map = new HashMap<String, String>();
	public void setMap(Map<String, String> map) {
		this.map = map;
	}
	public Map<String, String> getMap() {
		return map;
	}
	
	private int result;
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	
	public String uploadImage() throws IOException, ServletException{
		System.out.println("进入上传图片Action");
		
		HttpServletRequest request = ServletActionContext.getRequest();
		//创建上传图片存放的文件夹
        String path = request.getServletContext().getRealPath("/file/images");
        File file = new File(path);
        if (!file.exists())
            file.mkdirs();
        String fileName = "";// 文件名称

        /**上传文件处理内容**/
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload sfu = new ServletFileUpload(factory);
        sfu.setHeaderEncoding("UTF-8"); // 处理中文问题
        //sfu.setSizeMax(1024 * 1024); // 限制文件大小
        try {
            List<FileItem> fileItems = sfu.parseRequest(request); // 解码请求
            System.out.println(fileItems);
            for (FileItem fi : fileItems) {
                fileName = UUID.randomUUID()+fi.getName().substring(fi.getName().lastIndexOf("."),fi.getName().length());
                fi.write(new File(path, fileName));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        //获取图片url地址
        System.out.println("fileName:"+fileName);
        String ipAddr = MailUitl.getLocalIPv6Address();
        String imgUrl = "http://[" + ipAddr + "]:8080/OnlineMedical/file/images/" + fileName;
        System.out.println("imgUrl:"+imgUrl);       
		
		map.put("data", imgUrl);
		return "SUCCESS";
	}
	
	public String saveArticle(){
		String uid = ServletActionContext.getRequest().getParameter("uid");
		String title = ServletActionContext.getRequest().getParameter("title");
		String category = ServletActionContext.getRequest().getParameter("categ");
		String content = ServletActionContext.getRequest().getParameter("content");
		
		System.out.println(uid + "," + title + "," + category + "," + content);
		
		Article article = new Article();
		User user = userService.findByUid(uid);
		System.out.println("找到User:" + user.getUsername());
		article.setUser(user);
		article.setTitle(title);
		article.setCategory(Integer.parseInt(category));
		article.setTime(new Timestamp(new Date().getTime()));
		article.setContent(content);
		//article.setComments(null);
		articleService.saveArticle(article);
		result = 1;
		return "SUCCESS";
	}
	
}
