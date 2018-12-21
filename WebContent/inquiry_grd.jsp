<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<html>

<head>
<title>학생조회</title>
<link rel="stylesheet" type="text/css" href="css/inquiry_professor.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
</head>

<body>

	<div class="info">
		<h2>졸업불가 학생조회</h2>
	<%
		request.setCharacterEncoding("utf-8");
		String sqlStr;
		Connection conn = null;
		Statement stmt = null;
		int total = 0;
		int num = 0;


	%>
	<%
		Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul",
					"root", "8798qwer!!");
			stmt = conn.createStatement();

			String sqlCount = "select count(*) from student where semester >=7 and credit < 120;";
			ResultSet rs = stmt.executeQuery(sqlCount);

			if (rs.next()) {
				total = rs.getInt(1);
			}


			String sql = "select * from student where semester >=7 and credit < 120;";
			rs = stmt.executeQuery(sql);
	%>

	<hr>
	<div class="info" id="display">
		<table>
			<tr>
				<th>학생번호</th>
				<th>이름</th>
				<th>연락처</th>
				<th>학기</th>
				<th>학점</th>
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
				<td colspan="6">학생 모두 졸업요건을 만족합니다.</td>
			</tr>
			<%
				} else {
						while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getInt("snumber")%></td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getString("phone")%></td>
				<td><%=rs.getInt("semester")%></td>
				<td><%=rs.getInt("credit")%></td>
				<td></td>
			</tr>
			<%
				}
			%>
		</table>
		<%
			}
				rs.close();
				stmt.close();
				conn.close();

		%>
	</div>
</body>

</html>