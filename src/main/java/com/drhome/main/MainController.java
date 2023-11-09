package com.drhome.main;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	@Autowired MainService mainService;
	
	@GetMapping(value = { "/", "/main" })
	public String main() {
		
		
		return "/main";
	}
}
