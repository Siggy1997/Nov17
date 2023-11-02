package com.drhome.qna;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface QnaDAO {

	List<Map<String, Object>> qnaList();

}
