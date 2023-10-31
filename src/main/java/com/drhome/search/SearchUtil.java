package com.drhome.search;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class SearchUtil {
	
	// 요일 변환
	public String convertDayOfWeek(int dayOfWeek) {
	    String dayString = "";

	    switch (dayOfWeek) {
	        case Calendar.SUNDAY:
	            dayString = "일요일";
	            break;
	        case Calendar.MONDAY:
	            dayString = "월요일";
	            break;
	        case Calendar.TUESDAY:
	            dayString = "화요일";
	            break;
	        case Calendar.WEDNESDAY:
	            dayString = "수요일";
	            break;
	        case Calendar.THURSDAY:
	            dayString = "목요일";
	            break;
	        case Calendar.FRIDAY:
	            dayString = "금요일";
	            break;
	        case Calendar.SATURDAY:
	            dayString = "토요일";
	            break;
	        default:
	            dayString = "요일을 알 수 없음";
	            break;
	    }

	    return dayString;
	}
	
	// 리스트 안에 있는 Map 꺼내기
	public List<String> changeTypeToString(List<Map<String, Object>> departmentList, String getKeyword) {
		List<String> dpKindList = new ArrayList<>();
		for (Map<String, Object> item : departmentList) {
			String dpKind = (String) item.get(getKeyword);
			dpKindList.add(dpKind);
		}
		return dpKindList;
	}
	
	// 반점 기준으로 잘라서 배열
	public List<String> changeTypeToStringByComma(List<Map<String, Object>> departmentKeyword, String getKeyword) {
        List<String> allKeywords = new ArrayList<>();

        for (Map<String, Object> item : departmentKeyword) {
            String dpKeyword = (String) item.get(getKeyword);
            String[] keywords = dpKeyword.split(",");
            for (String keyword : keywords) {
                allKeywords.add(keyword);
            }
        }
        return allKeywords;
    }
	
}
