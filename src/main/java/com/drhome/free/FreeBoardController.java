package com.drhome.free;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FreeBoardController {
		
		@Autowired
		FreeBoardService freeBoardService;

		@GetMapping("/freeBoard")
		public String freeBoard(Model model) {

			List<Map<String, Object>> freeList = freeBoardService.freeList();
			model.addAttribute("freeList", freeList);

			return "/freeBoard";
		}

		@PostMapping("/freeBoard")
		public String freeBoardList(@RequestParam("bno") int bno) {
			
			return "redirect:/freeDetail?bno=" + bno;

		}

		@GetMapping("/freeDetail")
		public String freeDetail(@RequestParam("bno") int bno, Model model,  HttpSession session) {
			 
			//int mno = (int) session.getAttribute("mno");
			int mno = 4; // 추후 세션값으로 변경 예정
			model.addAttribute("mno", mno);
			
			Map<String, Object> freePost = freeBoardService.freePost(bno);
			model.addAttribute("freePost", freePost);

			List<Map<String, Object>> freeComment = freeBoardService.freeComment(bno);
			model.addAttribute("freeComment", freeComment);

			return "freeDetail";
		}
		
		@GetMapping("/writeFree")
		public String writeFree(Model model) {


			return "/writeFree";
		}
		
		@RequestMapping(value="/postFree", method = RequestMethod.POST)
		public String postQna(@RequestParam("btitle") String btitle, @RequestParam("bcontent") String bcontent, @RequestParam("bdate") String bdate) {
			

		    Map<String, Object> freeData = new HashMap<>();
		    freeData.put("btitle", btitle);
		    freeData.put("bcontent", bcontent);
		    freeData.put("bdate", bdate);
		    freeData.put("btype", 1);
		    freeData.put("mno", 4); // 추후 세션값으로 변경 예정

		    freeBoardService.postFree(freeData);
		
		    return "redirect:/freeBoard";
		}
		
		@PostMapping("/writeFreeComment")
		public String writeFreeComment(@RequestParam("bno") int bno, @RequestParam("ccontent") String ccontent,
				@RequestParam("cdate") String cdate) {

			// 게시물당 댓글 수 조회
			int commentCount = freeBoardService.commentCount(bno);

			// 새 댓글의 cno 설정
			int cno = commentCount + 1;

			Map<String, Object> freeCommentData = new HashMap<>();

			freeCommentData.put("bno", bno);
			freeCommentData.put("mno", 4); // 추후 세션값으로 변경 예정
			freeCommentData.put("cno", cno);
			freeCommentData.put("ccontent", ccontent);
			freeCommentData.put("cdate", cdate);

			freeBoardService.writeFreeComment(freeCommentData);

			return "redirect:/freeDetail?bno=" + bno;
		}
		
}
