package com.drhome.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

	@Autowired
	private AdminDAO adminDAO;
	
	public List<Map<String, Object>> memberList() {
		return adminDAO.memberList();
	}

	public int gradeChange(Map<String, String> map) {
		return adminDAO.gradeChange(map);
	}

	public Map<String, Object> adminLogin(Map<String, Object> map) {
		return adminDAO.adminLogin(map);
	}

	public List<Map<String, Object>> manageBoardList() {
		return adminDAO.manageBoardList();
	}

	public List<Map<String, Object>> report(Map<String, Object> map) {
		return adminDAO.report(map);
	}

	public int resultChange(Map<String, String> map) {
		adminDAO.resultChange(map);
		return adminDAO.getMno(map);
	}

	public void memberRcount(int getMno) {
		adminDAO.memberRcount(getMno);
	}

	public List<Map<String, Object>> reportList(Map<String, Object> map) {
		return adminDAO.reportList(map);
	}

}
