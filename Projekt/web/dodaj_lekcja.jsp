<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dodaj lekcje</title>
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
        <sql:query dataSource="${Polaczenie}" var="cos">
        SELECT * from przedmioty;
        </sql:query>
        
        <form method="post">
            <label>Przedmiot: </label>
            <select name="przedmiot" required>
                <option selected disabled>Przedmiot</option>>
                <c:forEach var="wiersz" items="${cos.rows}">
                    <option value="${wiersz.ID_przedmioty}">${wiersz.Nazwa}</option>
                 </c:forEach>
            </select><br><br>
            
            <label>Numer lekcji: </label>
            <input type="number" name="nr_lekcji" required><br><br>
            
            <label>Temat lekcji: </label>
            <input type="text" placeholder="Temat" name="temat" required><br><br>
            
            <label>Data: </label>
            <input type="date" placeholder="YYYY-MM-DD" name="data_zaj" required><br><br>
            
            <button type="submit">Dodaj</button>
        </form>
        
        <c:if test="${pageContext.request.method=='POST'}">
            <c:catch var="exception">
            
        
            <sql:update dataSource="${Polaczenie}" var="cos">
                INSERT into lekcje (ID_przedmiotu, nr_lekcji, Temat, Data_zajec) values (?, ?, ?, ?)
                <sql:param value="${param.przedmiot}" />
                <sql:param value="${param.nr_lekcji}" />
                <sql:param value="${param.temat}" />
                <sql:param value="${param.data_zaj}" />
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
