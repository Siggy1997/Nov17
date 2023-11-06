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

	@GetMapping("/index")
	public String adminIndex() {
		return "admin/index";
	}

	@PostMapping("/index")
	public String adminLogin(@RequestParam Map<String, Object> map, HttpSession session) {
		System.out.println(map);
		Map<String, Object> result = adminService.adminLogin(map);
		System.out.println(result);

		// 세션 올리기
		session.setAttribute("mid", map.get("id"));
		session.setAttribute("mname", result.get("mname"));
		session.setAttribute("mgrade", result.get("mgrade"));

		// 메인으로 이동하기
		return "redirect:/admin/main";
	}

	@GetMapping("/main")
	public String main() {
		return "admin/main";
	}

	@RequestMapping(value = "/appointmentApprove", method = RequestMethod.GET)
	public String appointmentApprove() {
		return "admin/appointmentApprove";
	}

	@RequestMapping(value = "/boardManage", method = RequestMethod.GET)
	public String BoardList(Model model, @RequestParam Map<String, Object> map) {
		List<Map<String, Object>> manageBoardList = adminService.manageBoardList();
		model.addAttribute("manageBoardList", manageBoardList);
			
		List<Map<String, Object>> reportList = adminService.reportList(map);
		model.addAttribute("reportList", reportList);
		
		return "admin/boardManage";

	}

	// member
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	public ModelAndView member() {
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
		int result = adminService.gradeChange(map);
		System.out.println(result);
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

	/*
	 * @ResponseBody
	 * 
	 * @PostMapping("/reportAgree") public String reportAgree(@RequestParam(value =
	 * "bno") int bno) { System.out.println("bno 승인 값 : " + bno); JSONObject json =
	 * new JSONObject();
	 * 
	 * int result = adminService.reportAgree(bno); if (result == 1) {
	 * System.out.println("승인 성공"); adminService.memberRcount(bno); }
	 * 
	 * return json.toString(); }
	 */
	
	/*
	 * @ResponseBody
	 * 
	 * @PostMapping("/report") public String report(@RequestParam Map<String,
	 * Object> map) { JSONObject json = new JSONObject();
	 * System.out.println("신고 값은 : " + map); int result = boardService.report(map);
	 * System.out.println(result); if (result == 1) { json.put("result", result); }
	 * return json.toString(); }
	 * 
	 * @GetMapping("/report") public String report(@RequestParam(name = "num") int
	 * num, Model model) { System.out.println(num); Map<String, Object> detail =
	 * boardService.adetail(num); model.addAttribute("detail", detail); return
	 * "report"; }
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping("/reportDetail") public String reportDetail(@RequestParam(name =
	 * "abno") int abno) { JSONObject json = new JSONObject();
	 * System.out.println(abno); Map<String, Object> detail =
	 * boardService.reportDetail(abno); System.out.println(detail);
	 * json.put("detail", detail); return json.toString(); }
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping("/reportAgree") public String reportAgree(@RequestParam(value =
	 * "abno") int abno,
	 * 
	 * @RequestParam(value = "rreported") int rreported) {
	 * System.out.println("abno 승인 값 : " + abno); JSONObject json = new
	 * JSONObject(); int result = boardService.reportAgree(abno);
	 * 
	 * if (result == 1) { System.out.println("승인 성공");
	 * boardService.eboardCount(rreported); boardService.adel(abno); }
	 * 
	 * return json.toString(); }
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping("/reportReject") public String reportReject(@RequestParam(value
	 * = "abno") int abno) { JSONObject json = new JSONObject(); int result =
	 * boardService.reportReject(abno); json.put("result", result); return
	 * json.toString(); }
	 * 
	 * @GetMapping("/reportDetail") public String reportDetail(@RequestParam(name =
	 * "abno") int abno, Model model) { Map<String, Object> detail =
	 * boardService.reportDetail(abno); String abdate =
	 * String.valueOf(detail.get("abdate")).substring(0, 16); detail.put("abdate",
	 * abdate); // System.out.println("abno의 값은 : " + abno);
	 * 
	 * // 중복 신고된 횟수 int reportCount = boardService.reportCount(abno);
	 * model.addAttribute("detail", detail); model.addAttribute("reportCount",
	 * reportCount); return "reportDetail"; }
	 */
}
