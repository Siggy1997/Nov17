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

	int insertRegister(Map<String, Object> map);

	List<Map<String, Object>> hList();

	int insertDoctor(Map<String, Object> map);

	int resultCh(Map<String, String> map);

	Map<String, Object> detail(int rhno);

	List<Map<String, Object>> approvalHospital(Map<String, Object> map);

	int deleteHospital(int rhno);

	int insertHospital(Map<String, Object> map);

	List<Map<String, Object>> finalHospital();

	List<Map<String, Object>> newHospital(int hno);

	Map<String, Object> realDetail(int hno);

	List<Map<String, Object>> search(Map<String, Object> map);

	List<Map<String, Object>> viewDoctor(int hno);

	List<Map<String, Object>> searchHos(Map<String, Object> map);

	/* List<Map<String, Object>> hospitalList(int rhno); */

}
