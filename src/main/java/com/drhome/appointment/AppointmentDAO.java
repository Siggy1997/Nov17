package com.drhome.appointment;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AppointmentDAO {

	Map<String, Object> findHospitalDeatilByHno(Map<String, Object> data);

	List<Map<String, Object>> checkTimeStatus(Map<String, Object> data);

	ArrayList<Map<String, Object>> findDoctorByHno(Map<String, Object> hno);

	void appointmentFinish(Map<String, Object> data);

}
