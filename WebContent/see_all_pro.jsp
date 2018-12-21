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
<title>전체교수조회</title>
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
			String sqlCount = "SELECT COUNT(*) FROM professor";
			ResultSet rs = stmt.executeQuery(sqlCount);

			if (rs.next()) {
				total = rs.getInt(1);
			}
			rs.close();

			String sqlList = "SELECT pnumber, name, phone, major, course, coursecnt from professor order by pnumber ASC";
			rs = stmt.executeQuery(sqlList);
	%>



	<div class="info">
		<table id="pro_tb">
			<tr>
				<th>교수번호</th>
				<th>이름</th>
				<th>연락처</th>
				<th>전공</th>
				<th>강의</th>
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
				<td colspan="3">등록된 교수가 없습니다.</td>
			</tr>
			<%
				} else { // total이 0이 아닌 즉 자료가 1개이상 있다면

						while (rs.next()) { // while이라는 반복문으로 자료를 찾습니다. rs.next()는 다음라인으

							int pnumber = rs.getInt(1); // 1은 첫번째 즉 num값을 idx라는 변수에 대입
							String name = rs.getString(2); // name

							String phone = rs.getString(3); // title
							String major = rs.getString(4); // title
							String course = rs.getString(5); // title
							int coursecnt = rs.getInt(6);
			%>
			<tr>
				<td><%=pnumber%></td>
				<td><%=name%></td>
				<td><%=phone%></td>
				<td><%=major%></td>
				<%

								if (coursecnt >= 1) {
									String sqlcourse1 = "SELECT coursename FROM course where pnumber like " + pnumber;
									Statement stmt2 = conn.createStatement();
									ResultSet resultset = stmt2.executeQuery(sqlcourse1);
				%><td>
					<%
						while (resultset.next()) {
					%> <span><%=resultset.getString(1)%></span> <%
 	}
 %>
				</td>

				<%
					} else {
				%>
				<td><%=course%></td>
			</tr>
			<%
				}
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