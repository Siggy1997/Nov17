package com.drhome.hospitaldetail;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HospitalDetailController {
	
	@Autowired
	private HospitalDetailService hospitalDetailService;
	
	
	@GetMapping("/hospitaldetail")
	public String hospitalDetail() {
		Map<String, Object> hospital = hospitalDetailService.findHospitalByHno();
		System.out.println(hospital);
		
		
		return "/hospitalDetail";
	}
}
