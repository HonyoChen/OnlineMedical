package com.cn.socket;

import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class ReceiveData implements Runnable {

	@Override
	public void run() {
		//准备空包
		byte[] data = new byte[1024];
		DatagramPacket packet = new DatagramPacket(data, data.length);
		
		//准备socket
		DatagramSocket socket = null;
		try{
			socket = new DatagramSocket(8081);
			String string = "";
			while (true) {
				//接收数据包
				socket.receive(packet);
				string = new String(packet.getData(), 0, packet.getLength());
				//输出
				System.out.println("获取数据：" + string);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			socket.close();
		}
	}

}
