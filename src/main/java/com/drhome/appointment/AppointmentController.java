package com.drhome.appointment;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

<<<<<<< HEAD
import org.json.JSONArray;
import org.json.JSONObject;
=======
>>>>>>> aea7a98805df0ce87e20671e7cc9141591ddbdd8
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.ResponseBody;
=======
>>>>>>> aea7a98805df0ce87e20671e7cc9141591ddbdd8

@Controller
public class AppointmentController {
	
	@Autowired
	private AppointmentService appointmentService;
	
	@GetMapping("/appointment")
<<<<<<< HEAD
	public String appointment(Map<String, Object> map, Model model) {
		
		List<Map<String, Object>> hospitals = appointmentService.hospitals(map);
		map.put("hospitals", hospitals);
		
		return "appointment";
	}
	
	/*
	 * @GetMapping("/adetail") public String adetail(Map<String, Object> map, Model
	 * model, HttpSession session) {
	 * 
	 * return "adetail";
	 * 
	 * }
	 */

	@PostMapping("/adetail")
	public String appointment(@RequestParam("hno") int hno, Map<String, Object> map, Model model, HttpSession session) {
		
		Map<String, Object> hospital = appointmentService.hospital(hno);
		model.addAttribute("hospital", hospital);
		System.out.println(hospital);
		
		List<Map<String, Object>> detail = appointmentService.detail(map);
		model.addAttribute("detail", detail);
		
		List<Map<String, Object>> time = appointmentService.time(hno);
		model.addAttribute("time", time);
		
		List<Map<String, Object>> department = appointmentService.department(map);
		model.addAttribute("department", department);
		
		/*
		 * List<Map<String, Object>> doctor = appointmentService.doctor(hno);
		 * map.put("doctor", doctor); model.addAttribute("doctor", doctor);
		 */
=======
	public String appointment(Map<String, Object> map, Model model, HttpSession session) {
		
		List<Map<String, Object>> list = appointmentService.list(map);
		map.put("list", list);
		
		return "appointment";
	}

	
	@PostMapping("/adetail")
	public String adetail(Map<String, Object> map, Model model) {
		
		List<Map<String, Object>> detail = appointmentService.detail(map);
		
		List<Map<String, Object>> time = appointmentService.time(map);
		
		List<Map<String, Object>> doctor = appointmentService.doctor(map);
		
		map.put("detail", detail);
		map.put("time", time);
		map.put("doctor", doctor);
>>>>>>> aea7a98805df0ce87e20671e7cc9141591ddbdd8
		
		return "adetail";
	}
	
<<<<<<< HEAD
	@ResponseBody
	@PostMapping("/getDoctors")
	public String getDoctors(@RequestParam("dpno") int dpno, Map<String, Object> map) {
		System.out.println(dpno);
		List<Map<String, Object>> doctors = appointmentService.getDoctorsByDpno(dpno);
		
		JSONArray jsonArray = new JSONArray();
		for (Map<String, Object> mapList : doctors) {
			jsonArray.put(convertMapToJson(mapList));
		}
		
		JSONObject json = new JSONObject();
		json.put("doctors", jsonArray);
		
		
	    return json.toString();
		
	}
	
	public static JSONObject convertMapToJson(Map<String, Object> map) {

	    JSONObject json = new JSONObject();
	    for (Map.Entry<String, Object> entry : map.entrySet()) {
	        String key = entry.getKey();
	        Object value = entry.getValue();
	        json.put(key, value);

	    }
	    return json;
	}
=======
>>>>>>> aea7a98805df0ce87e20671e7cc9141591ddbdd8
}
