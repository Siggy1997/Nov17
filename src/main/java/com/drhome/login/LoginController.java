package com.drhome.login;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@GetMapping("/login")
	public String login() {

		return "/login";
	}

	@ResponseBody
	@PostMapping("/loginCheck")
	public String login(@RequestParam Map<String, Object> map, HttpSession session) {
		// System.out.println(map);

		JSONObject json = new JSONObject();
		// 일치하는 아이디 체크
		int IDresult = loginService.IDresult(map);
		System.out.println("map: " + map);
		System.out.println("IDresult: " + IDresult);
		if (IDresult == 0) {
			json.put("IDresult", 0);
			return json.toString();
		} else {
			// 일치하는 비밀번호 체크
			int PWresult = loginService.PWresult(map);
			if (PWresult == 1) {
				Map<String, Object> loginCheck = loginService.loginCheck(map);
				System.out.println("mno, mname, mid: " + loginCheck);

				session.setAttribute("mno", loginCheck.get("mno"));
				session.setAttribute("mid", loginCheck.get("mid"));
				session.setAttribute("mname", loginCheck.get("mname"));
				session.setAttribute("mhospitallike", loginCheck.get("mhospitallike"));

				json.put("PWresult", 1);
				return json.toString();
			} else {
				json.put("PWresult", 0);
				return json.toString();
			}
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {

		if (session.getAttribute("mno") != null) {
			session.removeAttribute("mno");
		}

		if (session.getAttribute("mid") != null) {
			session.removeAttribute("mid");
		}

		if (session.getAttribute("mname") != null) {
			session.removeAttribute("mname");
		}

		session.setMaxInactiveInterval(3600);

		session.invalidate();

		return "redirect:/login";
	}

	@GetMapping("/findID")
	public String findID() {

		return "/findID";
	}

	@ResponseBody
	@PostMapping("/findID")
	public String findID(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		System.out.println(map);
		Map<String, Object> findID = loginService.findID(map);
		System.out.println(findID);
		json.put("findID", findID);

		return json.toString();
	}
	
	@GetMapping("/findPW")
	public String findPW() {

		return "/findPW";
	}
	
	@ResponseBody
	@PostMapping("/findPW")
	public String findPW(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		System.out.println(map);
		Map<String, Object> findPW = loginService.findPW(map);
		System.out.println(findPW);
		json.put("findPW", findPW);

		return json.toString();
	}

}
