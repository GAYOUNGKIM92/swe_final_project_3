<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%
 Connection conn = null; 
	try{ String url = "jdbc:mysql://localhost:3307/dmanagement"; 
	String id = "root"; // 사용자계정 String 
	String pw = "8798qwer!!"; // 사용자계정의 패스워드 // 데이터베이스와 연동하기 위해 DriverManager에 등록한다. 
	Class.forName("com.mysql.jdbc.Driver"); // DriverManager 객체로부터 Connection 객체를 얻어온다. 
	conn=DriverManager.getConnection(url,id,pw); // 커넥션이 제대로 연결되면 수행된다. 
	out.println("제대로 연결되었습니다."); // 예외가 발생하면 예외 상황을 처리한다. 
	}catch(Exception e){ e.printStackTrace(); }
	%>

</body>
</html>