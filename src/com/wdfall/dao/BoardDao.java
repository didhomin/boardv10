package com.wdfall.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.wdfall.dto.BoardDto;

@Repository
public interface BoardDao {
	List<BoardDto> list(Map<String,String> map);
	BoardDto view(String seq);
	void write(BoardDto boardDto);
	void modify(BoardDto boardDto);
	void delete(String seq);
}
