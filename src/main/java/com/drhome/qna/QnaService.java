package com.drhome.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnaService {
	@Autowired 
	private QnaDAO qnaDAO;

	public List<Map<String, Object>> qnaList() {
		return qnaDAO.qnaList();
	}
}
