package com.wdfall.dto;

public class BoardDto {

	/**
	 * boardSeq 글번호
	 * subject 글제목
	 * memberSeq 회원번호
	 * id 글쓴이아이디
	 * content 글내용
	 * insertDate 등록일시
	 * updateDate 수정일시*/
	private String boardSeq;
	private String id;
	private String memberSeq;
	private String subject;
	private String content;
	private String insertDate;
	private String updateDate;
	
	public String getMemberSeq() {
		return memberSeq;
	}
	public void setMemberSeq(String memberSeq) {
		this.memberSeq = memberSeq;
	}
	public String getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(String boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getSubject() {
		return subject;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(String insertDate) {
		this.insertDate = insertDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	
}
