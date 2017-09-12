package com.wdfall.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.wdfall.dto.BoardDto;

@Repository
public interface BoardDao {
	List<BoardDto> list(Map<String,String> map);
	BoardDto view(String boardSeq);
	void write(BoardDto boardDto);
	void modify(BoardDto boardDto);
	int delete(String boardSeq);
	void hit(String boardSeq);
	int recommend(BoardDto boardDto);
	int isRecommend(BoardDto boardDto);
	void recommendCount(String boardSeq);
}
