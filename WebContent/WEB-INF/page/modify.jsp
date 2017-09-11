<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/header.jsp" %>

<c:choose>
<c:when test="${empty memberInfo}">
<script type="text/javascript">	
$(window).on('load', function(){
	alert("로그인 하세요!");
	$(location).attr('href','${root}/loginForm?uri=${root}/modify/${boardSeq}');
});
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">	
var boardSeq ="${boardSeq}";
	$.ajax({
		type : 'GET',
		dataType : 'json',
		data : {'boardSeq' : boardSeq},
		url : '${root}/loadArticle',
		success : function(data) {
				$("#boardSeq").text(data.boardSeq);
				$("#id").text(data.id);
				$("#insertDate").text(data.insertDate);
				$("#updateDate").text(data.updateDate);
				$("#subject").val(data.subject);
				$("#content").text(data.content);
		},
		error: function(){
			alert("잘못된 글번호 입니다!");
			$(location).attr('href','${root}/list');
		}
	});
function modifyOk(){
	if(confirm("수정???")) {
		if($('#subject').val() == "") {
			alert("제목을 입력하세요!");
			return;
		} else if($('#subject').val().length >80) {
			alert("제목은 80글자 이내로 작성해 주세요!");
			return;
		} else if($('#content').val() == "") {
			alert("내용을 입력하세요!");
			return;
		} else {
			$('#modifyForm').attr('action', '${root}/modifySave').submit();
		}
	}
}
function cancelOk() {
	if(confirm('취소??')) {
		$(location).attr('href','${root}/view/${boardSeq }');
	};
};	
</script>
<div class="container" style="margin-top: 100px;">
	
	<form method="post" action="" id="modifyForm" name="modifyForm">
	<input type="hidden" name="boardSeq" value="${boardSeq }">
	<table>
		<tr>
			<td>글번호</td>
			<td id="boardSeq" colspan="3"></td>
		</tr>
		<tr>
			<td>등록일</td>
			<td id="insertDate" colspan="3"></td>
		</tr>
		<tr>
			<td>수정일</td>
			<td id="updateDate" colspan="3"></td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><input type="text" class="" id="subject" name="subject" value=""></td>
		</tr>
		<tr>
			<td>내용</td>
			<td colspan="3"><textarea id="content" name="content" rows="30px;" cols="30px;"></textarea></td>
		</tr>
	</table>
	</form>
	<table>
		<tr style="text-align: center;">
			<td><input type="button" value="저장" onclick="javascript:modifyOk();"></td>
			<td><input type="button" value="취소" onclick="javascript:cancelOk();"></td>
		</tr>
	</table>
	</div>
	</body>
	</html>
</c:otherwise>
</c:choose>