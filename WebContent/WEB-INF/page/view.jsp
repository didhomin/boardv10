<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/header.jsp" %>


<script type="text/javascript">	
$(window).on('load', function(){
	loadArticle();
	$('#recommendBtn').show();
});

var boardSeq ="${boardSeq}";
var writerId = '';
function loadArticle() {
$.ajax({
	type : 'GET',
	dataType : 'json',
	contentType : 'application/json',
	data : {'boardSeq' : boardSeq},
	url : '${root}/loadArticle',
	success : function(data) {
		writerId=data.id;
		if(data.secret=="1") {
			$("#secret").show();
		} else {
			$("#secret").hide();
		}
		$("#boardSeq").text(data.boardSeq);
		$("#writerId").text(data.id);
		$("#insertDate").text(data.insertDate);
		$("#updateDate").text(data.updateDate);
		$("#hit").text(data.hit);
		$("#recommend").text(data.recommend);
		$("#subject").text(data.subject);
		$("#content").html(data.content);
		if(data.id==loginId) {
			$('#articleModifyBtn').show();
			$('#articleDeleteBtn').show();
		} else {
			$('#articleModifyBtn').hide();
			$('#articleDeleteBtn').hide();
		}
		if(isLogin=="true") {
			$('#recommendBtn').show();
		} else {
			$('#recommendBtn').hide();
		}
	},
	error: function() {
		alert("잘못된 글번호 입니다!");
		$(location).attr('href','${root}/list');
	}
});
}

function articleModify() {
	
	if(writerId=='${memberInfo.id}') {
		if(confirm('수정??')) {
			$(location).attr('href','${root }/modify/${boardSeq }');
		};
	} else {
		alert("잘못된 접근입니다!");
		$(location).attr('href','${root}/list');
	};
}

function articleDelete() {
	if(isLogin=="true") {
		if(writerId==loginId) {
			if(confirm('삭제??')) {
				$.ajax({
					type : 'DELETE',
					dataType : 'json',
					contentType : 'application/json',
					url : '${root}/delete/'+boardSeq,
					success : function(data) {
						if("success"==data.isDelete) {
							alert("삭제되었습니다");
							$(location).attr('href','${root}/list');
						} else { 
							alert("잘못된 글번호 입니다!");
							$(location).attr('href','${root}/list');
						}
						$(location).attr('href','${root}/list');
					},
					error: function(err) {
						console.log(err);
						alert("잘못된 글번호 입니다!");
						$(location).attr('href','${root}/list');
					}
				});		
			};
		} else {
			alert("작성자만 삭제 가능합니다");
			return;
		};
	} else {
		alert("로그인 하세요!");
		$(location).attr('href','${root}/loginForm?uri=${root}/view/${boardSeq }');
	};
}

function recommend() {
	$.ajax({
		type : 'GET',
		dataType : 'json',
		contentType : 'application/json',
		data : {'memberSeq' : '${memberInfo.memberSeq}',
				'boardSeq' : '${boardSeq}'
		},
		url : '${root}/recommend',
		success : function(data) {
			if("success"==data.isRecommend) {
				alert("추천이되었습니다");
				loadArticle();
			} else { 
				alert("이미추천을하셨습니다");
			}
		},
		error: function() {
			alert("잘못된 글번호 입니다!");
			$(location).attr('href','${root}/list');
		}
	});		
}
	
$(document).on('click','#headerLogout', function () {
	loadArticle();
	$('#recommendBtn').hide();
});

$(document).on('click','#headerLogin', function () {
	loadArticle();
});
</script>
<div class="container" style="margin-top: 100px;">
<table>
		<tr id="secret">
			<td colspan="4">
				비공개글입니다.
			</td>
		</tr>
		<tr>
			<td>글번호</td>
			<td id="boardSeq" colspan="3"></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td id="writerId" colspan="3"></td>
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
			<td>조회수</td>
			<td id="hit" colspan="3"></td>
		</tr>
		<tr>
			<td>추천수</td>
			<td id="recommend" colspan="3"></td>
		</tr>
		<tr>
			<td>제목</td>
			<td id="subject" colspan="3"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td id="content" colspan="3"></td>
		</tr>
		<tr style="text-align: center;">
		<td class=""><a id="articleModifyBtn" class="btn btn-default" href="javascript:articleModify();">수정</a></td>
		<td class=""><a id="articleDeleteBtn" class="btn btn-default" href="javascript:articleDelete();">삭제</a></td>
		<td class=""><a id="recommendBtn" class="btn btn-default" href="javascript:recommend();">추천</a></td>
		<td id="listBtn"><a class="btn btn-default" href="${root}/list">목록</a></td>
		</tr>
</table>
</div>
</body>
</html>