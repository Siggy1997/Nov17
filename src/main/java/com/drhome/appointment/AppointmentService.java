package com.drhome.appointment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppointmentService {

	@Autowired
	private AppointmentDAO appointmentDAO;

	public List<Map<String, Object>> hospitals(Map<String, Object> map) {
		return appointmentDAO.hospitals(map);
	}

	public Map<String, Object> hospital(int hno) {
		return appointmentDAO.hospital(hno);
	}
	
	public List<Map<String, Object>> list(Map<String, Object> map) {
		return appointmentDAO.list(map);
	}

	public List<Map<String, Object>> detail(Map<String, Object> map) {
		return appointmentDAO.detail(map);
	}

	public List<Map<String, Object>> time(int hno) {
		return appointmentDAO.time(hno);
	}

	public List<Map<String, Object>> doctor(Map<String, Object> map) {
		return appointmentDAO.doctor(map);
	}

	public int result(Map<String, Object> map) {
		return appointmentDAO.result(map);
	}

	public List<Map<String, Object>> getDoctorsByDpno(int dpno) {
		return appointmentDAO.getDoctorsByDpno(dpno);
	}

	public List<Map<String, Object>> department(Map<String, Object> map) {
		return appointmentDAO.department(map);
	}

}
