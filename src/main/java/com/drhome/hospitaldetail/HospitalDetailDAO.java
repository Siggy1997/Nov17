package com.drhome.hospitaldetail;

<<<<<<< HEAD
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
=======
import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.json.JSONArray;
>>>>>>> fcf96f6a336637dcac6301ac9175cae50d5ca486

@Mapper
public interface HospitalDetailDAO {

	Map<String, Object> findHospitalByHno(int hno);

<<<<<<< HEAD
=======
	ArrayList<Map<String, Object>> findDoctorByHno(int hno);

	ArrayList<Map<String, Object>> findReviewByHno(int hno);

	Map<String, Object> findDoctorByDno(int dno);

	Map<String, Object> countReviewByRate(int hno);
	void hospitalUnlike(String hname);

	void hospitalLike(String hname);


	ArrayList<Map<String, Object>> sortReviewByNew(int hno);

	ArrayList<Map<String, Object>> sortReviewByOld(int hno);

	ArrayList<Map<String, Object>> sortReviewByHighRate(int hno);

	ArrayList<Map<String, Object>> sortReviewByLowRate(int hno);

	void countUpReviewLike(String reviewer);

>>>>>>> fcf96f6a336637dcac6301ac9175cae50d5ca486


}
