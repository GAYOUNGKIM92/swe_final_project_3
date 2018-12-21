<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>강의실등록</title>
<link rel="stylesheet" type="text/css" href="css/register_pro.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
</head>

<body>
	<div class="info">
		<h2>강의실등록</h2>
		<form action="insert_classroom.jsp" method="post">
			<fieldset>
				<p id="direction">등록하고자 하는 강의실의 정보를 입력해주세요.</p>
				<br>
				<table>
					<tr>
						<td>강의실 이름</td>
						<td><input class="textbox" type="text" name="roomnumber" size="30"
							required autocomplete="off"></td>
					</tr>
					<tr>
						<td>수용 인원</td>
						<td><input class="textbox" type="text" name="capacity" size="30"></td>
					</tr>

				</table>
				<input class="submit" type="submit" value="등록">
			</fieldset>
		</form>
	</div>
</body>
</html>