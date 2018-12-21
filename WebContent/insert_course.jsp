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
		String coursename;
		int credit, pnumber;
		coursename = request.getParameter("coursename");
		credit = Integer.parseInt(request.getParameter("credit"));
		pnumber = Integer.parseInt(request.getParameter("pnumber"));

		ResultSet rs, rset = null;
		String sql, sqlpro, sqlpro1, sqlpro2, sqlpro3;
		Connection con = null;
		Statement stmt = null;
		int coursecnt=-3;

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
		sqlpro = "select coursecnt from professor where pnumber =" + pnumber;
		rset = stmt.executeQuery(sqlpro);
		if (rset.next()) {
			coursecnt = rset.getInt(1);

		}
		rset.close();
		coursecnt++;
		sqlpro1 = "update professor set coursecnt="+ coursecnt + " where pnumber ="+pnumber;

		stmt.executeUpdate(sqlpro1);
		
		sqlpro2 = "select name from professor where pnumber = " + pnumber;

		rset = stmt.executeQuery(sqlpro2);
		String pname="";
		if (rset.next()) {
			pname = rset.getString("name");
		}

		
		sql = "insert into course" + "(coursename, credit, pnumber, pname) " + "values (" + "'" + coursename + "', '" + credit + "', "+ " '" + pnumber + "', '"
				+ pname + "')";

		try {
			stmt.executeUpdate(sql);

	%>
	<script language=javascript>
		self.window.alert("등록이 완료되었습니다.");
		location.href = "register_course.jsp";
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