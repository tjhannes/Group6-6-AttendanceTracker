<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%-- //[START imports]--%>
<%@ page import="com.example.guestbook.Student" %>
<%@ page import="com.example.guestbook.Guestbook" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%-- //[END imports]--%>

<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
</head>

<body>

<div class="main">

<%
	String[][] tutorialInfo =  {{"Mondays, 9:00 - 11:00", "01.011.018", "Someone"},
			  					{"Mondays, 13:45 - 15:15", "01.011.018", "Someone"},
			  					{"Mondays, 15:15 - 16:45", "01.011.018", "Someone"},
			  					{"Tuesdays, 15:00 - 17:00", "01.011.018", "Someone"},
			  					{"Wednesdays, 10:00 - 12:00", "00.011.038", "Someone"},
			  					{"Wednesdays, 12:00 - 14:00", "01.011.018", "Someone"}};
    
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) 
    {
        pageContext.setAttribute("user", user);
%>
		<h3>Hello ${fn:escapeXml(user.nickname)}!</h3>
		<p align="right"><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign out</a></p>
<%
        List<Student> students = ObjectifyService.ofy()
    	          .load()
    	          .type(Student.class)
    	          .list();
    	boolean isRegistered = false;
%>
	
<%
		
    	for (Student student : students) 
    	{
            if (user.getUserId().equals(student.student_id)) 
            {
            	isRegistered = true;
            	if(student.group == 0)
            	{
%>
					<p>Please register for one of the following tutor groups:</p>
					<form action="/sign" method="post">
						<select name="group">
					  		<option value="1">Group 1</option>
					  		<option value="2">Group 2</option>
					  		<option value="3">Group 3</option>
					  		<option value="4">Group 4</option>
					  		<option value="5">Group 5</option>
					  		<option value="6">Group 6</option>
						</select>
						<input type="submit" name="group">
					</form>
<%
            	}
            	else
            	{
%>
					<p>Student ID: <%= student.student_id%></p>
					<p>You are currently registered to Group <%= student.group %></p>
					<table>
						<tr><th>Time</th><th> <%= tutorialInfo[student.group-1][0] %></th></tr>
						<tr><th>Room</th><th> <%= tutorialInfo[student.group-1][1] %></th></tr>
						<tr><th>Tutor</th><th> <%= tutorialInfo[student.group-1][2] %></th></tr>
						<tr></tr>
					</table>
					
					<p>Take Attendance</p>
					<form action="/attendance/take" method="post">
						<table>
							<tr><th>Student ID</th><th><input type="text" name="student_id"></th> </tr>
							<tr><th>Group ID</th><th><input type="text" name="group_id"></th> </tr>
							<tr><th>Week ID</th><th><input type="text" name="week_id"></th> </tr>
							<tr><th></th></tr>
						</table>
						<input type="submit" name="take_attendance">
					</form>
					
					<p>Show Attendances</p>
					<form action="/attendance/list" method="get">
						<table>
							<tr>
								<th>Group ID</th>
								<th>
									<select name="show_group_id">
								  		<option value="1">Group 1</option>
								  		<option value="2">Group 2</option>
								  		<option value="3">Group 3</option>
								  		<option value="4">Group 4</option>
								  		<option value="5">Group 5</option>
								  		<option value="6">Group 6</option>
									</select>
								</th> 
							</tr>
							<tr>
								<th>Count</th>
								<th>
									<select name="show_count">
								  		<option value="0">All</option>
								  		<option value="5">5</option>
								  		<option value="10">10</option>
								  		<option value="15">15</option>
								  		<option value="25">25</option>
								  		<option value="50">50</option>
									</select>
								</th> 
							</tr>
							<tr><th></th></tr>
						</table>
						<input type="submit" name="show_attendances">
					</form>
<%
            	}
            	break;
            }
    	}
    	
    	if(!isRegistered)
    	{
%>
			<p>Please register for one of the following tutor groups:</p>
			<form action="/sign" method="post">
		  		<select name="group">
			    	<option value="1">Group 1</option>
			    	<option value="2">Group 2</option>
			    	<option value="3">Group 3</option>
			    	<option value="4">Group 4</option>
			    	<option value="5">Group 5</option>
			    	<option value="6">Group 6</option>
				</select>
		  		<input type="submit" name="group">
			</form>
<%
    	}
    } 
    else 
    {
%>

<h3>Hello!</h3>
<p>Please 
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
    to register your attendance.</p>
    
<%
    }
%>

</div>

</body>
</html>
<%-- //[END all]--%>
