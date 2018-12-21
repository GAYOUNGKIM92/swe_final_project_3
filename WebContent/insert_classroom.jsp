<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

</head>
<body>
	<%
		String roomnumber;
		int capacity = 0;
		roomnumber = request.getParameter("roomnumber");
		capacity = Integer.parseInt(request.getParameter("capacity"));

		ResultSet rs = null;
		ResultSet rset = null;
		String sql, sqlCount;
		Connection con = null;
		Statement stmt = null;
		int total = -1;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3307/dmanagement";
			con = DriverManager.getConnection(url, "root", "8798qwer!!");
		} catch (Exception e) {
			out.println("데이터베이스 접속에 문제가 있습니다.<hr>");
			out.println(e.getMessage());
			e.printStackTrace();
		}
		
		stmt = con.createStatement();
		sqlCount = "SELECT COUNT(*) FROM classroom where roomnumber like " ;
		sqlCount += "'" + roomnumber + "'";
		
		rset = stmt.executeQuery(sqlCount);
		if (rset.next()) {
			total = rset.getInt(1);
		}
		
		
		rset.close();
		if (total == 0) {

			sql = "insert into classroom" + "(roomnumber, capacity) " + "values (" + "'" + roomnumber + "', "
					+ capacity + ")";
			try {
				stmt.executeUpdate(sql);
	%>
	<script language=javascript>
		self.window.alert("등록이 완료되었습니다.");
		location.href = "register_classroom.jsp";
	</script>
	<%
		} catch (Exception e) {
				out.println("데이터베이스 삽입 연산이 실패하였습니다.<hr>");
				out.println(e.getMessage());
				e.printStackTrace();
			}
		} else {
	%>
	<script language=javascript>
		self.window.alert("같은 이름의 강의실이 이미 존재합니다.");
		location.href = "register_classroom.jsp";
	</script>
	<%
		}
	%>

</body>
</html>