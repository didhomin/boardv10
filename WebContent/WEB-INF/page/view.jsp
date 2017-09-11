<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/header.jsp" %>

<c:choose>
<c:when test="${empty memberInfo}">
<script type="text/javascript">	
$(window).on('load', function(){
	alert("로그인 하세요!");
	$(location).attr('href','${root}/loginForm?uri=${root}/view/${boardSeq}');
})
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">	
var boardSeq ="${boardSeq}";
$(window).on('load', function(){
	$.ajax({
		type : 'GET',
		dataType : 'json',
		contentType : 'application/json',
		data : {'boardSeq' : boardSeq},
		url : '${root}/loadArticle',
		success : function(data) {
				$("#boardSeq").text(data.boardSeq);
				$("#id").text(data.id);
				$("#insertDate").text(data.insertDate);
				$("#updateDate").text(data.updateDate);
				$("#subject").text(data.subject);
				$("#content").text(data.content);
		},
		error: function() {
			alert("잘못된 글번호 입니다!");
			$(location).attr('href','${root}/list');
		}
	});
});
function boardDelete() {
	if(isLogin=="true") {
		if(confirm('삭제??')) {
			$(location).attr('href','${root }/delete/${boardSeq }');
		};
	} else {
		alert("로그인 하세요!");
		$(location).attr('href','${root}/loginForm?uri=${root}/view/${boardSeq }');
	};
}
</script>
<div class="container" style="margin-top: 100px;">
<table>
		<tr>
			<td>글번호</td>
			<td id="boardSeq" colspan="3"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td id="id" colspan="3"></td>
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
			<td id="subject" colspan="3"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td id="content" colspan="3"></td>
		</tr>
</table>
<table>
	<tr style="text-align: center;">
		<td><a class="btn btn-default" href="${root }/modify/${boardSeq }">수정</a></td>
		<td><a class="btn btn-default" href="javascript:boardDelete();">삭제</a></td>
		<td><a class="btn btn-default" href="${root}/list">목록</a></td>
	</tr>
</table>
</div>
</body>
</html>
</c:otherwise>
</c:choose>