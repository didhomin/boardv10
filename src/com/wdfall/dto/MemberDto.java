package com.wdfall.dto;

public class MemberDto {

	/**
	 * memberSeq 회원번호
	 * id 아이디
	 * password 비밀번호
	 */
	private String memberSeq;
	private String id;
	private String password;
	
	public String getMemberSeq() {
		return memberSeq;
	}
	public void setMemberSeq(String memberSeq) {
		this.memberSeq = memberSeq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
