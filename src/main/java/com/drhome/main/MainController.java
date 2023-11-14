package com.drhome.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {
	@Autowired
	MainService mainService;

	@GetMapping(value = { "/", "/main" })
	public String main(Model model, HttpSession session) {
		int randomNumber = (int) (Math.random() * 30) + 1;
		Map<String, Object> todayQuiz = mainService.findQuizByRandom(randomNumber);
		List<Map<String, Object>> newQna = mainService.findNewQna();
		if (session.getAttribute("mno") != null && session.getAttribute("mno") != "") {
			List<Map<String, Object>> notification = mainService.getNotification(session.getAttribute("mno"));
			Map<String, Object> countNotification = mainService.countNotification(session.getAttribute("mno"));
			System.out.println(countNotification);
			model.addAttribute("notification", notification);
			model.addAttribute("countNotification", countNotification);
			System.out.println(notification);
		}

		model.addAttribute("newQna", newQna);
		model.addAttribute("quiz", todayQuiz);
		return "/main";
	}
	
	
	
	@PostMapping("/point")
	public String point(@RequestParam Map<String, Object> data) {
		mainService.raisePointByQuiz(data);
		System.out.println("!!!");
		return "redirect:/main";
	}

	
	@ResponseBody
	@PostMapping("updateNotificationNum")
	public String updateNotificationNum(@RequestParam("nno") int nno) {
		System.out.println("!!!!!!!!!!!!!!!" + nno);
		mainService.updateNotificationNum(nno);

		return "";
	}

}
