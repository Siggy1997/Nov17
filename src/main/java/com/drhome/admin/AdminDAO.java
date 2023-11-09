package com.drhome.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface AdminDAO {

	List<Map<String, Object>> memberList();

	int gradeChange(Map<String, String> map);

	Map<String, Object> adminLogin(Map<String, Object> map);

	List<Map<String, Object>> manageBoardList();

	List<Map<String, Object>> report(Map<String, Object> map);

	int resultChange(Map<String, String> map);

	void memberRcount(int getMno);

	int getMno(Map<String, String> map);

	List<Map<String, Object>> reportList(Map<String, Object> map);

	List<Map<String, Object>> aApprove(Map<String, Object> map);

	int appointmentChange(Map<String, String> map);

	Map<String, Object> adminInfo(Map<String, Object> map);

	List<Map<String, Object>> hospitalOpen(Map<String, Object> map);

	int insertHospital(Map<String, Object> map);

	List<Map<String, Object>> hList();

	int insertDoctor(Map<String, Object> map);

}
