<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>강의수정</title>
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
		int cnumber = Integer.parseInt(request.getParameter("cnumber"));
		String name = request.getParameter("name");
		String coursename = "";
		int credit = 0;
		String roomnumber = "";
		int pnumber = 0;
		Statement stmt = null;
		try {

			Connection conn = DriverManager.getConnection(url, id1, pass);
			stmt = conn.createStatement();

			String sql = "SELECT cnumber, coursename, credit, roomnumber, pnumber FROM course WHERE cnumber="
					+ cnumber;
			ResultSet rs = stmt.executeQuery(sql);

			if (rs.next()) {
				coursename = rs.getString(2);
				credit = rs.getInt(3);
				roomnumber = rs.getString(4);
				pnumber = rs.getInt(5);
			}
			rs.close();
			conn.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>

	<div class="info">
		<h2>강의수정</h2>
		<fieldset>
			<p id="direction">수정하고자 하는 정보를 재입력해주시기 바랍니다.</p>
			<form name=modifyform method=post
				action="modify_ok_course.jsp?cnumber=<%=cnumber%>" id='form'>
				<table>
					<tr>
						<th>학수번호</th>
						<th>강의명</th>
						<th>학점</th>
						<th>강의실번호</th>
						<th>교수</th>

					</tr>
					<tr>
						<td><%=pnumber%><input type=hidden value="<%=cnumber%>"></td>
						<td><input type=text name="coursename"
							value="<%=coursename%>" id="name"></td>
						<td><input type=text name="credit" value="<%=credit%>" id="credit"></td>
						<td><%=roomnumber%><input type=hidden name="roomnumber"
							value="<%=roomnumber%>"></td>
						<td><%=name%><input type=hidden name="pnumber"
							value="<%=pnumber%>"></td>
					</tr>
				</table>
				<input class="submit" type="button" value="수정" onclick="check();"> <input
					class="submit" type="button" value="취소"
					OnClick="javascript:history.back(-1)">
			</form>
		</fieldset>
	</div>
	      		<script>
    		function check(){
    			var name = document.getElementById("name");
    			var credit = document.getElementById("credit");

    			var chk_credit = /^[0-9]{1}$/;
    			
    			
    			 if (name.value == "" || credit.value =="") {
    	             alert("필수항목을 입력하세요.");          
    	         } else if (!chk_credit.test(credit.value)) {
    	             alert("학점을 형식에 맞게 입력해주세요.(숫자만 가능)");
    	             return false;
    	         } else {
    				confirm_mod();
    	         }
    		}
			
			function confirm_mod(){
				  var form = document.getElementById("form");
				  var r = confirm("수정하시겠습니까?");
				  if (r == true) {
				    form.submit();
				  } else {
					location.href = "inquiry_course.jsp";
				  }

			}
		</script>
</body>

</html>