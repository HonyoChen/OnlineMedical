package com.cn.DAO;

import java.util.List;

import com.cn.POJO.Message;

public interface MessageDAO {

	// 返回所有留言列表
	public List<Message> findAllMessages();
	
	// 根据用户id查询留言
	public List<Message> findMessagesByUid(String uid);
	
	// 删除方法
	public void delete(Message message);
	
	// 保存方法
	public void save(Message message);
	
	// 根据ID查找
	public Message findByMid(String mid);
	
	// 更新
	public void update(Message message);
}
