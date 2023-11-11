package com.drhome.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MainService {
	
	@Autowired
	private MainDAO mainDAO;
	
	public Map<String, Object> findQuizByRandom(int randomNumber) {
		return mainDAO.findQuizByRandom(randomNumber);
	}

	public List<Map<String, Object>> findNewQna() {
		return mainDAO.findNewQna();
	}


	public void raisePointByQuiz(Map<String, Object> data) {
		mainDAO.raisePointByQuiz(data);
		
	}


}
