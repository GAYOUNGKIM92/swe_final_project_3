<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul";
		String id1 = "root";
		String pass = "8798qwer!!";
		int snumber = Integer.parseInt(request.getParameter("snumber"));

		try {

			Connection conn = DriverManager.getConnection(url, id1, pass);
			Statement stmt = conn.createStatement();

			String sql = "delete from student where snumber=" + snumber;
			stmt.executeUpdate(sql);
	%>
	<script language=javascript>
		self.window.alert("삭제가 완료되었습니다.");
		location.href = "inquiry_student.jsp";
	</script>

	<%
		stmt.close();
			conn.close();
	%>

	<%
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>


</body>
