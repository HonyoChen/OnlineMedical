package com.cn.Action;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.struts2.ServletActionContext;

import com.cn.POJO.Cfile;
import com.cn.Service.CfileService;
import com.cn.Util.RandomUUID;
import com.opensymphony.xwork2.ActionSupport;

public class DownloadAction extends ActionSupport {

	private static final int BUFFER_SIZE = 2 * 1024;
	
	private InputStream inputStream;
	private String mimeType;
	private String filename;
	private String fid;

	public InputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public String getMimeType() {
		return mimeType;
	}
	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}
	public String getFilename() throws UnsupportedEncodingException {
		return new String(filename.getBytes(), "ISO8859-1");
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	
	private CfileService cfileService;
	public CfileService getCfileService() {
		return cfileService;
	}
	public void setCfileService(CfileService cfileService) {
		this.cfileService = cfileService;
	}
	
	public String download() throws IOException{
		System.out.println("进入OM下载文件Action");
		
		//根目录
		String root = ServletActionContext.getRequest().getServletContext().getRealPath("/file/sfile");
		Cfile cfile = cfileService.cfileById(fid);
		String savePath = cfile.getSavepath();//存放路径
		
		File file;
		if(cfile.getIsDirectory()){
			filename = cfile.getFilename() + ".zip";//文件名
			mimeType = ServletActionContext.getServletContext().getMimeType(filename);//文件类型
			File compressFile = new File(root + File.separator + cfile.getFilename() + ".zip");
			if (compressFile.exists()) {
				compressFile.delete();
			}
			compressFile(cfile);
			file = compressFile;
		}else {
			filename = cfile.getFilename();//文件名
			mimeType = ServletActionContext.getServletContext().getMimeType(filename);//文件类型
			file = new File(root + File.separator + savePath);
		}
		inputStream = new FileInputStream(file);
		return "SUCCESS";
	}
	
	public String batchDownload() throws IOException{
//		String[] ids = fid.split("\\s+");
		String[] ids = fid.split(",");
		String root = ServletActionContext.getRequest().getServletContext().getRealPath("/file/sfile");
		filename = RandomUUID.getRandomUUID() + ".zip";//后续采用上层文件夹作为命名，以此可以删除多余文件
		mimeType = ServletActionContext.getServletContext().getMimeType(filename);//文件类型
		
		File compressFile = new File(root + File.separator + filename);
		if (compressFile.exists()) {
			compressFile.delete();
		}
		List<Cfile> cfiles = new ArrayList<Cfile>();
		for (int i = 0; i < ids.length; i++) {
			String id = ids[i];
			Cfile c = cfileService.cfileById(id);
			cfiles.add(c);
		}
		compressBatchFile(filename, cfiles);
		inputStream = new FileInputStream(compressFile);
		return "SUCCESS";
	}
	
	//压缩批量文件
	private void compressBatchFile(String fname, List<Cfile> cfiles) throws IOException{
		String root = ServletActionContext.getRequest().getServletContext().getRealPath("/file/sfile");
		
		FileOutputStream outputStream = new FileOutputStream(root + File.separator + fname);
		ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(outputStream));
		//将压缩文件夹作为首层目录进行压缩
		String dir = "" + "/";
		out.putNextEntry(new ZipEntry(dir));
		for (Cfile cfile : cfiles) {
			createCompressedFile(out, cfile, dir+cfile.getFilename());
		}
		out.close();
	}
	
	//根据虚拟目录压缩文件
	private void compressFile(Cfile cfile) throws IOException{
		String root = ServletActionContext.getRequest().getServletContext().getRealPath("/file/sfile");
		String filename = cfile.getFilename() + ".zip";
		
		FileOutputStream outputStream = new FileOutputStream(root + File.separator + filename);
		ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(outputStream));
		//将压缩文件夹作为首层目录进行压缩
		String dir = "" + "/";
		out.putNextEntry(new ZipEntry(dir));
		createCompressedFile(out, cfile, dir+cfile.getFilename());
		out.close();
	}
	
	//创建压缩文件内容
	private void createCompressedFile(ZipOutputStream out, Cfile cfile, String dir) throws IOException{
		String root = ServletActionContext.getRequest().getServletContext().getRealPath("/file/sfile");
		
		if(cfile.getIsDirectory()){
			List<Cfile> cfiles = cfileService.cfilesByParentPath(cfile.getFid().toString());//获取当前虚拟目录下子文件（夹）
			//将文件夹添加到下一级打包目录
			out.putNextEntry(new ZipEntry(dir + "/"));
			dir = cfiles.size() == 0 ? dir : dir + "/";
			//循环将文件夹中的文件打包
			for (Cfile cf : cfiles) {
				createCompressedFile(out, cf, dir + cf.getFilename());
			}
		}else {
			//获取实际存储文件
			File file = new File(root + File.separator + cfile.getSavepath());
			//文件输入流
			FileInputStream fis = new FileInputStream(file);
			out.putNextEntry(new ZipEntry(dir));
			//进行写操作
			int len = 0;
			byte[] buf = new byte[BUFFER_SIZE];
			while((len = fis.read(buf)) != -1){
				out.write(buf, 0, len);
			}
			fis.close();
		}
	}
}
