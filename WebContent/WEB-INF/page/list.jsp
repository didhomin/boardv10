<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/page/header.jsp" %>
<c:if test="${not empty isNum}">
<script type="text/javascript">	
$(window).on('load', function(){
	alert("잘못된 글번호 입니다!");
})
</script>
</c:if>
<script type="text/javascript">
var page =1;
$(document).ready(function(){
	request();
});
function request() {
	$.ajax({
		type : 'GET',
		dataType : 'json',
		data : {'page' : page++},
		url : '${root}/loadList',
		success : function(data) {
			var output ='';
			for(var i=0;i<data.length;i++) {
				output += '<tr class="view">';		
				output += 	'<td>'+data[i].boardSeq+'</td>';
				output += 	'<td>'+data[i].id+'</td>';
				if(data[i].secret=="1") {
					if(loginId==data[i].id) {
						output += 	'<td>'+data[i].subject+'</td>';
					}
					else {
						output += 	'<td>비공개글입니다.</td>';
					}
				} else {
					output += 	'<td>'+data[i].subject+'</td>';
				}
				output += 	'<td>'+data[i].insertDate+'</td>';
				output += 	'<td>'+data[i].updateDate+'</td>';
				output += 	'<td>'+data[i].hit+'</td>';
				output += 	'<td>'+data[i].recommend+'</td>';
				output += '</tr>';
			}
			$('#boardListView').append(output);
			if(data.length<3) {
				$('#loadList').hide();
			}
		}
	});
}
function reload() {
	$('#boardListView').text('');
	page=1
	request();
}
$(document).on('click','#loadList', function () {
	request();
});
$(document).on('click','.view', function () {
	var seq = $(this).children().eq(0).text();
	$(location).attr('href','${root}/view/'+seq);
});
$(document).on('click','#headerLogout', function () {
	reload();
});
$(document).on('click','#headerLogin', function () {
	reload();
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
				<th>조회수</th>
				<th>추천수</th>
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
