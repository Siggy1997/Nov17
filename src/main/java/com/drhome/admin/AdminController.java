package com.drhome.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private Util util;

	@GetMapping("/main")
	public String main(@RequestParam Map<String, Object> map, Model model, HttpSession session) {
		
		if (session.getAttribute("mid") == null) {
		
			String mname = String.valueOf(session.getAttribute("mname"));
			Map<String, Object> infoList = adminService.adminInfo(map);
			model.addAttribute("infoList", infoList);
			
			return "admin/main";
		} else {
			return "redirect:/admin/index";
		}
	}


	@RequestMapping(value = "/boardManage", method = RequestMethod.GET)
	public String BoardList(Model model, @RequestParam Map<String, Object> map, HttpSession session) {
		
		if (session.getAttribute("mid") == null) {
		
		List<Map<String, Object>> manageBoardList = adminService.manageBoardList();
		model.addAttribute("manageBoardList", manageBoardList);
			
		List<Map<String, Object>> reportList = adminService.reportList(map);
		model.addAttribute("reportList", reportList);
		
		return "admin/boardManage";
		} else {
			return "redirect:/admin/index";
		}
	}

	// member
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	public ModelAndView member(HttpSession session) {
		
		ModelAndView mv = new ModelAndView("admin/member");
		mv.addObject("memberList", adminService.memberList());

		return mv;
	}

	@RequestMapping(value = "/report", method = RequestMethod.GET)
	public String report(Map<String, Object> map, Model model, HttpSession httpSession) {

		List<Map<String, Object>> report = adminService.report(map);
		model.addAttribute("report", report);

		return "admin/report";
	}

	// gradeChange
	@RequestMapping(value = "/gradeChange", method = RequestMethod.GET)
	public String gradeChange(@RequestParam Map<String, String> map) {
		int grade = Integer.parseInt(map.get("grade"));
		int mboardcount = Integer.parseInt(map.get("mboardcount"));
		
		if (mboardcount >= 5) {
	        map.put("grade", "0");
	    }
		
		int result = adminService.gradeChange(map);
		return "redirect:/admin/member";
	}

	// resultChange
	@RequestMapping(value = "/resultChange", method = RequestMethod.GET)
	public String resultChange(@RequestParam Map<String, String> map) {
		System.out.println(map);
		int getMno = adminService.resultChange(map);
		System.out.println(getMno);
		
		if (map.get("rpresult").equals("1")) {
			adminService.memberRcount(getMno);
		}
		
		return "redirect:/admin/report";
	}
	
	// appointmentChange
	@RequestMapping(value = "/appointmentChange", method = RequestMethod.GET)
	public String appointmentChange(@RequestParam Map<String, String> map) {
		int getAno = adminService.appointmentChange(map);
		System.out.println(getAno);
		
		return "redirect:/admin/appointmentApprove";
	}
	
	
	@GetMapping("/newHospital")
	public String newHospital() {
		
		return "admin/newHospital";
	}
	
	@PostMapping("/newDoctor")
	public String newHospital(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		
		int insertHospital = adminService.insertHospital(map);
		System.out.println(insertHospital);
		
		return "admin/newDoctor";
	} 

	@GetMapping("/newDoctor")
	public String newDoctor() {
		
		return "admin/newDoctor";
	}
	
	@PostMapping("/hospitalOpen")
	public String newDoctor(@RequestParam Map<String, Object> map) {
		
		int insertDoctor = adminService.insertDoctor(map);
		System.out.println(insertDoctor);
		
		return "admin/hospitalOpen";
	}
	
	@RequestMapping(value = "/hospitalOpen", method = RequestMethod.GET)
	public String hospitalOpen(Map<String, Object> map, Model model) {
		
		List<Map<String, Object>> hospitalOpen = adminService.hospitalOpen(map);
		map.put("hospitalOpen", hospitalOpen);
		
		System.out.println(hospitalOpen);
		
		return "admin/hospitalOpen";
	}

	/*
	 * @ResponseBody
	 * 
	 * @PostMapping("/anotherDoctor") public String anotherDoctor(Map<String,
	 * Object> map) {
	 * 
	 * int result = adminService.anotherDoctor();
	 * 
	 * JSONObject json = new JSONObject(); json.put("result", result);
	 * System.out.println(json.toString());
	 * 
	 * return json.toString(); }
	 */


}
