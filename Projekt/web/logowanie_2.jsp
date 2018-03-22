<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logowanie2</title>
        <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
    </head>
    <body>
        <c:if test="${ empty param.login or empty param.pass}">
            <c:redirect url="logowanie.jsp" >
              <c:param name="errMsg" value="Please Enter UserName and Password" />
            </c:redirect>
       </c:if>
        
       <c:if test="${not empty param.login and not empty param.pass}">
        <sql:setDataSource var="Polaczenie" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/dziennik?zeroDateTimeBehavior=convertToNull" user="root"  password=""/>
        
        
        
        <sql:query dataSource="${Polaczenie}" var="wynik">
            SELECT count(*) as user from uzytkownicy where login='${param.login}' and password='${param.pass}'
        </sql:query>
            
        <sql:query dataSource="${Polaczenie}" var="wynik2">
            SELECT tozsamosc,numer_ucznia from uzytkownicy where login='${param.login}' and password='${param.pass}'
        </sql:query>
            
            <c:forEach items="${wynik2.rows}" var="toz">
                <c:set scope="session" var="tozsamosc" value="${toz.tozsamosc}"/>
                <c:set scope="session" var="numer" value="${toz.numer_ucznia}"/>
            </c:forEach>
            
        <c:forEach items="${wynik.rows}" var="r">
        <c:choose>
          <c:when test="${r.user gt 0}">
            <c:set scope="session" var="loginUser" value="${param.login}"/>
            <c:redirect url="index.jsp"/>
          </c:when>
          <c:otherwise>
            <c:redirect url="logowanie.jsp" >
              <c:param name="errMsg" value="Login bądź hasło nie jest poprawne." />
            </c:redirect>
          </c:otherwise>
        </c:choose>
 
      </c:forEach>
 
    </c:if>
        
    </body>
</html>