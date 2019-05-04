package com.cn.Service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.cn.DAO.CfileDAO;
import com.cn.POJO.Cfile;

@Transactional
public class CfileService {

	private CfileDAO cfileDAO;
	public CfileDAO getCfileDAO() {
		return cfileDAO;
	}
	public void setCfileDAO(CfileDAO cfileDAO) {
		this.cfileDAO = cfileDAO;
	}
	
	public Cfile findByFid(String fid){
		return cfileDAO.cfileByFid(fid);
	}
	
//	public int foldersNumNamedNewFolder(String did, String fid, String filename){
//		return cfileDAO.folderNumNamedSame(did, fid, filename);
//	}
	
	public void save(Cfile cfile){
		cfileDAO.save(cfile);
	}
	
	public List<Cfile> cfilesByParentPath(String pid){
		return cfileDAO.cfilesByParentPath(pid);
	}
	
	public Cfile cfileById(String fid){
		return cfileDAO.cfileByFid(fid);
	}
	
	public void deleteCfile(Cfile cfile){
		cfileDAO.delete(cfile);
	}
	
	public List<Cfile> findCfilesInUserParentPath(String did, String parent) {
		return cfileDAO.cfilesInUserParentPath(did, parent);
	}
	
	public void sharedOrCancelShared(String fid, String parent){
		cfileDAO.sharedOrCancelShared(fid, parent);
	}
	
	public void inOrOutRecycleBin(String fid, String parent){
		cfileDAO.inOrOutRecycleBin(fid, parent);
	}
	
	public String findTreeMenu(String rootId, String did){
		return cfileDAO.findTreeMenu(rootId, did);
	}
	
	public void changeParent(String fid, String changeParent){
		cfileDAO.changeParent(fid, changeParent);
	}
	
	public void fileRename(String fid, String filename){
		cfileDAO.fileRename(fid, filename);
	}
}
