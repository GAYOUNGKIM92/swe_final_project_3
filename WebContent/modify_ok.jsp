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
		int pnumber = Integer.parseInt(request.getParameter("pnumber"));
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String major = request.getParameter("major");
		System.out.println(name+","+major);

		try {
			
			Connection conn = DriverManager.getConnection(url, id1, pass);
			Statement stmt = conn.createStatement();

			String sql = "UPDATE professor SET name='" + name + "' ,phone='" + phone +"' ,major='" + major + "' WHERE pnumber=" + pnumber;

			stmt.executeUpdate(sql);
	%>
	<script language=javascript>
		self.window.alert("수정되었습니다.");
		location.href = "inquiry_professor.jsp";
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