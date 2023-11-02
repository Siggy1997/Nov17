package com.drhome.myinfo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyInfoDAO {

	Map<String, Object> myInfo(int mno);

	void changePW(Map<String, Object> map);

	void changeHomeAddr(Map<String, Object> map);

	void changeCompanyAddr(Map<String, Object> map);

	void changePhoneNumber(Map<String, Object> map);

	List<Map<String, Object>> myWriting(int mno);

	List<Map<String, Object>> myComment(int mno);

}
