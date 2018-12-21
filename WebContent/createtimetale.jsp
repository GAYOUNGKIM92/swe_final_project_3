
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic"
	rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>시간표짜기</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="html2canvas.js"></script>
<link rel="stylesheet" href="css/createtable.css">
</head>

<body>
	<div id="download">
		<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3307/dmanagement?serverTimezone=Asia/Seoul";
			String id1 = "root";
			String pass = "8798qwer!!";
			int total1 = 0;

			try {
				Connection conn = DriverManager.getConnection(url, id1, pass);
				Statement stmt = conn.createStatement();

				String sqlCount = "SELECT COUNT(*) FROM classroom";
				ResultSet rs = stmt.executeQuery(sqlCount);

				if (rs.next()) {
					total1 = rs.getInt(1);
				}
				rs.close();

				String sqlList = "SELECT roomnumber from classroom";
				rs = stmt.executeQuery(sqlList);

				if (total1 == 0) { // total 즉, 자료가 없다면
		%>
		<h3>등록된 강의실이 없습니다.</h3>
		<%
			} else { // total이 0이 아닌 즉 자료가 1개이상 있다면
					while (rs.next()) { // while이라는 반복문으로 자료를 찾습니다. rs.next()는 다음라인으
						String roomnumber = rs.getString(1); // name
		%>

		<table border="1px solid black" class="timetable" id="<%=roomnumber%>">
			<caption><%=roomnumber%></caption>
			<tr>
				<th>시간</th>
				<th class="week">월</th>
				<th class="week">화</th>
				<th class="week">수</th>
				<th class="week">목</th>
				<th class="week">금</th>
			</tr>
			<tr>
				<td>1교시</td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
			</tr>
			<tr>
				<td>2교시</td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
			</tr>
			<tr>
				<td>3교시</td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
			</tr>
			<tr>
				<td>4교시</td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
			</tr>
			<tr>
				<td>5교시</td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
				<td class="content" ondrop="handleDrop(event)"
					ondragover="allowDrop(event)"></td>
			</tr>
		</table>

		<%
			}
				}

				int total = 0;

				String sqlCount1 = "SELECT COUNT(*) FROM course";
				rs = stmt.executeQuery(sqlCount);

				if (rs.next()) {
					total = rs.getInt(1);
				}
				rs.close();

				String sql = "SELECT coursename, pname, cnumber from course order by cnumber ASC";
				rs = stmt.executeQuery(sql);
		%>


		<%
			if (total == 0) { // total 즉, 자료가 없다면
		%>
	</div>
	<h3>등록된 강의가 없습니다.</h3>


	<%
		} else { // total이 0이 아닌 즉 자료가 1개이상 있다면
	%>
	<br><br>
	<div id="coursecontainer">
		<%
			while (rs.next()) { // while이라는 반복문으로 자료를 찾습니다. rs.next()는 다음라인으
						String coursename = rs.getString(1); // name
						String pname = rs.getString(2);
						int cnumber = rs.getInt(3);
						String course_pro = coursename + "</br>" + pname;
		%>
		<button type="button" class="coursebtn" id="<%=cnumber%>"
			draggable="true" ondragstart="handleDragStart(event)"><%=course_pro%></button>

		<%
			}
		%>
		<br><br>
		<button id="download-url" class="download-btn"
				onclick="check_course();">저장</button>
				<% 
				}
				rs.close(); //rs객체 반환
				stmt.close(); // stmt객체 반환
				conn.close(); // conn객체 반환
			} catch (SQLException e) {
				out.println(e.toString()); //에러 날경우 에러출력
			}
		%>
	</div>
	<hr>




	<script>
		function allowDrop(e) {
			e.preventDefault();
		}

		function handleDragStart(e) {
			e.dataTransfer.effectAllowed = 'move';
			e.dataTransfer.setData("Text", e.target.id); //드래그에 id를 싣는다.
		}

		function handleDrop(e) {
			e.preventDefault();
			if (e.target.childElementCount == 0) {
				var src = e.dataTransfer.getData("Text");
				e.target.appendChild(document.getElementById(src));
			} else {
				alert('하나만 올려라');
				return;
			}
		}
		
		// 이 메소드는 모든 강의를 배치하기 위한 메소드이다
        //강의들은 가지고 있는 div의 자식노드 수로 판단한다.
		function check_course(){
			var child_num = document.getElementById("coursecontainer").childElementCount;
			if(child_num > 3){
				alert("모든 강의를 배치해 주세요.")
			}else{
				savetimetable(); //모든 강의를 다 배치하였다면 저장메소드 실행한다.
			}
		}
        // 시간표 저장 메소드 canvas js를 사용하여 시간표를 이미지로 만들어
        // 그 url를 jsp파일로 넘겨주는 메소드의 매개변수로 전달해준다.
		function savetimetable(){
			html2canvas($('#download'), {
				onrendered : function(canvas) {
					var a = document.createElement('a');
					a.href = canvas.toDataURL("image/png");
					//document.getElementById('show').src=a.href;
					//$("#show").src(a.href);
					//window.location='insert_timetable.jsp?url='+"'"+a.href+"''";
					post_to_url('insert_timetable.jsp','post',a.href);
					//a.download = 'image.png';
					//a.click();
				}
			});
		}  

        //이때 url이 길수도 있으므로 보내는 값의 크기 제한이 없는 post를 통해 보낸다.
		function post_to_url(path, method, url) {
			method = method || "post"; // Set method to post by default, if not specified.
			// The rest of this code assumes you are not using a library.
			// It can be made less wordy if you use one.
			var form = document.createElement("form");
			form.setAttribute("method", method);
			form.setAttribute("action", path);
			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", 'url');
			hiddenField.setAttribute("value", url);
            var hiddenField2 = insert_classroom();
			form.appendChild(hiddenField);
			form.appendChild(hiddenField2);
			document.body.appendChild(form);
			form.submit();
		}
		
        function insert_classroom(){
        	var courses = document.getElementsByClassName("coursebtn");
        	var i;
        	var cnumber;
        	var classroom;
        	var course_room=[];
        	for(i = 0; i < courses.length; i++){
        		cnumber = courses[i].id;
        		course_room.push(cnumber);
        		classroom = ((courses[i].parentElement).parentElement).parentElement.parentElement.id;
				course_room.push(classroom);				
        	}
        	var hiddenField2 = document.createElement("input");
			hiddenField2.setAttribute("type", "hidden");
			hiddenField2.setAttribute("name", 'course_room');
			hiddenField2.setAttribute("value", course_room);
			return hiddenField2;
        }
	</script>
</body>
</html>