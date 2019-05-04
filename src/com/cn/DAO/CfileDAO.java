package com.cn.DAO;

import java.util.List;

import com.cn.POJO.Cfile;

public interface CfileDAO {

	//根据fid查询Cfile内容
	public Cfile cfileByFid(String fid);
	
	//保存Cfile对象
	public void save(Cfile cfile);
	
	//删除Cfile对象
	public void delete(Cfile cfile);
	
	//查询共享父文件夹下文件
	public List<Cfile> cfilesByParentPath(String pid);
	
	/**
	 * 查询当前文件夹下具有相同名的文件夹数量
	 * 弃用，文件夹名放到前端验证
	 * @param did
	 * @param fid
	 * @param filename
	 * @return
	 */
//	public int folderNumNamedSame(String did, String fid, String filename);
	
	//查找用户私密或共享文件夹下内容
	public List<Cfile> cfilesInUserParentPath(String did, String parent);
	
	public void sharedOrCancelShared(String fid, String parent);
	
	public void inOrOutRecycleBin(String fid, String parent);
	
	public String findTreeMenu(String rootId, String did);
	
	public void changeParent(String fid, String changeParent);
	
	public void fileRename(String fid, String filename);
}
