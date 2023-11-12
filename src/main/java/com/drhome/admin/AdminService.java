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

	public List<Map<String, Object>> aApprove(Map<String, Object> map) {
		return adminDAO.aApprove(map);
	}

	public int appointmentChange(Map<String, String> map) {
		return adminDAO.appointmentChange(map);
	}

	public Map<String, Object> adminInfo(Map<String, Object> map) {
		return adminDAO.adminInfo(map);
	}

	public List<Map<String, Object>> hospitalOpen(Map<String, Object> map) {
		return adminDAO.hospitalOpen(map);
	}

	public int insertRegister(Map<String, Object> map) {
		return adminDAO.insertRegister(map);
	}

	public List<Map<String, Object>> hList() {
		return adminDAO.hList();
	}

	public int insertDoctor(Map<String, Object> map) {
		return adminDAO.insertDoctor(map);
	}

	public int resultCh(Map<String, String> map) {
		return adminDAO.resultCh(map);
	}

	public Map<String, Object> detail(int rhno) {
		return adminDAO.detail(rhno);
	}

	public List<Map<String, Object>> approvalHospital(Map<String, Object> map) {
		return adminDAO.approvalHospital(map);
	}

	public int deleteHospital(int rhno) {
		return adminDAO.deleteHospital(rhno);
	}

	public int insertHospital(Map<String, Object> map) {
		return adminDAO.insertHospital(map);
	}

	public List<Map<String, Object>> finalHospital() {
		return adminDAO.finalHospital();
	}

	public List<Map<String, Object>> newHospital(int hno) {
		return adminDAO.newHospital(hno);
	}

	public Map<String, Object> realDetail(int hno) {
		return adminDAO.realDetail(hno);
	}

	public List<Map<String, Object>> search(Map<String, Object> map) {
		return adminDAO.search(map);
	}

	public List<Map<String, Object>> viewDoctor(int hno) {
		return adminDAO.viewDoctor(hno);
	}

	/*
	 * public List<Map<String, Object>> hospitalList(int rhno) { return
	 * adminDAO.hospitalList(rhno); }
	 */

}
