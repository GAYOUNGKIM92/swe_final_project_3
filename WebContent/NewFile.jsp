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
	String id = "root"; // ����ڰ��� String 
	String pw = "8798qwer!!"; // ����ڰ����� �н����� // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�. 
	Class.forName("com.mysql.jdbc.Driver"); // DriverManager ��ü�κ��� Connection ��ü�� ���´�. 
	conn=DriverManager.getConnection(url,id,pw); // Ŀ�ؼ��� ����� ����Ǹ� ����ȴ�. 
	out.println("����� ����Ǿ����ϴ�."); // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�. 
	}catch(Exception e){ e.printStackTrace(); }
	%>

</body>
</html>