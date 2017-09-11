<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/header.jsp" %>

<script type="text/javascript">
$(window).on('load', function(){
	 $('.fail').remove(); 
 });
$(document).on('click','#login', function () {
	var id = $('#id').val();
	var password = $('#password').val();
		$.ajax({
			type : 'POST',
			dataType : 'json',
			url : '${root}/login',
			data : {'id' : id,
					'password' : password
			},
			success : function(data) {
				if(data.isLogin=="success") {
					$(location).attr('href','${uri}');
				} else {
					alert("아이디 비밀번호를 확인하세요!")
					$('#id').val('');
					$('#password').val('');
				}
			}
		});
	});
</script>
<div class="container" style="margin-top: 100px;">
	<form class="" accept-charset="UTF-8" method="post" action="${root }/login">
		<div class="">
			<input id="id" type="text">
		</div>
		<div class="">
			<input id="password" type="password">
		</div>

		<input id="login" type="button" value="Login">
	</form>
</div>
</body>
</html>