package com.drhome.telehealth;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TelehealthService {
	
	@Autowired 
	private  TelehealthDAO telehealthDAO;

	public List<Map<String, Object>> departmentKeyword() {
		return telehealthDAO.departmentKeyword();
	}

	public List<Map<String, Object>> doctorList() {
		return telehealthDAO.doctorList();
	}

	public List<Map<String, Object>> kindDoctorList(Map<String, Object> map) {
		return telehealthDAO.kindDoctorList(map);
	}

	public List<Map<String, Object>> symptomDoctorList(Map<String, Object> map) {
		return telehealthDAO.symptomDoctorList(map);
	}

	public List<Map<String, Object>> doctorNamelList(Map<String, Object> map) {
		return telehealthDAO.doctorNamelList(map);
	}

	public Map<String, Object> doctor(int dno) {
		return telehealthDAO.doctor(dno);
	}

	public List<Map<String, Object>> doctorReview(int dno) {
		return telehealthDAO.doctorReview(dno);
	}
}
