package com.cn.websocket;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.SequenceInputStream;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.cn.Util.Train;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
 *                 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
 */
@ServerEndpoint("/ws/train")
public class TrainWebSocket { // 模板websocket程序

	// concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
	// private static CopyOnWriteArraySet<TrainWebSocket> webSocketSet = new
	// CopyOnWriteArraySet<TrainWebSocket>();

	// 与某个客户端的连接会话，需要通过它来给客户端发送数据
	private Session session;

	public Session getSession() {
		return session;
	}

	public void setSession(Session session) {
		this.session = session;
	}

	// Username
	private String uid;
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}

	// 定义一个全局变量map，key为用户名，该用户对应的session为value
	private static Map<String, Session> map = new HashMap<String, Session>();

	/**
	 * 连接建立成功调用的方法
	 * 
	 * @param session
	 *            可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
	 */
	@OnOpen
	public void onOpen(Session session) {
		this.session = session;
		String queryString = session.getQueryString();// 获取URL中参数信息
		System.out.println("WebSocket初始化参数：" + queryString);
		this.setUid(queryString.substring(queryString.indexOf("=") + 1));
		map.put(this.uid, session);// 存放用户名及对应session
		// webSocketSet.add(this); // 加入set中
	}

	/**
	 * 连接关闭调用的方法
	 */
	@OnClose
	public void onClose() {
		// webSocketSet.remove(this); // 从set中删除
		map.remove(this.uid);
	}

	/**
	 * 收到客户端消息后调用的方法
	 * 
	 * @param message
	 *            客户端发送过来的消息
	 * @param session
	 *            可选的参数
	 */
	@OnMessage
	public void onMessage(String message, Session session) {
		BufferedReader br = null;
		Runtime rt = Runtime.getRuntime();
		Process process = null;

		System.out.println("来自客户端的消息:" + message.substring(4));// 查看传递的参数
		System.out.println(System.getProperty("catalina.home"));
		String tomcatPath = "\"" + System.getProperty("catalina.home");// 获取tomcat安装路径
		String trainFilePath = tomcatPath + File.separator + "webapps" + File.separator + "OnlineMedical"
				+ File.separator + "train" + File.separator + "lstm-health.py\" ";// 给出训练文件绝对路径
		String command = "python " + trainFilePath;
		System.out.println(command);

		Session item = this.map.get(this.getUid());// 获取当前用户名下的微博socket对象
		// 群发消息
		// for (TrainWebSocket item : webSocketSet) {
		try {
			// String commandString = "python
			// F:\\Software\\apache-tomcat-8.5.29\\webapps\\OnlineMedical\\train\\lstm-health.py
			// "
			// + message.substring(4);
			String commandString = command + message.substring(4);// CMD执行语句
			System.out.println(commandString);
			process = rt.exec(commandString);
			//process = rt.exec("ping 10.10.20.1");
			
			SequenceInputStream sis = new SequenceInputStream(process.getInputStream(), process.getErrorStream());
			br = new BufferedReader(new InputStreamReader(sis));//, Charset.forName("Cp1252")
			
			OutputStreamWriter osw = new OutputStreamWriter(process.getOutputStream());
			BufferedWriter bw = new BufferedWriter(osw);
			String line = null;
			Train train = new Train();//新建train对象，用于JSON转换
			while ((line = br.readLine()) != null) {
				if (line.startsWith("Iter=")) {
					//System.out.println(line);
					// for (TrainWebSocket item : webSocketSet) {
					String[] strs = line.split(",");
					for (String string : strs) {
						String[] params = string.split("=");
						if(params[0].equals("Iter")){
							train.setIter(Integer.parseInt(params[1]));
						}else if (params[0].equals("Minibatch Loss")) {
							train.setLoss(Float.parseFloat(params[1]));
						}else{
							train.setAccu(Float.parseFloat(params[1]));
						}
					}
					
					JSONObject json = JSONObject.fromObject(train);
					//JSONArray array = JSONArray.fromObject(json);
					String jsonString = json.toString();
					System.out.println("JSON字符串为：" + jsonString);
					try {
						item.getBasicRemote().sendText(jsonString);
					} catch (Exception e) {
						//e.printStackTrace();
						continue;
					}
					// }
				}else if (line.startsWith("Finished!")){
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			// continue;
		} finally{
			process.destroy();
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// }
	}

	/**
	 * 发生错误时调用
	 * 
	 * @param session
	 * @param error
	 */
	@OnError
	public void onError(Session session, Throwable error) {
		System.out.println("发生错误");
		error.printStackTrace();
	}

	/**
	 * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
	 * 
	 * @param message
	 * @throws IOException
	 */
	public void sendMessage(String message) throws IOException {
		this.session.getBasicRemote().sendText(message);
		// this.session.getAsyncRemote().sendText(message);
	}
}