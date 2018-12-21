<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<html>

<head>
<title>교수관리</title>
<link rel="stylesheet" type="text/css" href="css/inquiry_professor.css">
<link
	href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One"
	rel="stylesheet">
</head>

<body>

	<div class="info">
		<h2>교수조회</h2>
		<form method="post" id="inq_pro_form">
			<fieldset>
				<p id="direction">교수이름을 입력해주시기 바랍니다.</p>
				<p id="number">교수이름</p>
				<input class="textbox" type="text" id="pro_name" name="name"
					required autocomplete="off"><br> <input type="button"
					class="submit" id="inq_btn" value="조회하기" onclick="name_reg();"><br>
			</fieldset>
		</form>
		<script>
			function name_reg() {
				var chk_name = /^[가-힣]+$/;
				var name = document.getElementById("pro_name");
				if (name.value == "") {
					alert("이름을 입력하세요.");
				} else if (!chk_name.test(name.value)) {
					alert("이름을 형식에 맞게 입력해주세요. (한글만 입력 가능)");
				} else {
					document.getElementById("inq_pro_form").submit();
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

				String sqlCount = "SELECT COUNT(*) FROM professor where name like";
				sqlCount += "'" + name + "'";
				ResultSet rs = stmt.executeQuery(sqlCount);

				if (rs.next()) {
					total = rs.getInt(1);

				}
				rs.close();

				sqlStr = "select * from professor where name like";
				sqlStr += "'" + name + "'";
				rset = stmt.executeQuery(sqlStr);
		%>


		<div class="info" id="display">
			<table>
				<tr>
					<th>교수번호</th>
					<th>이름</th>
					<th>연락처</th>
					<th>전공</th>
					<th>강의</th>
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
					<td colspan="6">해당되는 이름의 교수가 존재하지 않습니다.</td>
				</tr>
				<%
					} else {
							while (rset.next()) {
								int pnumber = rset.getInt("pnumber");
				%>
				<tr>
					<td><%=rset.getInt("pnumber")%></td>
					<td><%=rset.getString("name")%></td>
					<td><%=rset.getString("phone")%></td>
					<td><%=rset.getString("major")%></td>
					<%
						if (rset.getInt("coursecnt") >= 1) {
										String sqlcourse1 = "SELECT coursename FROM course where pnumber like " + pnumber;
										Statement stmt2 = conn.createStatement();
										ResultSet resultset = stmt2.executeQuery(sqlcourse1);
					%>
					<td>
						<%
							while (resultset.next()) {
						%> <span><%=resultset.getString(1)%></span> <%
 	}
 %>
					</td>

					<%
						} else {
					%>
					<td><%=rset.getString("course")%></td>
					<%
						}
									System.out.println(rset.getInt("coursecnt"));
									if (rset.getInt("coursecnt") == 0) {
					%>
					<td><input type="button" class="bnt" value="수정"
						OnClick="window.location='modify_pro.jsp?pnumber=<%=pnumber%>'">
						<input type="button" class="bnt" value="삭제"
						OnClick="confirm_delete(<%=pnumber%>)"></td>
					<%
						}
					%>
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

		<form class="info" action="see_all_pro.jsp">
			<input class="submit" id="all" type="submit" value="전체조회">
		</form>
	</div>	
	<script>
		function confirm_delete(pnumber) {
			var r = confirm("삭제하시겠습니까?");
			if (r == true) {
				window.location = 'delete_pro.jsp?pnumber='+pnumber;
			} else {
				window.location = 'inquiry_professor.jsp';
			}

		}
	</script>
</body>

</html>

