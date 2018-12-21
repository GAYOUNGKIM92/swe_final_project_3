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
		int cnumber = Integer.parseInt(request.getParameter("cnumber"));
		int pnumber = Integer.parseInt(request.getParameter("pnumber"));
		
		try {

			Connection conn = DriverManager.getConnection(url, id1, pass);
			Statement stmt = conn.createStatement();

			
			String sqlpro = "select coursecnt from professor where pnumber =" + pnumber;
			ResultSet rset = stmt.executeQuery(sqlpro);
			int coursecnt = 0;
			if (rset.next()) {
				coursecnt = rset.getInt(1);
				System.out.println("강의수"+coursecnt);
			}
			rset.close();
			coursecnt--;
			String sqlpro1 = "update professor set coursecnt="+ coursecnt + " where pnumber ="+pnumber;
			System.out.println(sqlpro1);
			stmt.executeUpdate(sqlpro1);
			String sql = "delete from course where cnumber=" + cnumber;
			stmt.executeUpdate(sql);
			
			
	%>
	<script language=javascript>
		self.window.alert("삭제가 완료되었습니다.");
		location.href = "inquiry_course.jsp";
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