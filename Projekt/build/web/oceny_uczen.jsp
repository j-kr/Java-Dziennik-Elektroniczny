<%@ page import = "java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Oceny</title>
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
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Uczen')}"><li><a href="oceny_uczen.jsp">Moje oceny</a></li></c:if>
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Nauczyciel')}"><li><a href="uczniowie.jsp">Lista uczniów</a></li></c:if>
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Nauczyciel')}"><li><a href="dodaj_uczniowie.jsp">Dodaj uczniów</a></li></c:if>
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Nauczyciel')}"><li><a href="przedmioty.jsp">Przedmioty</a></li></c:if>
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Nauczyciel')}"><li><a href="dodaj_przedmiot.jsp">Dodaj przedmioty</a></li></c:if>
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Nauczyciel')}"><li><a href="oceny.jsp">Oceny</a></li></c:if>
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Nauczyciel')}"><li><a href="dodaj_oceny.jsp">Dodaj oceny</a></li></c:if>
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Nauczyciel')}"><li><a href="lekcje.jsp">Lekcje</a></li></c:if>
            <c:if test="${(not empty sessionScope['loginUser']) and (sessionScope['tozsamosc'] eq 'Nauczyciel')}"><li><a href="dodaj_lekcja.jsp">Dodaj lekcję</a></li></c:if>
            <c:if test="${empty sessionScope['loginUser']}"><li><a href="logowanie.jsp">Logowanie</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="wyloguj.jsp">Wyloguj</a></li></c:if>
            <c:if test="${not empty sessionScope['loginUser']}"><li><a href="#">Użytkownik: <b><c:out value="${sessionScope['loginUser']}" /></b></a></li></c:if>
            <li></li>
        </ul> 
    </div>
  </div>
</div>
        
        
        <sql:setDataSource var="Polaczenie" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/dziennik?zeroDateTimeBehavior=convertToNull" user="root"  password=""/>      
        <sql:query dataSource="${Polaczenie}" var="wynik">
        SELECT * from przedmioty;
        </sql:query>
        
        
        <h1>Pokaż oceny dla: </h1>
        
        <form method="post">
        <select name="przedmiot">
                <option selected disabled>Przedmiot</option>>
                <c:forEach var="wiersz" items="${wynik.rows}">
                    <option value="${wiersz.Nazwa}">${wiersz.Nazwa}</option>
                 </c:forEach>
        </select>
            <button type="submit">Pokaz</button>
        </form>
        
        
        
        <c:if test="${pageContext.request.method=='POST'}">
            
            <c:set var="wybrany_przedmiot" value="${param.przedmiot}" scope="page"/>
            
            <c:choose>
            <c:when test="${param.przedmiot == wybrany_przedmiot}">
                <sql:query dataSource="${Polaczenie}" var="oceny">
                SELECT uczniowie.ID_uczniowie, nazwisko, imie, ocena ,opis, przedmioty.nazwa from oceny JOIN uczniowie ON oceny.ID_uczniowie = uczniowie.ID_uczniowie JOIN przedmioty ON oceny.ID_przedmioty = przedmioty.ID_przedmioty WHERE nazwa = ? and uczniowie.ID_uczniowie = ?;
                <sql:param value="${param.przedmiot}" />
                <sql:param value="${sessionScope['numer']}" />
                </sql:query>
                
                <table>
                    <tr>
                        <th>Nazwisko</th>
                        <th>Imie</th>
                        <th>Ocena</th>
                        <th>Opis</th>
                    </tr>
                    <c:forEach var="wiersz" items="${oceny.rows}">
                    <tr>
                        <td><c:out value="${wiersz.nazwisko}"/></td>
                        <td><c:out value="${wiersz.imie}"/></td>
                        <td><c:out value="${wiersz.ocena}"/></td>
                        <td><c:out value="${wiersz.opis}"/></td>
                    </tr>
                    </c:forEach>
            
                </table>
            </c:when>
                
                <c:otherwise>
                    Nie można wyświetlić ocen.
                </c:otherwise>
        </c:choose>
    </c:if>
         
        
    </body>
</html>