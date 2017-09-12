<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
var isLogin='${not empty memberInfo}';
var loginId='${memberInfo.id}';
function headerLogin() {
var id = $('#headerId').val();
var password = $('#headerPassword').val();
$.ajax({
	type : 'POST',
	dataType : 'json',
	url : '${root}/login',
	data : {'id' : id,
			'password' : password
	},
	success : function(data) {
		if(data.isLogin=="success") {
			loginId=id;
			if("${not empty uri}" =="true") {
				$(location).attr('href','${uri}');
			}
			$('.fail').hide();
			$('#headerId').val('');
			$('#headerPassword').val('');
			$('#hello').text(data.id+'님 안녕하세요');
			$('.success').show();
			isLogin="true";
		} else {
			alert("아이디 비밀번호를 확인하세요!")
			$('#headerId').val('');
			$('#headerPassword').val('');
			$('.fail').css("display","");
			$('.success').css("display","none");
			isLogin="false";
		}
	}
});
}
function headerLogout(){
$.ajax({
	type : 'GET',
	url : '${root}/logout',
	success : function(data) {
		$('.fail').show();
		$('#headerId').val('');
		$('#headerPassword').val('');
		$('.success').hide();
		isLogin='false';
		loginId='';
	}
});
}
$(document).on('click','#headerLogin', function () {
	headerLogin();
});
$(document).on('click','#headerLogout', function () {
	headerLogout();
});
</script>
<title>Insert title here</title>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="${root}/index.jsp">HOMIN PROJECT</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav pull-right" style="margin-top: 15px;">
          	<c:choose>
          		<c:when test="${empty memberInfo }">
					<li class="fail"><input id="headerId" type="text"></li>
					<li class="fail"><input id="headerPassword" type="password"></li>
					<li class="fail"><input id="headerLogin" type="button" value="login"></li>
					<li class="success" style="display: none;"><font id="hello" color="white">${memberInfo.id }님 안녕하세요</font></li>
			        <li class="success" style="display: none;"><input id="headerLogout" type="button" value="logout"></li>
          		</c:when>
          		<c:otherwise>
          			<li class="fail" style="display: none;"><input id="headerId" type="text"></li>
					<li class="fail" style="display: none;"><input id="headerPassword" type="password"></li>
					<li class="fail" style="display: none;"><input id="headerLogin" type="button" value="login"></li>
			        <li class="success"><font id="hello" color="white">${memberInfo.id }님 안녕하세요</font></li>
			        <li class="success"><input id="headerLogout" type="button" value="logout"></li>
          		</c:otherwise>
          	</c:choose>
          </ul>
        </div>
      </div>
    </nav>

   
