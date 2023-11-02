package com.drhome.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class QnaController {
	@Autowired QnaService qnaService;
	
	@GetMapping("/qna")
	public String qna(Model model) {
		
		 List<Map<String, Object>> qnaList = qnaService.qnaList();
	        model.addAttribute("qnaList", qnaList);
	        
	        System.out.println(qnaList);
	        
		
		return "/qna";
	}
	
	@PostMapping("/qna")
	public String qna(@RequestParam("bno") int bno) {
		
		return "redirect:/qnadetail?bno=" + bno;

	}
	
	@GetMapping("/qnadetail")
	public String qnadetail(@RequestParam("bno") int bno, Model model) {
		
		
	        
		
		return "/qnadetail";
	}
	
}
