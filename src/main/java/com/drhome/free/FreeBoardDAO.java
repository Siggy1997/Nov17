package com.drhome.free;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FreeBoardDAO {


	List<Map<String, Object>> freeList();

	Map<String, Object> freePost(int bno);

	List<Map<String, Object>> freeComment(int bno);

	void postFree(Map<String, Object> freeData);

	int commentCount(int bno);

	void writeFreeComment(Map<String, Object> freeCommentData);


}
