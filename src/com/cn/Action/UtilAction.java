package com.cn.Action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class UtilAction extends ActionSupport {

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
	
	public String returnModelResult(){
		String tomcatPath = System.getProperty("catalina.home");// 获取tomcat安装路径
		String modelResultPath = tomcatPath + File.separator + "webapps" + File.separator + "OnlineMedical"
				+ File.separator + "train" + File.separator + "result" + File.separator + "modelResult.csv";// 给出模型训练结果csv文件
		
		JSONArray jsonArray = new JSONArray();
		
		File csv = new File(modelResultPath); // CSV文件路径
        csv.setReadable(true);//设置可读
        csv.setWritable(true);//设置可写
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader(csv));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        String line = "";
        String everyLine = "";
        try {
            while ((line = br.readLine()) != null) // 读取到的内容给line变量
            {
                everyLine = line;
                String[] params = everyLine.split(",");
                JSONObject object = new JSONObject();
                
                object.put("iter", params[0]);
                object.put("loss", params[1]);
                object.put("accu", params[2]);
                jsonArray.add(object);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
        	try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
        array = null;
        array = jsonArray;
        System.out.println(array.toString());
		return "SUCCESS";
	}
	
	public String replaceModelAndResult(){
		String tomcatPath = System.getProperty("catalina.home");// 获取tomcat安装路径
		String rootPath = tomcatPath + File.separator + "webapps" + File.separator + "OnlineMedical"
				+ File.separator + "train";// 给出根目录
		
		String epsilon = ServletActionContext.getRequest().getParameter("epsilon");
		String iter = ServletActionContext.getRequest().getParameter("iters");
		String rate = ServletActionContext.getRequest().getParameter("rate");
		String size = ServletActionContext.getRequest().getParameter("size");
		
		String prefix = epsilon + "-" + iter + "-" + rate + "-" + size + "-";
		
		String currentPathOfModel = rootPath + File.separator + "model" + File.separator + prefix + "model.pb";
		String currentPathOfRdata = rootPath + File.separator + "result" + File.separator + prefix + "result.csv";
		
		String filePathOfModel = rootPath + File.separator + "model" + File.separator + "model.pb";
		String filePathOfRdata = rootPath + File.separator + "result" + File.separator + "modelResult.csv";
		
		File fileOfModel = new File(filePathOfModel);
		File fileOfRdata = new File(filePathOfRdata);
		if (fileOfModel.exists()) {
			fileOfModel.delete();
		}
		if (fileOfRdata.exists()) {
			fileOfRdata.delete();
		}
		
		boolean isRenameOfModel = false;
		boolean isRenameOfRdata = false;
		try {
			isRenameOfModel = renameFile(currentPathOfModel, "model.pb");
			isRenameOfRdata = renameFile(currentPathOfRdata, "modelResult.csv");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(isRenameOfModel && isRenameOfRdata){
			result = 1;
		}else {
			result = 0;
		}
		return "SUCCESS";
	}
	
	 // 文件重命名
    public boolean renameFile(String url, String new_name) throws Exception {
        String old_url = url;
        old_url = old_url.replace("\\", "/");
        File old_file = new File(old_url);
        if (!old_file.exists()) {
            throw new IOException("文件重命名失败，文件（"+old_file+"）不存在");
        }
        System.out.println(old_file.exists());

        String old_name = old_file.getName();
        // 获得父路径
        String parent = old_file.getParent();
        // 重命名
        String new_url = parent + "/" + new_name;
        File new_file = new File(new_url);
        old_file.renameTo(new_file);

        System.out.println("原文件：" + old_file.getName());
        System.out.println("新文件：" + new_file.getName());
        new_name = new_file.getName();
        old_name = old_file.getName();
        if (new_name.equals(old_name)) {
            return false;
        } else {
            return true;
        }
    }
}
