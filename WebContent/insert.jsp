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
		String name, major, phone;
		name = request.getParameter("name");
		phone = request.getParameter("phone");
		major = request.getParameter("major");

		ResultSet rs = null;
		String sql;
		Connection con = null;
		Statement stmt = null;

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

		sql = "insert into professor" + "(name, phone, major) " + "values (" + "'" + name + "', '"+ phone + "', '" + major + "')";
		try {
			stmt.executeUpdate(sql);
			%>
			<script language=javascript>
				self.window.alert("등록이 완료되었습니다.");
				location.href="register_professor.jsp";
			</script>
			<% 
		} catch (Exception e) {
			out.println("데이터베이스 삽입 연산이 실패하였습니다.<hr>");
			out.println(e.getMessage());
			e.printStackTrace();
		}
	%>

</body>
</html>