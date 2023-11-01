package com.drhome.free;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {
	@Autowired 
	private FreeBoardDAO freeBoardDAO;


	public List<Map<String, Object>> freeList() {
		return freeBoardDAO.freeList();
	}


	public Map<String, Object> freePost(int bno) {
		return freeBoardDAO.freePost(bno);
	}


	public List<Map<String, Object>> freeComment(int bno) {
		return freeBoardDAO.freeComment(bno);
	}


	public void postFree(Map<String, Object> freeData) {
		freeBoardDAO.postFree(freeData);
		
	}


	public int commentCount(int bno) {
		return freeBoardDAO.commentCount(bno);
	}


	public void writeFreeComment(Map<String, Object> freeCommentData) {
		freeBoardDAO.writeFreeComment(freeCommentData);
		
	}
}
