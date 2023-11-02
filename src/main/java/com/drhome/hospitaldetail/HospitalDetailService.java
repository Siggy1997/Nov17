package com.drhome.hospitaldetail;

<<<<<<< HEAD
import java.util.Map;

=======
import java.util.ArrayList;
import java.util.Map;

import org.json.JSONArray;
>>>>>>> fcf96f6a336637dcac6301ac9175cae50d5ca486
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HospitalDetailService {
<<<<<<< HEAD
	
	@Autowired
	private HospitalDetailDAO hospitalDetailDAO;

	public Map<String, Object> findHospitalByHno() {
		int hno = 1;
		
		return hospitalDetailDAO.findHospitalByHno(hno);
	}
	
	
	
	
=======
	@Autowired
	private HospitalDetailDAO hospitalDetailDAO;

	public Map<String, Object> findHospitalByHno(int hno) {
		return hospitalDetailDAO.findHospitalByHno(hno);
	}

	public ArrayList<Map<String, Object>> findDoctorByHno(int hno) {

		return hospitalDetailDAO.findDoctorByHno(hno);
	}

	public ArrayList<Map<String, Object>> findReviewByHno(int hno) {

		return hospitalDetailDAO.findReviewByHno(hno);
	}
	
	public Map<String, Object> countReviewByRate(int hno) {
		return hospitalDetailDAO.countReviewByRate(hno);
	}
	
	public void hospitalUnlike(String hname) {
		hospitalDetailDAO.hospitalUnlike(hname);
	}

	public void hospitalLike(String hname) {
		hospitalDetailDAO.hospitalLike(hname);

	}

	public Map<String, Object> findDoctorByDno(int dno) {
		return hospitalDetailDAO.findDoctorByDno(dno);
	}

	public ArrayList<Map<String, Object>> sortReviewByNew(int hno) {
		// TODO Auto-generated method stub
		return hospitalDetailDAO.sortReviewByNew(hno);
	}

	public ArrayList<Map<String, Object>> sortReviewByOld(int hno) {
		return hospitalDetailDAO.sortReviewByOld(hno);
	}

	public ArrayList<Map<String, Object>> sortReviewByHighRate(int hno) {
		return  hospitalDetailDAO.sortReviewByHighRate(hno);
	}
	
	public ArrayList<Map<String, Object>> sortReviewByLowRate(int hno) {
		return  hospitalDetailDAO.sortReviewByLowRate(hno);
	}

	public void countUpReviewLike(String reviewer) {
		hospitalDetailDAO.countUpReviewLike(reviewer);
	}




>>>>>>> fcf96f6a336637dcac6301ac9175cae50d5ca486
}
