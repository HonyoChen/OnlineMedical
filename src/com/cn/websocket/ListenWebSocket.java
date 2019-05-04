package com.cn.websocket;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;

import com.cn.POJO.Exrecord;
import com.cn.POJO.User;
import com.cn.Service.DandpService;
import com.cn.Service.ExrecordService;
import com.cn.Service.PatientService;
import com.cn.Service.UserService;
import com.cn.Util.DataUtil;
import com.cn.Util.DoctorRealTimeUtil;
import com.cn.Util.TensorPredict;
import net.sf.json.JSONObject;


/**
 * @ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
 * 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
 */
@Component
@ServerEndpoint("/ws/listen")
public class ListenWebSocket implements Runnable{ //模板websocket程序

	private DandpService dandpService = ContextLoader.getCurrentWebApplicationContext().getBean(DandpService.class);
	private ExrecordService exrecordService = ContextLoader.getCurrentWebApplicationContext().getBean(ExrecordService.class);
	private PatientService patientService = ContextLoader.getCurrentWebApplicationContext().getBean(PatientService.class);
	private UserService userService = ContextLoader.getCurrentWebApplicationContext().getBean(UserService.class);
    //concurrent包的线程安全Set，用来存放每个客户端对应的MyWebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
    //private static CopyOnWriteArraySet<ListenWebSocket> listenWebSocketSet = new CopyOnWriteArraySet<ListenWebSocket>();

    //WebSocket前后一一映射
    private static Map<String, Session> socket = new HashMap<String, Session>();
    
    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private Session session;
    //判断用户
    private String uid;
    public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}

	//建立tensorflow预测模型变量
    private TensorPredict predict = new TensorPredict();
    
    /**
     * 连接建立成功调用的方法
     * @param session  可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    @OnOpen
    public void onOpen(Session session){
        this.session = session;
        String params = session.getQueryString();// 获取URL中参数信息
		this.setUid(params.substring(params.indexOf("=") + 1));
		socket.put(this.uid, session);// 存放用户名及对应session
        //listenWebSocketSet.add(this); //加入set中
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(){
//    	listenWebSocketSet.remove(this);  //从set中删除
    	socket.remove(this.uid);
    }

    /**
     * 收到客户端消息后调用的方法
     * @param message 客户端发送过来的消息
     * @param session 可选的参数
     */
    @OnMessage
    public void onMessage(String message, Session session) {
		System.out.println("来自客户端的消息:" + message.substring(4));
		//群发消息
//		for(ListenWebSocket item: listenWebSocketSet){
//			try {
//                item.sendMessage(message);
//            } catch (IOException e) {
//                e.printStackTrace();
//                continue;
//            }
//		}
    }

    /**
     * 发生错误时调用
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error){
        System.out.println("发生错误");
        error.printStackTrace();
    }

    /**
     * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
     * @param message
     * @throws IOException
     */
    public void sendMessage(String message, String uid) throws IOException{
//    	ListenWebSocket webSocket = (ListenWebSocket) socket.get(uid);
//    	if(webSocket != null){
//    		webSocket.session.getBasicRemote().sendText(message);
//    	}
    	Session sess = socket.get(uid);
    	if (sess != null) {
			sess.getAsyncRemote().sendText(message);
		}
//        this.session.getAsyncRemote().sendText(message);
    }

	@Override
	public void run() {
		//准备空包
		byte[] data = new byte[1024];
		DatagramPacket packet = new DatagramPacket(data, data.length);
		
		//准备socket
		DatagramSocket socket = null;
		try{
			socket = new DatagramSocket(8081);
			String string = "";//用于存放数据内容
			DataUtil dataUtil = new DataUtil();
			while (true) {
				//接收数据包
				socket.receive(packet);//数据格式 uid,178条ECG数据
				string = new String(packet.getData(), 0, packet.getLength());
				String[] strArray = string.split(",");
				
				dataUtil.setUserID(strArray[0]);//获取用户ID
				float[] numArray = new float[strArray.length-1];//178个采集数据
				//float[] numArray = new float[strArray.length];
				System.out.println("接收数组长度：" + numArray.length);
				for(int i =0; i < numArray.length; i++){
					numArray[i] = Float.parseFloat(strArray[i+1]);
					//numArray[i] = Float.parseFloat(strArray[i]);
				}
				dataUtil.setEcgs(numArray);//获取ECG数据
				int result = predict.tensorPredict(numArray);//利用tensorflow模型预测当前发病状态
				dataUtil.setFlush(false);
				if(result == 1){
					//数据库添加新纪录
					Exrecord exrecord = new Exrecord();
					exrecord.setPatient(patientService.findByPid(strArray[0]));
					exrecord.setIsConfirmed(false);
					exrecord.setTime(new Timestamp(new Date().getTime()));
					exrecordService.saveExrecord(exrecord);
					dataUtil.setFlush(true);
				}
				dataUtil.setStatus(result);//获取发病状态
				
				JSONObject json = JSONObject.fromObject(dataUtil);
				String jsonString = json.toString();
				
				//输出
//				System.out.println("获取数据：" + strArray.length + "-" + string);
				System.out.println("传输的JSON数据为：" + jsonString);
				System.out.println("用户ID为：" + strArray[0]);
				
				User user = userService.findByUid(strArray[0]);
				if (user.getRole() == 0) {
					String did = dandpService.findDidByPid(strArray[0]);//查找当前患者对应医生编号
					if(did != null || !"".equals(did)){
						DoctorRealTimeUtil.setPatientCurrentStatus(did, strArray[0], String.valueOf(result));//激活用户实时在线
//						DoctorRealTimeUtil.setCurrentStatus(strArray[0], String.valueOf(result));//存储实时状态
						DoctorRealTimeUtil.reduce();//执行激活期衰弱
						this.sendMessage(jsonString, did);
					}
					this.sendMessage(jsonString, strArray[0]);
				}else {
					this.sendMessage(jsonString, strArray[0]);
				}
				
//				for(ListenWebSocket item : listenWebSocketSet){
//					item.sendMessage(jsonString);
//				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			socket.close();
		}
	}
}