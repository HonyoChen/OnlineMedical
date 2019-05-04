package com.cn.Action;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.ContextLoader;

import com.cn.POJO.Cfile;
import com.cn.POJO.Doctor;
import com.cn.POJO.User;
import com.cn.Service.CfileService;
import com.cn.Service.UserService;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class CfileAction extends ActionSupport {

	private CfileService cfileService;
	public CfileService getCfileService() {
		return cfileService;
	}
	public void setCfileService(CfileService cfileService) {
		this.cfileService = cfileService;
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
	
	private List<Cfile> list = new ArrayList<Cfile>();
	public List<Cfile> getList() {
		return list;
	}
	public void setList(List<Cfile> list) {
		this.list = list;
	}
	
	private JSONArray array;
	public JSONArray getArray() {
		return array;
	}
	public void setArray(JSONArray array) {
		this.array = array;
	}
	
	//新建文件夹
	public String createFolder(){
		String did = ServletActionContext.getRequest().getParameter("did");//获取医生ID，因为只能医生能访问数据平台
		String fid = ServletActionContext.getRequest().getParameter("fid");//获取父路径文件ID
		String filename = ServletActionContext.getRequest().getParameter("filename");//新建文件夹名
		
		User user = userService.findByUid(did);
		Doctor doctor = user.getDoctor();
		doctor.setCfiles(null);
		doctor.setDandps(null);
		doctor.setMrecords(null);
		doctor.setUser(null);
		
		Cfile parent = cfileService.findByFid(fid);
		
		Cfile cfile = new Cfile();
		cfile.setDoctor(doctor);
		cfile.setFilename(filename);//测试用，实际只需前端传递filename值
		cfile.setTime(new Timestamp(new Date().getTime()));
		cfile.setIsDirectory(true);
		cfile.setIsShared(true);
		cfile.setIsDeleted(false);
		cfile.setCfile(parent);
		cfile.setCfiles(null);
		cfileService.save(cfile);
		
		result = 1;
		return "SUCCESS";
	}
	
	//查询当前文件夹下所有文件
	public String filesInCurrentFolder(){
		String fid = ServletActionContext.getRequest().getParameter("fid");
		list = cfileService.cfilesByParentPath(fid);
		System.out.println(list.size());
		for (Cfile cfile : list) {
			Doctor doctor = cfile.getDoctor();
			if (doctor != null) {
				doctor.setCfiles(null);
				doctor.setDandps(null);
				doctor.setMrecords(null);
				doctor.setUser(null);
				
				cfile.setDoctor(doctor);
				cfile.setCfile(null);
				cfile.setCfiles(null);
			}
		}
		return "SUCCESS";
	}
	
	//根据文件编号查询文件
	public String fileById(){
		String fid = ServletActionContext.getRequest().getParameter("fid");
		Cfile c = cfileService.cfileById(fid);
		c.setCfile(null);
		c.setCfiles(null);
		c.setDoctor(null);
		list.add(c);
		return "SUCCESS";
	}
	
	//上传文件
	public String uploadCfile() throws IllegalStateException, IOException{
		System.out.println("进入上传文件Action");
		
		//创建上传文件存放的文件夹
		String path = ServletActionContext.getRequest().getServletContext().getRealPath("/file/sfile");
		File rootFile = new File(path);
		if (!rootFile.exists())
			rootFile.mkdirs();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String origName = "";//原始文件名称
        String saveName = "";//文件服务器存放文件名称（随机化）
        long fileSize = 0;//文件大小
        
        String did = "";
        String fid = "";

        /**上传文件处理内容**/
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload sfu = new ServletFileUpload(factory);
        sfu.setHeaderEncoding("UTF-8"); // 处理中文问题
        //sfu.setSizeMax(1024 * 1024); // 限制文件大小
        try {
            List<FileItem> fileItems = sfu.parseRequest(request); // 解码请求
            System.out.println(fileItems);
            
            Iterator iterator = fileItems.iterator();
            while (iterator.hasNext()) {
				FileItem item = (FileItem) iterator.next();
				if(item.isFormField()){ // 如果是表单域，即非文件上传元素
					String fieldName = item.getFieldName();//获取name属性的值
					String fieldValue = item.getString("UTF-8");//获取属性value
					
					if("uid".equals(fieldName)){
						did = fieldValue;
					}else if ("fid".equals(fieldName)) {
						fid = fieldValue;
					}
				}else{//处理文件
					origName = item.getName();
					fileSize = item.getSize();
					saveName = UUID.randomUUID()+item.getName().substring(item.getName().lastIndexOf("."),item.getName().length());
					item.write(new File(path, saveName));
				}
				
			}
            
        } catch (Exception e) {
            e.printStackTrace();
        }
		
        System.out.println("did:" + did);
        System.out.println("fid:" + fid);
        System.out.println("文件初始名：" + origName);
        System.out.println("文件随机名：" + saveName);
        System.out.println("文件的大小：" + fileSize);
        
        //获取文件上传人信息
        User user = userService.findByUid(did);
        Doctor doctor = user.getDoctor();
        doctor.setCfiles(null);
		doctor.setDandps(null);
		doctor.setMrecords(null);
		doctor.setUser(null);
		
		Cfile parent = cfileService.findByFid(fid);
        
        Cfile cfile = new Cfile();
        cfile.setCfile(parent);//设置父路径
        cfile.setCfiles(null);
        cfile.setDoctor(doctor);//设置文件所有人
        cfile.setFilename(origName);
        cfile.setIsDeleted(false);
        cfile.setIsDirectory(false);
        cfile.setIsShared(true);
        cfile.setSavepath(saveName);
        cfile.setSize(fileSize);
        cfile.setTime(new Timestamp(new Date().getTime()));
        cfileService.save(cfile);
        
        result = 1;
		return "SUCCESS";
	}
	
	//传输文件ID彻底删除文件
	public String deleteFileByFid(){
		System.out.println("进入彻底删除文件Action");
		String fid = ServletActionContext.getRequest().getParameter("fid");
		Cfile targetFile = cfileService.cfileById(fid);
		if (!targetFile.getIsDirectory()) {//当前文件不是文件夹
			deleteFile(fid);
		}else {
			deleteFolder(fid);
		}
		System.out.println("删除完成");
		result = 1;
		return "SUCCESS";
	}
	
	public String batchDeleteFileByFids(){
		String fids = ServletActionContext.getRequest().getParameter("fids");
		String[] fid_array = fids.split(",");
		for (String fid : fid_array) {
			Cfile targetFile = cfileService.cfileById(fid);
			if (!targetFile.getIsDirectory()) {//当前文件不是文件夹
				deleteFile(fid);
			}else {
				deleteFolder(fid);
			}
		}
		System.out.println("批量删除完成");
		result = 1;
		return "SUCCESS";
	}
	//删除文件
	public void deleteFile(String fid){
		String path = ServletActionContext.getRequest().getServletContext().getRealPath("/file/sfile");//获取文件存放路径
		Cfile targetFile = cfileService.cfileById(fid);
		String filename = targetFile.getSavepath();
		File file = new File(path + File.separator + filename);
		if (file.exists()) {
			file.delete();
		}
		cfileService.deleteCfile(targetFile);
	}
	//迭代删除文件夹
	public void deleteFolder(String fid){
		//找出其子文件（夹）
		List<Cfile> sons = cfileService.cfilesByParentPath(fid);
		for (Cfile cfile : sons) {
			if (!cfile.getIsDirectory()) {//删除文件夹下子文件
				deleteFile(cfile.getFid().toString());
			}else{
				deleteFolder(cfile.getFid().toString());
			}
		}
		//最后删除文件夹在数据库记录
		Cfile targetFile = cfileService.cfileById(fid);
		cfileService.deleteCfile(targetFile);
	}
	
	public String findCfilesInUserParentPath(){
		String did = ServletActionContext.getRequest().getParameter("did");
		String fid = ServletActionContext.getRequest().getParameter("fid");
		System.out.println("DID:" + did + ";FID:" + fid);
		list = cfileService.findCfilesInUserParentPath(did, fid);
		for (Cfile cfile : list) {
			Doctor doctor = cfile.getDoctor();
			if (doctor != null) {
				doctor.setCfiles(null);
				doctor.setDandps(null);
				doctor.setMrecords(null);
				doctor.setUser(null);
				
				cfile.setDoctor(doctor);
				cfile.setCfile(null);
				cfile.setCfiles(null);
			}
		}
		return "SUCCESS";
	}
	
	public String sharedOrCancelShared(){
		String fid = ServletActionContext.getRequest().getParameter("fid");
		String parent = ServletActionContext.getRequest().getParameter("parent");
		cfileService.sharedOrCancelShared(fid, parent);
		result = 1;
		return "SUCCESS";
	}
	
	public String inOrOutRecycleBin(){
		String fid = ServletActionContext.getRequest().getParameter("fid");
		String parent = ServletActionContext.getRequest().getParameter("parent");
		cfileService.inOrOutRecycleBin(fid, parent);
		result = 1;
		return "SUCCESS";
	}
	
	public String batchInOrOutRecycleBin(){
		System.out.println(ServletActionContext.getRequest().toString());
		String fids = ServletActionContext.getRequest().getParameter("fids");
		String parent = ServletActionContext.getRequest().getParameter("parent");
		
		System.out.println("获取参数：" + fids + ";" + parent);
		String[] fid_array = fids.split(",");
		for (String fid : fid_array) {
			cfileService.inOrOutRecycleBin(fid, parent);
		}
		result = 1;
		return "SUCCESS";
	}
	
	public String findTreeMenu(){
		String rid = ServletActionContext.getRequest().getParameter("rid");
		String did = ServletActionContext.getRequest().getParameter("did");
		String find = cfileService.findTreeMenu(rid, did);
		find = find.substring(2);
		
		JSONArray jsonArray = new JSONArray();
		String[] menus = find.split(",");
		//区分首元素
		Cfile root = cfileService.cfileById(menus[0]);
		JSONObject rootObject = new JSONObject();
		rootObject.put("id", root.getFid());
		rootObject.put("pId", 0);
		rootObject.put("name", root.getFilename());
		rootObject.put("isParent", true);
		rootObject.put("open", true);
		jsonArray.add(rootObject);
		
		for (int i = 1; i < menus.length; i++) {
			Cfile cfile = cfileService.cfileById(menus[i]);
			JSONObject object = new JSONObject();
			object.put("id", cfile.getFid());
			object.put("pId", cfile.getCfile().getFid());
			object.put("name", cfile.getFilename());
			object.put("isParent", true);
			jsonArray.add(object);
		}
		System.out.println(jsonArray.toString());
		array = jsonArray;
		return "SUCCESS";
	}
	
	public String changeParent(){
		String fid = ServletActionContext.getRequest().getParameter("fid");
		String parent = ServletActionContext.getRequest().getParameter("parent");
		cfileService.changeParent(fid, parent);
		result = 1;
		return "SUCCESS";
	}
	
	public String fileRename(){
		String fid = ServletActionContext.getRequest().getParameter("fid");
		String filename = ServletActionContext.getRequest().getParameter("filename");
		cfileService.fileRename(fid, filename);
		result = 1;
		return "SUCCESS";
	}
}
