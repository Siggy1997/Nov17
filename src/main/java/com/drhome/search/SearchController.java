package com.drhome.search;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class SearchController {
	
	@Autowired private SearchService searchService;
	@Autowired private SearchUtil searchUtil;
	
	@GetMapping("/search")
	public String search(Model model) {
		
		// 증상 가져오기
		List<Map<String, Object>> departmentKeyword = searchService.departmentKeyword();
		// {dpkind=소아과, dpsymptom=소아 질환, dpkeyword=감기,예방접종,성장판검사,신생아황달}

		// 모든 증상 뽑아내기
		List<String> allKeyword = searchUtil.changeTypeToStringByComma(departmentKeyword, "dpkeyword");
		
		// 증상 랜덤으로 8개 뽑아서 모델에 담기
		List<String> randomKeyword = new ArrayList<>();
		Random random = new Random();
		for (int i = 0; i < 8; i++) {
			int randomIndex = random.nextInt(allKeyword.size());
			randomKeyword.add(allKeyword.get(randomIndex));
		}
		model.addAttribute("randomKeyword",randomKeyword);
		return "/search";
	}
	
	@PostMapping("/search")
	public String search(@RequestParam String keyword) throws Exception {
		System.out.println(keyword);
			
			List<Map<String, Object>> keywordKind = searchService.departmentKeyword();
			// {dpkind=소아과, dpsymptom=소아 질환, dpkeyword=감기,예방접종,성장판검사,신생아황달}
			
			// 진료과별 [소아과, 치과, 내과, 이비인후과, 피부과, 산부인과, 안과, 정형외과, 한의원, 비뇨기과, 신경과, 외과, 정신의학과]
			List<String> kindKeyword = searchUtil.changeTypeToString(keywordKind, "dpkind");
			
			// 증상별 [감기, 예방접종, 성장판검사, 신생아황달, 치아교정, 충치치료, 치아미백, 치통, ...]
			List<String> symptomKeyword = searchUtil.changeTypeToStringByComma(keywordKind, "dpkeyword");
			
			// 기타 키워드별 [주차, 주차 가능, 전문의, 여의사, 공휴일 진료, 일요일 진료, 공휴일, 일요일, 야간진료]
			List<String> otherKeyword = List.of("주차", "주차 가능", "전문의", "여의사", "공휴일 진료", "일요일 진료", "공휴일", "일요일", "야간진료");

			
	    	// 한글로 들어올 때 인코딩 해주기
	        String encodedKeyword = URLEncoder.encode(keyword, StandardCharsets.UTF_8.toString());
	        // 디코딩
	        String decodedKeyword = URLDecoder.decode(encodedKeyword, StandardCharsets.UTF_8.toString());
	        if (kindKeyword.contains(decodedKeyword)) {
	        	return "redirect:/hospital?kindKeyword=" + encodedKeyword;
	        } else if (symptomKeyword.contains(decodedKeyword)) {
	        	return "redirect:/hospital?symptomKeyword=" + encodedKeyword;
	        } else if (otherKeyword.contains(decodedKeyword)) {
	        	return "redirect:/hospital?otherKeyword=" + encodedKeyword;
	        } else if (decodedKeyword.contains("전체") || decodedKeyword.contains("예약") || decodedKeyword == "") {
	        	return "redirect:/hospital";
	        } else {
	        	return "redirect:/hospital?keyword=" + encodedKeyword;
	        } 
	}
	
	
	@GetMapping("/hospital")
	public String hospitalList(@RequestParam(required = false) Map<String, Object> map, Model model, HttpSession session) {
		model.addAttribute("map", map);// map : {kindKeyword=소아과} {symptomKeyword=안구건조증} {otherKeyword=여의사} {keyword=안경}
		
		// 현재 요일와 시간
		Calendar cal = Calendar.getInstance();
		String currentDay = searchUtil.convertDayOfWeek(cal.get(Calendar.DAY_OF_WEEK)); // 현재 요일 (1일, 2월, 3화, 4수, 5목, 6금, 7토)
		model.addAttribute("currentDay", currentDay);
		
		Date currentTime = cal.getTime(); // 현재 시간
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss"); // 시간 형식 
		String formattedTime = sdf.format(currentTime); // 포맷된 시간 (10:44:55)
		model.addAttribute("currentTime", formattedTime);
		
		//[{dpkind=피부과, hholidayendtime=12:00:00, hparking=1, dpno=5, hnightday=수요일, dno=1, dpsymptom=피부 질환, hno=1, dpkeyword=티눈,아토피,안면홍조, dspecialist=0, dgender=0, reviewCount=4, hopentime=09:00:00, hnightendtime=23:00:00, hname=연세세브란스, haddr=서울특별시 서대문구 신촌동 연세로 50-1, hclosetime=18:00:00, hholiday=0, reviewAverage=4.2}
		// 기본
		List<Map<String, Object>> hospitalList = searchService.hospitalList();
		
		// 진료과별
		List<Map<String, Object>> kindHospitalList = searchService.kindHospitalList(map);
		
		// 증상별
		List<Map<String, Object>> symptomHospitalList = searchService.symptomHospitalList(map);
		
		// 기타 키워드별 (야간진료일 때, 아닐때 나눔)
		List<Map<String, Object>> otherHospitalList = searchService.otherHospitalList(map);
		List<Map<String, Object>> todayNightHospital = new ArrayList<>();
		List<Map<String, Object>> notTodayNightHospital = new ArrayList<>();
		
		// 병원, 의사 이름별
		List<Map<String, Object>> hospitaNamelList = searchService.hospitaNamelList(map);
				
		 /* map : {kindKeyword=소아과} {symptomKeyword=안구건조증} {otherKeyword=여의사} {keyword=안경} */
		if (map.containsKey("kindKeyword")) {
			model.addAttribute("hospitalList", kindHospitalList);
		} else if (map.containsKey("symptomKeyword")) {
			model.addAttribute("hospitalList", symptomHospitalList);
		} else if (map.containsKey("otherKeyword")) {
			if( map.get("otherKeyword").equals("야간진료")) {
				for (Map<String, Object> hospital : otherHospitalList) {
				    String hnightday = (String) hospital.get("hnightday");
				    if (hnightday != null) {
				    	if (currentDay.equals(hnightday)) {
				    		todayNightHospital.add(hospital);
					    } else {
					    	notTodayNightHospital.add(hospital);
					    }
				    } 
				}
				model.addAttribute("hospitalList", todayNightHospital);
	    		model.addAttribute("notTodayNightHospital", notTodayNightHospital);
			} else {
				model.addAttribute("hospitalList", otherHospitalList);
			}
		} else if (map.containsKey("keyword")) {
			model.addAttribute("hospitalList", hospitaNamelList);
		} else {
			model.addAttribute("hospitalList", hospitalList);
		}
		
		// 종류 {dpkind=소아과, dpsymptom=소아 질환, dpkeyword=감기,예방접종,성장판검사,신생아황달}
		List<Map<String, Object>> departmentKeyword = searchService.departmentKeyword();
		model.addAttribute("departmentKeyword", departmentKeyword);
		

		

		// 찜하기
		session.setAttribute("mno", 3);
		List<String> hospitalLike = searchService.hospitalLike(session.getAttribute("mno"));
		//{mhospitallike=이루이비인후과}
		
		return "/hospital";
	}
	
	
	
	@ResponseBody
	@PostMapping("/hospital")
	public String hospitalList() {
		
		JSONObject json = new JSONObject();
		
		
		return json.toString();
	}
	
}
