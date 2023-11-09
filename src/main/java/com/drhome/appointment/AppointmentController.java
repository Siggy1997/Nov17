package com.drhome.appointment;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AppointmentController {
	@Autowired
	private AppointmentService appointmentService;

	@Autowired
	private AppointmentUtil util;

	@GetMapping("/appointment/{hno}")
	public String appointment(@PathVariable Map<String, Object> hno, Model model) {
		Map<String, Object> hospital = appointmentService.findHospitalDeatilByHno(hno);
		ArrayList<Map<String, Object>> doctor = appointmentService.findDoctorByHno(hno);

		System.out.println(hospital);

		model.addAttribute("hospital", hospital);
		model.addAttribute("doctor", doctor); 
		model.addAttribute("day", util.daysOfWeek());
		model.addAttribute("date", util.dateOfWeek());

		return "/appointment"; 
	}

	@PostMapping("/appointment")
	public String appointment(@RequestParam Map<String, Object> data) {
		appointmentService.appointmentFinish(data);
		System.out.println(data);
		return "/main";
	}

	@ResponseBody
	@GetMapping("/getTime") 
	public String getTime(@RequestParam Map<String, Object> data) {
		String day = (String) data.get("day");
		Map<String, Object> hospital = appointmentService.findHospitalDeatilByHno(data);
		System.out.println(hospital);
		List<Map<String, Object>> checkTime = appointmentService.checkTimeStatus(data);
		System.out.println(data);
		System.out.println(checkTime);
		JSONObject json = new JSONObject();
		json.put("checkTime", checkTime);

		if ((day.equals("토요일") || day.equals("일요일")) && (hospital.get("hholiday") + "").equals("1")) {
			json.put("timeSlots",
					util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hholidayendtime")));
			System.out.println("1");
		} else if ((day.equals("토요일") || day.equals("일요일")) && (hospital.get("hholiday") + "").equals("0")) {
			json.put("timeSlots", "");
			System.out.println("2");

		} else if (day.equals(hospital.get("hnightday"))) {
			json.put("timeSlots",
					util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hnightendtime")));
			System.out.println("3");

		} else {
			json.put("timeSlots",
					util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hclosetime")));
			System.out.println("4");
		}

		System.out.println(util.daysOfWeek().get(0));
		System.out.println(hospital.get("hnightday"));

		System.out.println(json.toString());

		return json.toString();
	}
}
