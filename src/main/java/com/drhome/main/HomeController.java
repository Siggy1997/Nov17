package com.drhome.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@Autowired 
	private HomeService homeService;
	
	@GetMapping(value = { "/", "/home" })
	public String home() {
		
		
		return "/home";
	}
}
