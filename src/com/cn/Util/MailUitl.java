package com.cn.Util;

import java.io.IOException;
import java.net.Inet6Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

//邮件发送工具类
public class MailUitl {
	/**
	 * 发送邮件的方法
	 * 
	 * @param to
	 *            :收件人
	 * @param code
	 *            :激活码
	 * @throws IOException 
	 */
	public static void sendMail(String to, String code) throws IOException {
		String ipAddress = getLocalIPv6Address();
		
		//String ipAddress = InetAddress.getLocalHost().getHostAddress();
		/**
		 * 1.获得一个Session对象. 2.创建一个代表邮件的对象Message. 3.发送邮件Transport
		 */
		// 1.获得连接对象
		Properties props = new Properties();
		props.setProperty("mail.host", "smtp.qq.com");
		props.setProperty("mail.smtp.auth", "true");
		Session session = Session.getInstance(props, new Authenticator() {

			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("183128981", "zuzmjrsdtjrxcahd");
			}

		});
		// 2.创建邮件对象:
		Message message = new MimeMessage(session);
		// 设置发件人:
		try {
			message.setFrom(new InternetAddress("183128981@qq.com"));
			// 设置收件人:
			message.addRecipient(RecipientType.TO, new InternetAddress(to));
			// 抄送 CC 密送BCC
			// 设置标题
			message.setSubject("来自Star Health的重置密码邮件");
			// 设置邮件正文:
			message.setContent(
					"<h1>Star Health密码官方重置邮件!点下面链接完成重置操作!</h1><h3><a href='http://[" + ipAddress
							+ "]:8080/OnlineMedical/pages/emailresetpwd.html?code=" + code + "'>http://[" + ipAddress + "]:8080/OnlineMedical/pages/emailresetpwd.html?code=" + code + "</a></h3>",
					"text/html;charset=UTF-8");
			// 3.发送邮件:
			Transport.send(message);
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

	public static void main(String[] args) throws IOException {
		MailUitl.sendMail("guozhengzhang3@163.com", "1321654dsaf");
	}

	public static String getLocalIPv6Address() throws IOException {
		InetAddress inetAddress = null;
		Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
		outer: while (networkInterfaces.hasMoreElements()) {
			Enumeration<InetAddress> inetAds = networkInterfaces.nextElement().getInetAddresses();
			while (inetAds.hasMoreElements()) {
				inetAddress = inetAds.nextElement();
				// Check if it's ipv6 address and reserved address
				if (inetAddress instanceof Inet6Address && !isReservedAddr(inetAddress)) {
					break outer;
				}
			}
		}
		String ipAddr = inetAddress.getHostAddress();
		// Filter network card No
		int index = ipAddr.indexOf('%');
		if (index > 0) {
			ipAddr = ipAddr.substring(0, index);
		}
		return ipAddr;
	}

	private static boolean isReservedAddr(InetAddress inetAddr) {
		if (inetAddr.isAnyLocalAddress() || inetAddr.isLinkLocalAddress() || inetAddr.isLoopbackAddress()) {
			return true;
		}
		return false;
	}
}
