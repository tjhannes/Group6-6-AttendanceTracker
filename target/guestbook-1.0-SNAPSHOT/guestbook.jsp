<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%-- //[START imports]--%>
<%@ page import="com.example.guestbook.Greeting" %>
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
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
        pageContext.setAttribute("user", user);
%>

<h3>Hello ${fn:escapeXml(user.nickname)}!</h3>
    <p align="right"><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign out</a></p>
<%
    } else {
%>
<h3>Hello!</h3>
<p>Please 
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
    to register your attendance.</p>
<%
    }
%>



<%-- //[START datastore]--%>
<%
    // Create the correct Ancestor key
      Key<Guestbook> theBook = Key.create(Guestbook.class, guestbookName);

    // Run an ancestor query to ensure we see the most up-to-date
    // view of the Greetings belonging to the selected Guestbook.
      List<Greeting> greetings = ObjectifyService.ofy()
          .load()
          .type(Greeting.class) // We want only Greetings
          .ancestor(theBook)    // Anyone in this book
          .order("-date")       // Most recent first - date is indexed.
          .limit(5)             // Only show 5 of them.
          .list();

    if (greetings.isEmpty()) {
%>
<p>Please register for one of the following tutor groups:</p>
<form action="/guestbook.jsp" method="get">
  <select name="Group">
  <option value="group1">Group 1</option>
  <option value="group2">Group 2</option>
  <option value="group3">Group 3</option>
  <option value="group4">Group 4</option>
  <option value="group5">Group 5</option>
  <option value="group6">Group 6</option>
</select>
  <input type="submit">
</form>
<%
    } else {
%>
<p>You are currently registered to Group 6</p>
<table><tr><th>Group 6</th></tr>
<tr><th>Time</th><th>Wednesdays, 12pm - 2pm</th></tr>
<tr><th>Room</th><th>01.011.018</th></tr>
<tr><th>Tutor</th><th>Klaus</th></tr></table>

<p>Messages in Guestbook '${fn:escapeXml(guestbookName)}'.</p>
<%
      // Look at all of our greetings
        for (Greeting greeting : greetings) {
            pageContext.setAttribute("greeting_content", greeting.content);
            String author;
            if (greeting.author_email == null) {
                author = "An anonymous person";
            } else {
                author = greeting.author_email;
                String author_id = greeting.author_id;
                if (user != null && user.getUserId().equals(author_id)) {
                    author += " (You)";
                }
            }
            pageContext.setAttribute("greeting_user", author);
%>
<p><b>${fn:escapeXml(greeting_user)}</b> wrote:</p>
<blockquote>${fn:escapeXml(greeting_content)}</blockquote>
<%
        }
    }
%>







<%-- 
<form action="/sign" method="post">
    <div><textarea name="content" rows="3" cols="60"></textarea></div>
    <div><input type="submit" value="Post Greeting"/></div>
    <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
</form>
--%>
<%-- //[END datastore]--%>
<%--
<form action="/guestbook.jsp" method="get">
    <div><input type="text" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/></div>
    <div><input type="submit" value="Switch Guestbook"/></div>
</form>
--%>

</div>

</body>
</html>
<%-- //[END all]--%>
