<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<html>

<head>
<title>강의관리</title>
<link rel="stylesheet" type="text/css" href="css/inquiry_professor.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
</head>

<body>

	<div class="info">
		<h2>강의조회</h2>
		<form method="post" id="inq_c_form">
			<fieldset>
				<p id="direction">강의이름을 입력해주시기 바랍니다.</p>
				<p id="number">강의이름</p>
				<input class="textbox" type="text" name="coursename" required
					autocomplete="off" id="cname"><br> 
					<input type="button"
					class="submit" value="조회하기" onclick="name_reg();"><br>
			</fieldset>
		</form>
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
			String coursename = request.getParameter("coursename");
			ResultSet rset, resultset = null;
			String sqlStr;
			Connection conn = null;
			Statement stmt = null;
			int total = 0;
			int num = 0;

			if (coursename != null) {
		%>
		<%
			Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul",
						"root", "8798qwer!!");
				stmt = conn.createStatement();

				String sqlCount = "SELECT COUNT(*) FROM course where coursename like ";
				sqlCount += "'" + coursename + "'";
				
				
				ResultSet rs = stmt.executeQuery(sqlCount);

				if (rs.next()) {
					total = rs.getInt(1);
				}
				rs.close();

				sqlStr = "select * from course where coursename like ";
				sqlStr += "'" + coursename + "'";

				rset = stmt.executeQuery(sqlStr);
		%>


		<div class="info" id="display">
			<table>
				<tr>
					<th>학수번호</th>
					<th>강의명</th>
					<th>학점</th>
					<th>강의실번호</th>
					<th>교수</th>
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
					<td colspan="6">해당되는 이름의 강의가 존재하지 않습니다.</td>
				</tr>
				<%
					} else {
							if (rset.next()) {
								int cnumber = rset.getInt("cnumber");
				%>
				<tr>
					<td><%=rset.getInt("cnumber")%></td>
					<td><%=rset.getString("coursename")%></td>
					<td><%=rset.getInt("credit")%></td>
					<td><%=rset.getString("roomnumber")%></td>
					<%
						int pnumber = rset.getInt("pnumber");
						String sqlpro = "select name from professor where pnumber = " + pnumber;
									resultset = stmt.executeQuery(sqlpro);
									String name = "";
									while (resultset.next()) {
										name = resultset.getString("name");
									}
					%>
					<td><%=name%></td>
					<td><input type="button" class="bnt" value="수정"
						OnClick="window.location='modify_course.jsp?cnumber=<%=cnumber%>&name=<%=name%>'">
						<input type="button" class="bnt" value="삭제"
						OnClick="confirm_delete(<%=cnumber%>,<%=pnumber%>)"></td>
				</tr>
				<%
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
		</div>
		<form class="info" action="see_all_course.jsp">
			<input class="submit" id="all" type="submit" value="전체조회">
		</form>
			<script>
		function confirm_delete(cnumber,pnumber) {
			var r = confirm("삭제하시겠습니까?");
			if (r == true) {
				window.location='delete_course.jsp?cnumber='+cnumber+'&pnumber='+pnumber;
			} else {
				window.location = 'inquiry_course.jsp';
			}

		}
	</script>
	</div>
	
</body>

</html>