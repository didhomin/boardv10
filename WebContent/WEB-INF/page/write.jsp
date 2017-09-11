<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ include file="/WEB-INF/page/header.jsp" %>
<c:if test="${empty memberInfo}">
<script type="text/javascript">	
$(window).on('load', function(){
	alert("로그인 후 이용하세요!");
	$(location).attr('href','${root}/loginForm?uri=${root}/write');
})
</script>
</c:if>
<script type="text/javascript">
function registerOk(){
	if(isLogin=="true"){
		if(confirm("저장???")) {
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
				$('#modifyForm').attr('action', '${root}/writeSave').submit();
			}
		}
	} else {
		alert("로그인 후 이용하세요");
		$(location).attr('href','${root}/loginForm?uri=${root}/write');
	}
}
function cancelOk(){
	if(confirm("취소???")) {
		$(location).attr('href','${root}/list');
	}
}
</script>
<div class="container" style="margin-top: 100px;">

<form method="post" accept-charset="UTF-8" action="" id="writeSave" name="writeForm">
	<input type="hidden" name="memberSeq" value="${memberInfo.memberSeq }">
	
	<label for="subject">제목 :</label>
	<input type="text" class="form-control" id="subject" name="subject">
	
	<label for="content">내용</label>
	<textarea class="form-control" id="content" name="content"></textarea>
	
	<div class="col-sm-1 col-sm-offset-10">
		<button type="button" class="btn btn-primary pull-right" onclick="javascript:registerOk();">저장</button>
	</div>
	<div class="col-sm-1"> 
		<button type="button" class="btn btn-primary pull-right" onclick="javascript:cancelOk();">취소</button>
	</div>
</form>		
</div>
</body>
</html>