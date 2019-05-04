package com.cn.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.cn.Util.DoctorRealTimeUtil;
import net.sf.json.JSONObject;

/**
 * @ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
 *                 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
 */
@ServerEndpoint("/ws/dreal")
public class DoctorRealWebSocket { // 模板websocket程序

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
	 * @throws IOException 
	 * @throws InterruptedException 
	 */
	@OnMessage
	public void onMessage(String message, Session session) throws IOException, InterruptedException {
		JSONObject object = new JSONObject();//外部JSON
//		JSONObject inner = new JSONObject();//内部JSON
		
		while(true){
			object = DoctorRealTimeUtil.getObject(this.uid);
			DoctorRealTimeUtil.reduce();
//			int numberOfOnlinePatients = DoctorRealTimeUtil.getCurrentPatientNumber(this.uid);//根据医生ID查找在线患者数量
//			outer.put("number", numberOfOnlinePatients);
//			String[] patients = DoctorRealTimeUtil.getPatientsNo(this.uid);//获取当前医生的实时在线患者编号集合
//			for(String p_no : patients){
//				String status = DoctorRealTimeUtil.getCurrentStatus(p_no);
//				inner.put(p_no, status);
//			}
//			outer.put("status", inner);
			System.out.println("获取JSON字符串：" + object.toString());
			sendMessage(object.toString(), this.uid);
			Thread.currentThread().sleep(3000);
		}
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
		map.remove(this.uid);
		error.printStackTrace();
	}

	/**
	 * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
	 * 
	 * @param message
	 * @throws IOException
	 */
	public void sendMessage(String message, String uid) throws IOException {
		Session sess = map.get(uid);
		if (sess != null) {
			try {
				sess.getBasicRemote().sendText(message);
				//sess.getAsyncRemote().sendText(message);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
//		this.session.getBasicRemote().sendText(message);
		// this.session.getAsyncRemote().sendText(message);
	}
}