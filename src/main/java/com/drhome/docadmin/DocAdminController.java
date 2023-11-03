package com.drhome.docadmin;

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
public class DocAdminController {

	@Autowired
	private DocAdminService docAdminService;
	
	@GetMapping("/docMain/{mno}/{dno}")
	public String docMain(@PathVariable int dno, Model model) {
		
		Map<String, Object> docMainDetail = docAdminService.docMainDetail(dno);
		model.addAttribute("docMainDetail", docMainDetail);
		System.out.println(docMainDetail);

		List<Map<String, Object>> telehealthHistory = docAdminService.telehealthHistory(dno);
		model.addAttribute("telehealthHistory", telehealthHistory);
		
		return "/docMain";
	}
	
	@GetMapping("/docReception/{mno}/{dno}")
	public String docReception(@PathVariable int dno, @PathVariable int mno, Model model,@RequestParam Map<String,Object> map) {
		map.put("dno", dno);
		
		//검색내역 뽑기
		List<Map<String, Object>> searchMname = docAdminService.searchMname(map);
		model.addAttribute("searchMname", searchMname);
		
		//진료과 뽑기(hno 통해서 count로 dpno 수 알기)
		int getHno = docAdminService.getHno(map);
		map.put("hno", getHno);
		
		List<Map<String, Object>> dpKind = docAdminService.dpKind(map);
		model.addAttribute("dpKind", dpKind);
		int dpCount = dpKind.size();
		model.addAttribute("dpCount", dpCount);
		
		return "/docReception";
	}
	
	@ResponseBody
	@PostMapping("/deleteRows")
	public String deleteRows(@RequestParam(value = "row[]") List<Integer> tnoArr) {
		
		System.out.println(tnoArr);
		int result = docAdminService.deleteRows(tnoArr);
		
		JSONObject json = new JSONObject();

		return json.toString();
	}
	
}
