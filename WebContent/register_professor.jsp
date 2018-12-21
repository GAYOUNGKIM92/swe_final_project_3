<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>교수등록</title>
<link rel="stylesheet" type="text/css" href="css/register_pro.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
</head>

<body>
	<div class="info">
		<h2>교수등록</h2>
		<form action="insert.jsp" method="post" id="regi_form" autocomplete="off">
			<fieldset>
				<p id="direction">등록하고자 하는 교수의 정보를 입력해주세요.</p>
				<br>
				<table>
					<tr>
						<td>이름</td>
						<td><input class="textbox" type="text" name="name" size="30"
							required autocomplete="off" id="name"></td>
					</tr>
					<tr>
						<td>연락처</td>
						<td><input class="textbox" type="text" name="phone" size="30" id="phone"></td>
					</tr>
					<tr>
						<td>전공</td>
						<td><input class="textbox" type="text" name="major" size="30" id="major"></td>
					</tr>
				</table>
				<input class="submit" type="button" value="등록" onclick="check();">
			</fieldset>
		</form>
	</div>
</body>
<script>

	function check(){
		var form = document.getElementById("regi_form");
		var name = document.getElementById("name");
		var phone = document.getElementById("phone");
		var major = document.getElementById("major");
		
		var chk_name = /^[가-힣]+$/;
		var chk_phone = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
		
		
		 if (name.value == "" || phone.value == "" || major.value == "") {
             alert("필수항목을 입력하세요.");          
         } else if (!chk_name.test(name.value)) {
             alert("이름을 형식에 맞게 입력해주세요. (한글만 입력 가능)");
             return false;
         } else if (!chk_phone.test(phone.value)) {
             alert("전화번호를 형식에 맞게 입력해주세요. (000-0000-0000)");
             return false;
         } else {
			form.submit();
         }
	}
</script>
</html>