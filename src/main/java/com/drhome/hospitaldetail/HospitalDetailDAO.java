package com.drhome.hospitaldetail;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HospitalDetailDAO {

	Map<String, Object> findHospitalByHno(int hno);



}
