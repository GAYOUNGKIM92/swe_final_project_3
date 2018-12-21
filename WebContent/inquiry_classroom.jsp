<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<html>

<head>
<title>강의실조회</title>
<link rel="stylesheet" type="text/css" href="css/inquiry_professor.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
</head>

<body>

	<div class="info">
		<h2>강의실조회</h2>
		<form method="post" id="inq_c_form">
			<fieldset>
				<p id="direction">강의실 이름을 입력해주시기 바랍니다.</p>
				<p id="number">강의실 이름</p>
				<input class="textbox" type="text" name="roomnumber" required
					autocomplete="off" id="cname"><br> <input type="button"
					class="submit" value="조회하기" onclick="name_reg();"><br>
			</fieldset>
		</form>
	</div>
		<script>
			function name_reg() {
				var name = document.getElementById("cname");
				if (name.value == "") {
					alert("이름을 입력하세요.");
				} else{
					document.getElementById("inq_c_form").submit();
				}
			}
		</script>
	<%
		request.setCharacterEncoding("utf-8");
		String roomnumber = request.getParameter("roomnumber");
		ResultSet rset = null;
		String sqlStr;
		Connection conn = null;
		Statement stmt = null;
		int total = 0;
		int num = 0;

		if (roomnumber != null) {
	%>
	<%
		Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul",
					"root", "8798qwer!!");
			stmt = conn.createStatement();

			String sqlCount = "SELECT COUNT(*) FROM classroom where roomnumber like";
			sqlCount += "'" + roomnumber + "'";
			ResultSet rs = stmt.executeQuery(sqlCount);

			if (rs.next()) {
				total = rs.getInt(1);
			}
			rs.close();

			sqlStr = "select * from classroom where roomnumber like";
			sqlStr += "'" + roomnumber + "'";
			rset = stmt.executeQuery(sqlStr);
	%>

	<hr>
	<div class="info" id="display">
		<table>
			<tr>
				<th>강의실이름</th>
				<th>수용인원</th>
				<th></th>
			</tr>
			<tr>
				<td class="hr" colspan="6">
					<hr>
				</td>
			</tr>
			<%
				if (total == 0) { // total 즉, 자료가 없다면
			%>

			<tr align="center">
				<td colspan="6">해당되는 이름의 강의실이 존재하지 않습니다.</td>
			</tr>
			<%
				} else {
						while (rset.next()) {
							int capacity = rset.getInt("capacity");
			%>
			<tr>
				<td><%=roomnumber%></td>
				<td><%=capacity%></td>
				<%
					Statement stmt1 = conn.createStatement();
								int total1 = 0;

								String sqlCount1 = "SELECT COUNT(*) FROM course where roomnumber like ";
								sqlCount1 += "'" + roomnumber + "'";
								ResultSet rs1 = stmt1.executeQuery(sqlCount1);

								if (rs1.next()) {
									total1 = rs1.getInt(1);
								}
								if (total1 == 0) {
				%>
				<td><input type="button" class="bnt" value="수정"
					OnClick="window.location='modify_classroom.jsp?roomnumber=<%=roomnumber%>'">
					<input type="button" class="bnt" value="삭제"
					OnClick="confirm_delete('<%=roomnumber%>')"></td>
			</tr>
			<%
				}
						}
			%>
		</table>
		<%
			}
				rset.close();
				stmt.close();
				conn.close();
			}
		%>
		<form action="see_all_classroom.jsp">
			<input class="submit" type="submit" value="전체조회">
		</form>
	</div>
			<script>
			
		function confirm_delete(roomnumber) {
			var r = confirm("삭제하시겠습니까?");
			if (r == true) {
				window.location='delete_classroom.jsp?roomnumber='+roomnumber;
			} else {
				window.location = 'inquiry_classroom.jsp';
			}

		}
	</script>
</body>

</html>