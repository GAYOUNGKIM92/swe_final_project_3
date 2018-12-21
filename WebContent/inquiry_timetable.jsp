<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<html>

<head>
<title>시간표조회</title>
<link rel="stylesheet" type="text/css" href="css/inquiry_professor.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
	<style>
		img{
			width : 80em;
		}
	</style>
</head>

<body>

	<%
		request.setCharacterEncoding("utf-8");
		ResultSet rset = null;
		String sqlStr;
		Connection conn = null;
		Statement stmt = null;
		int total = 0;
		int num = 0;


		Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul",
					"root", "8798qwer!!");
			stmt = conn.createStatement();

			String sqlCount = "SELECT COUNT(*) FROM timetable";
			ResultSet rs = stmt.executeQuery(sqlCount);

			if (rs.next()) {
				total = rs.getInt(1);
				System.out.println(total);
			}
			rs.close();

			sqlStr = "select * from timetable"; 
			rset = stmt.executeQuery(sqlStr);
	%>




			<%
				if (total == 0) { // total 즉, 자료가 없다면
			%>
				<p>시간표가 존재하지 않습니다.</p>
			<%
				} else {
						while (rset.next()) {
				%>
				<img src=<%=rset.getString("url") %> width="300">
				<%
						}
			
				rset.close();
				stmt.close();
				conn.close();
			}
		%>



</body>

</html>