package com.drhome.appointment;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AppointmentDAO {

	List<Map<String, Object>> hospitals(Map<String, Object> map);

	Map<String, Object> hospital(int hno);

	List<Map<String, Object>> detail(Map<String, Object> map);

	List<Map<String, Object>> time(int hno);

	List<Map<String, Object>> doctor(int hno);

	int result(Map<String, Object> map);

	Map<String, Object> loginCheck(Map<String, Object> map);

	List<Map<String, Object>> getDoctorsByDpno(int dpno);

	List<Map<String, Object>> department(int dpno);

}
