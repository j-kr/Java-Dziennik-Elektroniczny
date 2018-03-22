<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dodaj ocene</title>
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
        
        <sql:setDataSource var="Polaczenie" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/dziennik?zeroDateTimeBehavior=convertToNull" user="root"  password=""/>
        <sql:query dataSource="${Polaczenie}" var="uczniowie">
        SELECT concat(imie, ' ', nazwisko) as uczen, ID_uzytkownicy FROM `uzytkownicy` WHERE tozsamosc = 'Uczen';
        </sql:query>
        
        <sql:query dataSource="${Polaczenie}" var="przedmioty">
        SELECT * from przedmioty;
        </sql:query>
        
        
        <form method="post">
            <label>Uczeń</label>
            <select name="uczen" required>
                <option selected disabled>Uczen</option>>
                <c:forEach var="wiersz" items="${uczniowie.rows}">
                    <option value="${wiersz.ID_uzytkownicy}">${wiersz.uczen}</option>
                 </c:forEach>
            </select><br><br>
            
            <label>Przedmiot</label>
            <select name="przedmiot" required>
                <option selected disabled>Przedmiot</option>>
                <c:forEach var="wiersz2" items="${przedmioty.rows}">
                    <option value="${wiersz2.ID_przedmioty}">${wiersz2.Nazwa}</option>
                 </c:forEach>
            </select><br><br>
            
            <label>Ocena</label>
            <input type="number" placeholder="Ocena" name="ocena" required><br><br>
            
            <label>Opis</label>
            <input type="text" placeholder="Opis" name="opis" required><br><br>
            
            <button type="submit">Dodaj</button>
        </form>
        
        <c:if test="${pageContext.request.method=='POST'}">
            <c:catch var="exception">
            
            <sql:setDataSource var="Polaczenie2" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/dziennik?zeroDateTimeBehavior=convertToNull" user="root"  password=""/>

                
            <sql:update dataSource="${Polaczenie2}" var="cos">
                INSERT into oceny (ID_uzytkownicy, ocena, opis, ID_przedmioty) values (?, ?, ?, ?)
                <sql:param value="${param.uczen}" />
                <sql:param value="${param.ocena}" />
                <sql:param value="${param.opis}" />
                <sql:param value="${param.przedmiot}" />
            </sql:update>
            <c:if test="${cos>=1}">
                <c:out value="Dodanie do bazy udane!" />
            </c:if>
            </c:catch>
            <c:if test="${exception!=null}">
            <c:out value="Dodanie do bazy nie jest możliwe." />
            </c:if>
        </c:if>
    </body>
</html>
