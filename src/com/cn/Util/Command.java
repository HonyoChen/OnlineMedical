package com.cn.Util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;

public class Command {

	//直接执行python程序
	public static void exeCmd(String commandString) {
		BufferedReader br = null;
		try {
			Process process = Runtime.getRuntime().exec(commandString);
			br = new BufferedReader(new InputStreamReader(process.getInputStream(), Charset.forName("GBK")));
			String line = null;
//			StringBuilder sbd = new StringBuilder();
			while ((line = br.readLine()) != null) {
				System.out.println(line);
//				sbd.append(line + "\n");
			}
//			System.out.println("完整输出");
//			System.out.println(sbd.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	//先生成bat文件，后执行bat文件（考虑弃用，需要打开两个cmd窗口）
	public static void exeBat(String batFilePath, String params) throws IOException{
		String exeStr = "python " + batFilePath + " " + params + "\nexit"; //bat文件内容
		File file = new File(batFilePath + File.separator + "train.bat");
		
		FileWriter writer = new FileWriter(file);
		writer.write(exeStr);
		writer.close();
	}
}
