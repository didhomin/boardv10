<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/page/header.jsp" %>
<c:if test="${not empty isNum}">
<script type="text/javascript">	
window.onload= function() {
	alert("잘못된 글번호 입니다!");
}
</script>
</c:if>
<script type="text/javascript">
$(document).ready(function() {
	var secretid = $('#hello').attr('secretid');
	
	var pg =1;
	$.ajax({
		type : 'GET',
		dataType : 'json',
		data : {'pg' : pg},
		url : '${root}/loadList',
		success : function(data) {
			var output ='';
			for(var i=0;i<data.size;i++) {
				output += '<tr class="view">';		
				output += 	'<td>'+data.boardList[i].boardSeq+'</td>';
				output += 	'<td>'+data.boardList[i].id+'</td>';
				if("${empty memberInfo}") {
					output += 	'<td>비공개</td>';
				} else if(data.boardList[i].id == secretid){
					output += 	'<td>'+data.boardList[i].subject+'</td>';
				} else {
					output += 	'<td>비공개</td>';
				}
				output += 	'<td>'+data.boardList[i].insertDate+'</td>';
				output += 	'<td>'+data.boardList[i].updateDate+'</td>';
				output += '</tr>';
			}
			$('#boardListView').append(output);
		}
	});
	$(document).on('click','#loadList', function () {
		$.ajax({
			type : 'GET',
			dataType : 'json',
			data : {'pg' : ++pg},
			url : '${root}/loadList',
			success : function(data) {
				var output ='';
				for(var i=0;i<data.size;i++) {
					output += '<tr class="view">';		
					output += 	'<td>'+data.boardList[i].boardSeq+'</td>';
					output += 	'<td>'+data.boardList[i].id+'</td>';
					if("${empty memberInfo}") {
						output += 	'<td>비공개</td>';
					} else if(data.boardList[i].id == secretid){
						output += 	'<td>'+data.boardList[i].subject+'</td>';
					} else {
						output += 	'<td>비공개</td>';
					}
					output += 	'<td>'+data.boardList[i].insertDate+'</td>';
					output += 	'<td>'+data.boardList[i].updateDate+'</td>';
					output += '</tr>';
				}
				$('#boardListView').append(output);
				if(data.size<3) {
					$('#loadList').hide();
				}
			}
		});
	});
});
$(document).on('click','.view', function () {
	var seq = $(this).children().eq(0).text();
	document.location.href = "${root}/view/"+seq;
});
$(document).on('click','.logout', function () {
	$.ajax({
		type : 'GET',
		url : '${root}/login',
		success : function(data) {
			$('.fail').show();
			$('.id').val('');
			$('.password').val('');
			$('.success').hide();
			isLogin="false";
			var pg =1;
			$.ajax({
				type : 'GET',
				dataType : 'json',
				data : {'pg' : pg},
				url : '${root}/loadList',
				success : function(data) {
					var output ='';
					$('#boardListView').html('');
					for(var i=0;i<data.size;i++) {
						output += '<tr class="view">';		
						output += 	'<td>'+data.boardList[i].boardSeq+'</td>';
						output += 	'<td>'+data.boardList[i].id+'</td>';
						if("${empty memberInfo}") {
							output += 	'<td>비공개</td>';
						} else if(data.boardList[i].id == secretid){
							output += 	'<td>'+data.boardList[i].subject+'</td>';
						} else {
							output += 	'<td>비공개</td>';
						}
						output += 	'<td>'+data.boardList[i].insertDate+'</td>';
						output += 	'<td>'+data.boardList[i].updateDate+'</td>';
						output += '</tr>';
					}
					$('#boardListView').append(output);
				}
			});
		}
	});
});
</script>

<div class="container" style="margin-top: 100px;">
	<table class="table table-filter" id="extable">
		<thead>
			<tr class="primary" align="center">
				<th>글번호</th>
				<th>글쓴이</th>
				<th>제목</th>
				<th>등록일</th>
				<th>수정일</th>
			</tr>
		</thead>
		<tbody id="boardListView">
		</tbody>
	</table>
	<table class="table table-filter" style="text-align: center;" id="extable">
		<tr id="loadList">
			<td><a href="#">더보기</a></td>
		</tr>
		<tr>
			<td><a href="${root}/write" id="writeBtn">글쓰기</a></td>
		</tr>
	</table>
</div>


</body>
</html>
