package com.drhome.map;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MapController {
	@Autowired MapService mapService;
	
	@GetMapping("/hospitalMap")
	public String map(Model model) {
		
		
		List<Map<String, Object>> hospitalList = mapService.hospitalList();
		model.addAttribute("hospitalList", hospitalList);
		
		System.out.println(hospitalList);
		
		
		List<Map<String, Object>> pharmacyList = mapService.pharmacyList();
		model.addAttribute("pharmacyList", pharmacyList);

		
		return "/hospitalMap";
		
		
		
		
	}
}
