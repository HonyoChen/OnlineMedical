package com.cn.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.cn.DAO.MessageDAO;
import com.cn.POJO.Message;

@Transactional
public class MessageService {

	private MessageDAO messageDAO;
	public MessageDAO getMessageDAO() {
		return messageDAO;
	}
	public void setMessageDAO(MessageDAO messageDAO) {
		this.messageDAO = messageDAO;
	}
	
	public List<Message> findAllMessages(){
		return messageDAO.findAllMessages();
	}
	
	public List<Message> findMessagesByUid(String uid){
		return messageDAO.findMessagesByUid(uid);
	}
	
	public void deleteMessage(Message message){
		messageDAO.delete(message);
	}
	
	public void saveMessage(Message message){
		messageDAO.save(message);
	}
	
	public Message findByMid(String mid){
		return messageDAO.findByMid(mid);
	}
	
	public void updateMessage(Message message){
		messageDAO.update(message);
	}
}
