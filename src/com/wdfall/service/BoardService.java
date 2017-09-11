package com.wdfall.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wdfall.dao.BoardDao;
import com.wdfall.dto.BoardDto;

@Service
public class BoardService {
	@Autowired
	private SqlSession sqlSession;

	public List<BoardDto> list(int pg) {
		int end = pg * 3;
		int start = end - 3;
		Map<String,String> map = new HashMap<String,String>();
		//TODO 형변환
		map.put("start", start+"");
		map.put("end", end+"");
		return sqlSession.getMapper(BoardDao.class).list(map);
	}

	public void write(BoardDto boardDto) {
		 sqlSession.getMapper(BoardDao.class).write(boardDto);
	}

	public BoardDto view(String seq) {
		return sqlSession.getMapper(BoardDao.class).view(seq);
	}

	public void delete(String seq) {
		sqlSession.getMapper(BoardDao.class).delete(seq);
	}

	public void modify(BoardDto boardDto) {
		sqlSession.getMapper(BoardDao.class).modify(boardDto);
	}
}
