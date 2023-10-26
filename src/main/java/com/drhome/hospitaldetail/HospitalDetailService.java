package com.drhome.hospitaldetail;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HospitalDetailService {
	
	@Autowired
	private HospitalDetailDAO hospitalDetailDAO;

	public Map<String, Object> findHospitalByHno() {
		int hno = 1;
		
		return hospitalDetailDAO.findHospitalByHno(hno);
	}
	
	
	
	
}
