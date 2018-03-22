<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modyfikuj przedmiot</title>
        <link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'>
        <link href='style.css' rel='stylesheet' type='text/css'>
    </head>
    <body>
<div class="box">
  <div class="box box--right">
    <div class="box__title">ZARZĄDZAJ</div>
    <div class="box__description">
              <ul id="menu_glowne">
            <li></li>
            <li><a href="index.jsp">Srona domowa</a></li>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="uczniowie.jsp">Lista uczniów</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="dodaj_uczniowie.jsp">Dodaj uczniów</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="przedmioty.jsp">Przedmioty</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="dodaj_przedmiot.jsp">Dodaj przedmioty</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="oceny.jsp">Oceny</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="dodaj_oceny.jsp">Dodaj oceny</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="lekcje.jsp">Lekcje</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="dodaj_lekcja.jsp">Dodaj lekcję</a></li></c:if>
            <c:if test="${empty sessionScope['loginUser']}"><li><a href="logowanie.jsp">Logowanie</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="wyloguj.jsp">Wyloguj</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="#">Użytkownik: <b><c:out value="${sessionScope['loginUser']}" /></b></a></li></c:if>
            <li></li>
        </ul> 
    </div>
  </div>
</div>
        
        <c:set var="ktory" value="${param.edytuj_ktory}" />
        
        <sql:setDataSource var="Polaczenie" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/dziennik?zeroDateTimeBehavior=convertToNull" user="root"  password=""/>
        
        <sql:query dataSource="${Polaczenie}" var="wynik">
        SELECT * from przedmioty where ID_przedmioty='${ktory}'
        </sql:query>
        
        <form method="post" action="modyfikuj_przedmiot_2.jsp">
            <label>Nazwa przedmiotu</label>
            <c:forEach var="wiersz" items="${wynik.rows}">
            <input type="text" name="nazwa" value="${wiersz.Nazwa}" required>
            <input type="hidden" name="edytuj_ktory" value="${wiersz.ID_przedmioty}" /><br><br>
            </c:forEach>
            <button type="submit">Modyfikuj</button>
        </form>
        
        
        
    </body>
</html>
