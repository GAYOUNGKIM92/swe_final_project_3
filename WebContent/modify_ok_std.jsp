<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>수정완료</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul";
		String id1 = "root";
		String pass = "8798qwer!!";
		int snumber = Integer.parseInt(request.getParameter("snumber"));
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");


		try {
			
			Connection conn = DriverManager.getConnection(url, id1, pass);
			Statement stmt = conn.createStatement();

			String sql = "UPDATE student SET name='" + name + "' ,phone='" + phone + "' WHERE snumber=" + snumber;

			stmt.executeUpdate(sql);
	%>
	<script language=javascript>
		self.window.alert("수정되었습니다.");
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
</html>