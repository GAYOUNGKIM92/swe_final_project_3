<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>교수수정</title>
    <link rel="stylesheet" type="text/css" href="css/modify_pro.css">
    <link href="https://fonts.googleapis.com/css?family=Fredericka+the+Great|Luckiest+Guy|Monoton|Sigmar+One" rel="stylesheet">
</head>

<body>

	<%
		request.setCharacterEncoding("utf-8");
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul";
		String id1 = "root";
		String pass = "8798qwer!!";
		int snumber = Integer.parseInt(request.getParameter("snumber"));
		String name = "";
		String phone ="";
		int semester = 0;
		int credit = 0;
		try {

			Connection conn = DriverManager.getConnection(url, id1, pass);
			Statement stmt = conn.createStatement();

			String sql = "SELECT snumber, name, phone, semester, credit FROM student WHERE snumber=" + snumber;
			ResultSet rs = stmt.executeQuery(sql);

			if (rs.next()) {
				name = rs.getString(2);
				phone = rs.getString(3);
				semester = rs.getInt(4);
				credit = rs.getInt(5);
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>

    <div class="info">
        <h2>학생조회</h2>
        <fieldset>
            <p id="direction">수정하고자 하는 정보를 재입력해주시기 바랍니다.</p>
            <form name=modifyform method=post action="modify_ok_std.jsp?snumber=<%=snumber%>" id="form">
                <table>
                    <tr>
                        <th>번호</th>
                        <th>이름</th>
                        <th>연락처</th>
                        <th>학기</th>
                        <th>학점</th>
                        
                    </tr>
                    <tr>
                        <td>
                            <%=snumber%><input type=hidden value="<%=snumber%>"></td>
                        <td><input type=text name="sname" value="<%=name%>" id="name"></td>
                        <td><input type=text name="phone" value="<%=phone%>" id="phone"></td>
                        <td><%=semester%><input type=hidden name="semester" value="<%=semester%>"></td>
                        <td><%=credit%><input type=hidden name="credit" value="<%=credit%>"></td>
                    </tr>

                </table>
                <input class="submit" type="button" value="수정" onclick="check()"> <input class="submit" type="button" value="취소" OnClick="javascript:history.back(-1)">
            </form>
        </fieldset>
    </div>
        		<script>
    		function check(){
    			var name = document.getElementById("name");
    			var phone = document.getElementById("phone");
    			
    			var chk_name = /^[가-힣]+$/;
    			var chk_phone = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
    			
    			
    			 if (name.value == "" || phone.value == "") {
    	             alert("필수항목을 입력하세요.");          
    	         } else if (!chk_name.test(name.value)) {
    	             alert("이름을 형식에 맞게 입력해주세요.");
    	             return false;
    	         } else if (!chk_phone.test(phone.value)) {
    	             alert("전화번호를 형식에 맞게 입력해주세요. (000-0000-0000)");
    	             return false;
    	         } else {
    				confirm_mod();
    	         }
    		}
			
			function confirm_mod(){
				  var form = document.getElementById("form");
				  var r = confirm("수정하시겠습니까?");
				  if (r == true) {
				    form.submit();
				  } else {
					location.href = "inquiry_student.jsp";
				  }

			}
		</script>
</body>

</html>