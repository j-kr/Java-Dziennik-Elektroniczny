<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Obecnosci 2</title>
    </head>
    <body>
        <c:if test="${pageContext.request.method=='POST'}">
            
            <sql:setDataSource var="Polaczenie2" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/dziennik?zeroDateTimeBehavior=convertToNull" user="root"  password=""/>

            <sql:query dataSource="${Polaczenie2}" var="uczniowie">
            SELECT * from uczniowie;
            </sql:query>
            
            
            
            <c:catch var="exception">
          
            <c:forEach var="wiersz" items="${uczniowie.rows}">
            <sql:update dataSource="${Polaczenie2}" var="cos">
                INSERT into obecnosci (ID_uczniowie, ID_lekcji, obecnosc) values (?, ?, ?);
                <sql:param value="${wiersz.ID_uczniowie}" />
                <sql:param value="${param.ktora_lekcja}" />
                <sql:param value="${param.obecnosc}" />
            </sql:update>
            </c:forEach>
                
            <c:if test="${cos>=1}">
                <c:out value="Dodanie do bazy udane!" /><br>
                <a href="index.jsp">Wróć</a>
            </c:if>
            </c:catch>
            <c:if test="${exception!=null}">
            <c:out value="${exception}" />
            </c:if>
            
        </c:if>
    </body>
</html>
