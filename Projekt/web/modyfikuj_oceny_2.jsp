<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modyfikuj oceny</title>
    </head>
    <body>
        
        <c:set var="ktory" value="${param.edytuj_ktory}" />
        
        <c:if test="${pageContext.request.method=='POST'}">
            <c:catch var="exception">
            
            <sql:setDataSource var="Polaczenie" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/dziennik?zeroDateTimeBehavior=convertToNull" user="root"  password=""/>
        
            <sql:update dataSource="${Polaczenie}" var="cos">
                UPDATE oceny SET ocena=?, opis=? WHERE ID_oceny='${ktory}'
                <sql:param value="${param.ocena}" />
                <sql:param value="${param.opis}" />
            </sql:update>
            </c:catch>
            <c:if test="${exception!=null}">
            <c:out value="Dodanie do bazy nie jest możliwe." />
            </c:if>
        </c:if>
        Zedytowano pomyślnie !
        <button href="oceny.jsp">Wróć</button>
        <meta http-equiv="refresh" content="0; url=oceny.jsp" />
    </body>
</html>
