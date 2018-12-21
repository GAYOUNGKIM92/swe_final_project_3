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
		<h2>학생조회</h2>
		<form method="post" id="inq_st_form">
			<fieldset>
				<p id="direction">학생이름을 입력해주시기 바랍니다.</p>
				<p id="number">학생이름</p>
				<input class="textbox" type="text" name="name" required
					autocomplete="off" id="st_name"><br> 
					<input type="button"
					class="submit" value="조회하기" onclick="name_reg();"><br>
			</fieldset>
		</form>
	</div>
		<script>
			function name_reg() {
				var chk_name = /^[가-힣]+$/;
				var name = document.getElementById("st_name");
				if (name.value == "") {
					alert("이름을 입력하세요.");
				} else if (!chk_name.test(name.value)) {
					alert("이름을 형식에 맞게 입력해주세요. (한글만 입력 가능)");
				} else{
					document.getElementById("inq_st_form").submit();
				}
			}
		</script>
	<%
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("name");
		ResultSet rset = null;
		String sqlStr;
		Connection conn = null;
		Statement stmt = null;
		int total = 0;
		int num = 0;

		if (name != null) {
	%>
	<%
		Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul",
					"root", "8798qwer!!");
			stmt = conn.createStatement();

			String sqlCount = "SELECT COUNT(*) FROM student where name like";
			sqlCount += "'" + name + "'";
			ResultSet rs = stmt.executeQuery(sqlCount);

			if (rs.next()) {
				total = rs.getInt(1);
				System.out.println(total);
			}
			rs.close();

			sqlStr = "select * from student where name like";
			sqlStr += "'" + name + "'";
			rset = stmt.executeQuery(sqlStr);
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
				<td colspan="6">해당되는 이름의 학생이 존재하지 않습니다.</td>
			</tr>
			<%
				} else {
						while (rset.next()) {
							int snumber = rset.getInt("snumber");
			%>
			<tr>
				<td><%=rset.getInt("snumber")%></td>
				<td><%=rset.getString("name")%></td>
				<td><%=rset.getString("phone")%></td>
				<td><%=rset.getInt("semester")%></td>
				<td><%=rset.getInt("credit")%></td>
				<td><input type="button" class="bnt" value="수정"
					OnClick="window.location='modify_std.jsp?snumber=<%=snumber%>'"> <input
					type="button" class="bnt" value="삭제"
					OnClick="confirm_delete(<%=snumber%>)"></td>
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
		<form action="see_all_std.jsp">
			<input class="submit" type="submit" value="전체조회">
		</form>
	</div>
		<script>
		function confirm_delete(snumber) {
			var r = confirm("삭제하시겠습니까?");
			if (r == true) {
				window.location = 'delete_std.jsp?snumber='+snumber;
			} else {
				window.location = 'inquiry_student.jsp';
			}

		}
	</script>
</body>

</html>