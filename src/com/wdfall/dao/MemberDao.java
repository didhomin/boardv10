package com.wdfall.dao;


import org.springframework.stereotype.Repository;

import com.wdfall.dto.MemberDto;
@Repository
public interface MemberDao {
	MemberDto login(MemberDto memberDto);
}
