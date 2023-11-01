package com.drhome.hospitaldetail;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class HospitalDetailUtil {

	LocalDate now = LocalDate.now();
	String dayOfWeek = now.getDayOfWeek().toString();

	LocalTime timenow = LocalTime.now();
	DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
	String time = timenow.format(timeFormatter);

	public String getDayOfWeek(String dayOfWeek) {
		switch (dayOfWeek) {
		case "SUNDAY":
			return "일요일";
		case "MONDAY":
			return "월요일";
		case "TUESDAY":
			return "화요일";
		case "WEDNESDAY":
			return "수요일";
		case "THURSDAY":
			return "목요일";
		case "FRIDAY":
			return "금요일";
		case "SATURDAY":
			return "토요일";
		default:
			return "";
		}
	}

	public String getHospitalAverageRate(ArrayList<Map<String, Object>> reviewList) {
	    double totalHospitalRate = 0;
	    for (Map<String, Object> review : reviewList) {
	        totalHospitalRate += (Double) review.get("rrate");
	    }
	    double averageHospitalRate = totalHospitalRate / reviewList.size();
	    String formatRate = String.format("%.1f",averageHospitalRate);
	    return formatRate;
	}

}
