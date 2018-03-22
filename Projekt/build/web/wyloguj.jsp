<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
    </head>
    <body>
        <%
            session.removeAttribute("loginUser");
        %>
        <p> Wylogowano.</p>
        <meta http-equiv="refresh" content="0; url=index.jsp" />
    </body>
</html>
