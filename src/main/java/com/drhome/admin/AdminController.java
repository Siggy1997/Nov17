package com.drhome.admin;

import java.util.Base64;
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

	@GetMapping("/adminMain")
	public String adminmain(@RequestParam Map<String, Object> map, Model model, HttpSession session) {

		if (session.getAttribute("mid") == null) {

			String mname = String.valueOf(session.getAttribute("mname"));
			Map<String, Object> infoList = adminService.adminInfo(map);
			model.addAttribute("infoList", infoList);

			return "admin/adminMain";
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

	@PostMapping("/hospitalOpen")
	public String newHospital(@RequestParam Map<String, Object> map) {
		System.out.println(map.containsKey("rhholiday"));
		if (!(map.containsKey("rhholiday"))) {
			map.put("rhholiday", 0);
		}

		System.out.println(map.containsKey("rhparking"));
		if (!(map.containsKey("rhparking"))) {
			map.put("rhparking", 0);
		}
		System.out.println(map);

		int insertRegister = adminService.insertRegister(map);
		System.out.println(insertRegister);

		return "redirect:/admin/hospitalOpen";
	}

	@GetMapping("/newDoctor")
	public String newDoctor(@RequestParam("hno") int hno, Map<String, Object> map) {
		Map<String, Object> hnoDoctor = adminService.realDetail(hno);
		map.put("hnoDoctor", hnoDoctor);
		System.out.println(hnoDoctor);
		return "admin/newDoctor";
	}
	
	@PostMapping("/realHospital")
	public String realHospital(@RequestParam("rhno") int rhno) {
		
		Map<String, Object> hospitalApproval = adminService.detail(rhno);
		int insertHospital = adminService.insertHospital(hospitalApproval);
		System.out.println(insertHospital);
		int deleteHospital = adminService.deleteHospital(rhno);
		System.out.println(deleteHospital);
		
		return "redirect:/admin/realHospital";
	}
	
	@GetMapping("/realHospital")
	public String realHospital(Map<String, Object> map) {
			
		List<Map<String, Object>> finalHospital = adminService.finalHospital();
		map.put("finalHospital", finalHospital);
		
		return "admin/realHospital";
	}

	@PostMapping("/newDoctor")
	public String newDoctor(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		
		System.out.println(map.containsKey("dgender"));
		if (!(map.containsKey("dgender"))) {
			map.put("dgender", 0);
		}
		
		if (String.valueOf(map.containsKey("dspecialist")) == "on") {
			map.put("dspecialist", 1);
		} else {
			map.put("dspecialist", 0);
		}
		System.out.println(map.containsKey("dspecialist"));

		if (String.valueOf(map.containsKey("dtelehealth")) == "on") {
			map.put("dtelehealth", 1);
		} else {
			map.put("dtelehealth", 0);
		}
		System.out.println(map.containsKey("dtelehealth"));
		
		int insertDoctor = adminService.insertDoctor(map);
		System.out.println(insertDoctor);
		
		System.out.println(map.get("hno"));
		System.out.println(map.get("hname"));
		// Base64.getEncoder().encodeToString(map.get("hname").getBytes())
		return "redirect:/admin/newDoctor?hno="+map.get("hno");
	}

	@RequestMapping(value = "/hospitalOpen", method = RequestMethod.GET)
	public String hospitalOpen(/* @RequestParam("rhno") int rhno, */ Map<String, Object> map, Model model) {

		List<Map<String, Object>> hospitalOpen = adminService.hospitalOpen(map);
		map.put("hospitalOpen", hospitalOpen);
		
		/*
		 * List<Map<String, Object>> hospitalList = adminService.hospitalList(rhno);
		 * map.put("hospitalList", hospitalList);
		 */
		
		return "admin/hospitalOpen";
	}

	@GetMapping("/resultCh")
	public String resultCh(@RequestParam Map<String, String> map) {
		System.out.println(map);
		int getMno = adminService.resultCh(map);
		
		return "redirect:/admin/hospitalOpen";
	}

	@ResponseBody
	@PostMapping("/detail")
	public String detail(@RequestParam("rhno") int rhno) {

		Map<String, Object> detail = adminService.detail(rhno);

		JSONObject json = new JSONObject();
		json.put("detail", detail);
		System.out.println(json.toString());
		
		return json.toString();
	}

	@GetMapping("/newHosDoc")
	public String newHosDoc(Map<String, Object> map, HttpSession session, @RequestParam(name="hno", required=false, defaultValue = "0") int hno) {
		System.out.println(hno);
		List<Map<String, Object>> newHospital = adminService.newHospital(hno);  
		map.put("newHospital", newHospital);
		System.out.println(newHospital);
		return "admin/newHosDoc";
	}
	
	@ResponseBody
	@PostMapping("/search")
	public String search(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		
		List<Map<String, Object>> search = adminService.search(map);

		JSONObject json = new JSONObject();
		json.put("search", search);
		System.out.println(json.toString());
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/doctorView")
	public String doctorView(@RequestParam("hno") int hno) {
		
		List<Map<String, Object>> viewDoctor = adminService.viewDoctor(hno);

		JSONObject json = new JSONObject();
		json.put("viewDoctor", viewDoctor);
		System.out.println(json.toString());
		
		return json.toString();
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
