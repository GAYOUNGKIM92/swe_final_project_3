<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>강의등록</title>
<link rel="stylesheet" type="text/css" href="css/register_pro.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
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
	%>

	<div class="info">
		<h2>강의등록</h2>
		<form action="insert_course.jsp" method="post">
			<fieldset>
				<p id="direction">등록하고자 하는 강의의 정보를 입력해주세요.</p>
				<br>
				<table>
					<tr>
						<td>강의명</td>
						<td><input class="textbox" type="text" name="coursename" size="30"
							required autocomplete="off"></td>
					</tr>
					<tr>
						<td>학점</td>
						<td><input class="textbox" type="text" name="credit"
							size="30"></td>
					</tr>
					<tr>
						<td>교수</td>
						<td><select name="pnumber">
								<%
									try {
										Class.forName("com.mysql.cj.jdbc.Driver");
										conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul",
												"root", "8798qwer!!");
										stmt = conn.createStatement();

										String sql = "SELECT pnumber, name, coursecnt FROM professor";
										ResultSet rs = stmt.executeQuery(sql);
										int pnumber, coursecnt;
										String name;

										while (rs.next()) {
											coursecnt = rs.getInt(3);
											if (coursecnt < 2) { //수업이 2개 이하인 교수만 선택한다.
												pnumber = rs.getInt(1);
												name = rs.getString(2);
								%>
								<option value="<%=pnumber%>"><%=name%></option>
								<%
									}
										}
										rs.close();
										stmt.close();
										conn.close();
									} catch (SQLException e) {
										out.println(e.toString());
									}
								%>
						</select></td>
					</tr>
				</table>
				<input class="submit" type="submit" value="등록">
			</fieldset>
		</form>
	</div>
</body>
</html>