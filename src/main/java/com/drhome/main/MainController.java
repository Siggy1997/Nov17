package com.drhome.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {
	@Autowired 
	MainService mainService; 

	@GetMapping(value = { "/", "/main" })
	public String main(Model model) {
		int randomNumber = (int) (Math.random() * 30) + 1;
		Map<String, Object> todayQuiz = mainService.findQuizByRandom(randomNumber);
		List<Map<String, Object>> newQna = mainService.findNewQna();
		
		
		model.addAttribute("newQna", newQna);
		model.addAttribute("quiz", todayQuiz);
		return "/main";
	}
	
	@PostMapping("/point")
	public String point(@RequestParam Map<String, Object> data) {
		mainService.raisePointByQuiz(data);
		return "redirect:/main"; 
	}


}
