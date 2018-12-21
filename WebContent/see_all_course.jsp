<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>전체강의조회</title>
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/inquiry_professor.css">
</head>

<body>

	<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul";
		String id1 = "root";
		String pass = "8798qwer!!";
		int total = 0;

		try {
			Connection conn = DriverManager.getConnection(url, id1, pass);
			Statement stmt = conn.createStatement();

			String sqlCount = "SELECT COUNT(*) FROM course";
			ResultSet rs = stmt.executeQuery(sqlCount);

			if (rs.next()) {
				total = rs.getInt(1);
			}
			rs.close();

			String sqlList = "SELECT cnumber, coursename, credit, roomnumber, pname from course";
			rs = stmt.executeQuery(sqlList);
	%>



	<div class="info">
		<table id="pro_tb">
			<tr>
				<th>학수번호</th>
				<th>강의명</th>
				<th>학점</th>
				<th>강의실</th>
				<th>교수</th>
			</tr>
			<tr>
				<td class="hr" colspan="5">
					<hr>
				</td>
			</tr>

			<%
				if (total == 0) { // total 즉, 자료가 없다면
			%>
			<tr align="center" bgcolor="#FFFFFF" height="30">
				<td colspan="3">등록된 학생이 없습니다.</td>
			</tr>
			<%
				} else { // total이 0이 아닌 즉 자료가 1개이상 있다면

						while (rs.next()) { // while이라는 반복문으로 자료를 찾습니다. rs.next()는 다음라인으

							int cnumber = rs.getInt(1); // 1은 첫번째 즉 num값을 idx라는 변수에 대입
							String coursename = rs.getString(2); // name
							int credit = rs.getInt(3); // title
							String roomnumber = rs.getString(4); // title
							String pname = rs.getString(5); // title
			%>
			<tr>
				<td><%=cnumber%></td>
				<td><%=coursename%></td>
				<td><%=credit%></td>
				<td><%=roomnumber%></td>
				<td><%=pname%></td>
			</tr>
			<%
				}
					}
					rs.close(); //rs객체 반환
					stmt.close(); // stmt객체 반환
					conn.close(); // conn객체 반환
				} catch (SQLException e) {
					out.println(e.toString()); //에러 날경우 에러출력
				}
			%>

		</table>
	</div>
	<input class="submit" type="button" value="뒤로가기"
		OnClick="javascript:history.back(-1)">
</body>
</html>