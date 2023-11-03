package com.drhome.docadmin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocAdminDAO {

	List<Map<String, Object>> telehealthHistory(int dno);

	List<Map<String, Object>> searchMname(Map<String, Object> map);

	int getHno(Map<String, Object> map);

	List<Map<String, Object>> dpKind(Map<String, Object> map);

	Map<String, Object> docMainDetail(int dno);

	int deleteRows(List<Integer> tnoArr);

}
