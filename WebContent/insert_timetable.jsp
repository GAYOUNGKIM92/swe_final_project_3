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
		String url;
		url = request.getParameter("url");
		ResultSet rs = null;
		String sql;
		Connection con = null;
		Statement stmt = null;
		String course_room = request.getParameter("course_room");
		String cr[] = course_room.split(",");
		for(int i =0; i<cr.length; i++){
			System.out.println(cr[i]);
		}

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String URL = "jdbc:mysql://localhost:3307/dmanagement";
			con = DriverManager.getConnection(URL, "root", "8798qwer!!");
		} catch (Exception e) {
			out.println("데이터베이스 접속에 문제가 있습니다.<hr>");
			out.println(e.getMessage());
			e.printStackTrace();
		}
		
		stmt = con.createStatement();
		
		String sqldelete = "delete from timetable";
		stmt.executeUpdate(sqldelete);
		
		sql = "insert into timetable" + "(url) " + "values (" + "'" + url + "'" + ")";
		try {
			stmt.executeUpdate(sql);
			for(int i=0; i<cr.length/2; i=i+2){
				String cnumber = cr[i];
				String roomnumber = cr[i+1];
				String sql1 = "UPDATE course SET roomnumber='" + roomnumber + "' WHERE cnumber = " + cnumber;
				stmt.executeUpdate(sql1);
			}
	%>
	<script language=javascript>
		self.window.alert("등록이 완료되었습니다.");
		location.href = "createtimetale.jsp";
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