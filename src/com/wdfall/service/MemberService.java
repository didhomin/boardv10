package com.wdfall.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wdfall.dao.MemberDao;
import com.wdfall.dto.MemberDto;

@Service
public class MemberService {
	@Autowired
	private SqlSession sqlSession;

	public MemberDto login(MemberDto memberDto) {
		
		return sqlSession.getMapper(MemberDao.class).login(memberDto);
	}

}
