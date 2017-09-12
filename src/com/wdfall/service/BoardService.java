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

	public List<BoardDto> list(int page) {
		int end = page * 3;
		int start = end - 3;
		Map<String,String> map = new HashMap<String,String>();
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		return sqlSession.getMapper(BoardDao.class).list(map);
	}

	public void write(BoardDto boardDto) {
		 sqlSession.getMapper(BoardDao.class).write(boardDto);
	}

	public BoardDto view(String seq) {
		sqlSession.getMapper(BoardDao.class).hit(seq);
		return sqlSession.getMapper(BoardDao.class).view(seq);
	}

	public int delete(String boardSeq) {
		return sqlSession.getMapper(BoardDao.class).delete(boardSeq);
	}

	public void modify(BoardDto boardDto) {
		sqlSession.getMapper(BoardDao.class).modify(boardDto);
	}

	public int recommend(BoardDto boardDto) {
		int cnt= sqlSession.getMapper(BoardDao.class).isRecommend(boardDto);
		if(cnt!=0) {
			return 0;
		} else {
			sqlSession.getMapper(BoardDao.class).recommendCount (boardDto.getBoardSeq());
			sqlSession.getMapper(BoardDao.class).recommend(boardDto);
			return 1;
		}
		
	}
}
