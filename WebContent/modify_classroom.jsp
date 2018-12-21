<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>강의실수정</title>
<link rel="stylesheet" type="text/css" href="css/modify_pro.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
</head>

<body>

	<%
		request.setCharacterEncoding("utf-8");
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul";
		String id1 = "root";
		String pass = "8798qwer!!";
		String roomnumber = request.getParameter("roomnumber");
		System.out.println("roomnumber=" + roomnumber);
		int capacity = 0;

		Statement stmt = null;
		try {

			Connection conn = DriverManager.getConnection(url, id1, pass);
			stmt = conn.createStatement();

			String sql = "SELECT roomnumber, capacity FROM classroom WHERE roomnumber = " + "'" + roomnumber + "'";
			ResultSet rs = stmt.executeQuery(sql);

			if (rs.next()) {
				capacity = rs.getInt(2);

			}
			rs.close();
			conn.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>

	<div class="info">
		<h2>강의실수정</h2>
		<fieldset>
			<p id="direction">수정하고자 하는 정보를 재입력해주시기 바랍니다.</p>
			<form name=modifyform method=post
				action="modify_ok_classroom.jsp?roomnumber=<%=roomnumber%>" id="form">
				<table>
					<tr>
						<th>강의실번호</th>
						<th>수용인원</th>

					</tr>
					<tr>
						<td><%=roomnumber%><input type=hidden value="<%=roomnumber%>"></td>
						<td><input type=text name="capacity" value="<%=capacity%>" id="cap"></td>
					</tr>
				</table>
				<input class="submit" type="button" value="수정" onclick="check();"> <input
					class="submit" type="button" value="취소"
					OnClick="javascript:history.back(-1)">
			</form>
		</fieldset>
	</div>
	<script>
		function check() {
	
			var capacity = document.getElementById("cap");

			var chk_capacity = /^[0-9]{1,2}$/;

			if (capacity.value == "") {
				alert("필수항목을 입력하세요.");
			} else if (!chk_capacity.test(capacity.value)) {
				alert("수용인원을 형식에 맞게 입력해주세요.(숫자만 가능)");
				return false;
			} else {
				confirm_mod();
			}
		}

		function confirm_mod() {
			var form = document.getElementById("form");
			var r = confirm("수정하시겠습니까?");
			if (r == true) {
				form.submit();
			} else {
				location.href = "inquiry_classroom.jsp";
			}

		}
	</script>
</body>

</html>