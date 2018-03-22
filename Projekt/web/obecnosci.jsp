<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Obecność</title>
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
        
        <c:set var="wybrana_lekcja" value="${param.ktora_lekcja}"></c:set>
        
        <sql:setDataSource var="Polaczenie" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/dziennik?zeroDateTimeBehavior=convertToNull" user="root"  password=""/>
        
        
        
        <sql:query dataSource="${Polaczenie}" var="uczniowie">
        SELECT concat(imie, ' ', nazwisko) as uczen, ID_uczniowie from uczniowie;
        </sql:query>
        
        <sql:query dataSource="${Polaczenie}" var="lista_obec">
        SELECT * from obecnosci WHERE ID_lekcji=${wybrana_lekcja};
        </sql:query>
        
        <sql:query dataSource="${Polaczenie}" var="lista_uczniow_obecnych">
        SELECT * from uczniowie JOIN obecnosci ON uczniowie.ID_uczniowie=obecnosci.ID_uczniowie WHERE ID_lekcji=${wybrana_lekcja} ORDER BY nazwisko ASC
        </sql:query>    
        
        
        
        
        <c:forEach var="wiersz1" items="${lista_obec.rows}">
            <c:if test="${wiersz1.ID_lekcji == wybrana_lekcja}">
                <c:set var="czy_jest_lekcja" value="${wiersz1.ID_lekcji}"/>
            </c:if>  
        </c:forEach>
        
        
        
        <c:choose>
            <c:when test="${czy_jest_lekcja == wybrana_lekcja}">
                <p>Obecność na tej lekcji została już sprawdzona!</p><br><br>
            <c:forEach var="wiersz2" items="${lista_uczniow_obecnych.rows}">
                <c:out value="${wiersz2.imie} ${wiersz2.nazwisko} :"></c:out>
                <c:out value="${wiersz2.obecnosc}"></c:out><br><br>
            </c:forEach>
                
            </c:when>
            
            <c:otherwise>
            <form method="post" action="obecnosci_2.jsp" name="form_obecnosci">
            <c:forEach var="wiersz" items="${uczniowie.rows}">
            <c:out value="${wiersz.uczen}"/>
            
            <select name="obecnosc">
                                <option value="obecny" selected>obecny</option>
                                <option value="nieobecny">nieobecny</option>
                                <option value="spoznienie">spóźnienie</option>
            </select><br><br>
            </c:forEach>
            <input type="hidden" name="ktora_lekcja" value="${wybrana_lekcja}"/>
            <input type="submit" name="zatwierdz_obec" value="Zatwierdź"/><br><br>
            </form>
            
        </c:otherwise>
        </c:choose>
        
        
        
            
    </body>
</html>
