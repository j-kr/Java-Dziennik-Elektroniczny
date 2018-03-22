-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 22 Sty 2018, 15:23
-- Wersja serwera: 10.1.28-MariaDB
-- Wersja PHP: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `dziennik`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `lekcje`
--

CREATE TABLE `lekcje` (
  `ID_lekcje` int(11) NOT NULL,
  `ID_przedmiotu` int(11) NOT NULL,
  `nr_lekcji` int(11) NOT NULL,
  `Temat` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `Data_zajec` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Zrzut danych tabeli `lekcje`
--

INSERT INTO `lekcje` (`ID_lekcje`, `ID_przedmiotu`, `nr_lekcji`, `Temat`, `Data_zajec`) VALUES
(1, 2, 1, 'Arytmetyka - podstawy', '2017-09-01'),
(2, 1, 1, 'Wprowadzenie', '2017-09-02'),
(3, 4, 1, 'Fotosynteza', '2017-09-06'),
(4, 1, 2, 'Matura', '2017-12-12'),
(5, 1, 12, 'Matura', '2011-10-10');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `obecnosci`
--

CREATE TABLE `obecnosci` (
  `ID_uczniowie` int(11) NOT NULL,
  `ID_lekcji` int(11) NOT NULL,
  `obecnosc` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Zrzut danych tabeli `obecnosci`
--

INSERT INTO `obecnosci` (`ID_uczniowie`, `ID_lekcji`, `obecnosc`) VALUES
(1, 2, 'obecny'),
(2, 2, 'obecny'),
(3, 2, 'obecny'),
(5, 2, 'obecny'),
(1, 5, 'obecny'),
(3, 5, 'obecny'),
(5, 5, 'obecny'),
(8, 5, 'obecny');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `oceny`
--

CREATE TABLE `oceny` (
  `ID_oceny` int(11) NOT NULL,
  `ID_uczniowie` int(11) NOT NULL,
  `ocena` int(11) NOT NULL,
  `opis` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `ID_przedmioty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Zrzut danych tabeli `oceny`
--

INSERT INTO `oceny` (`ID_oceny`, `ID_uczniowie`, `ocena`, `opis`, `ID_przedmioty`) VALUES
(2, 1, 5, 'Rozprawka', 1),
(3, 2, 4, 'Sprawdzian - Geometria', 2),
(4, 3, 5, 'recytacja', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `przedmioty`
--

CREATE TABLE `przedmioty` (
  `ID_przedmioty` int(11) NOT NULL,
  `Nazwa` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Zrzut danych tabeli `przedmioty`
--

INSERT INTO `przedmioty` (`ID_przedmioty`, `Nazwa`) VALUES
(1, 'Jezyk polski'),
(2, 'Matematyka');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uczniowie`
--

CREATE TABLE `uczniowie` (
  `ID_uczniowie` int(11) NOT NULL,
  `imie` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `nazwisko` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `data_urodzenia` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Zrzut danych tabeli `uczniowie`
--

INSERT INTO `uczniowie` (`ID_uczniowie`, `imie`, `nazwisko`, `data_urodzenia`) VALUES
(1, 'Kazimierz', 'Brzoza', '1995-11-30'),
(3, 'Adrianna', 'Nowaczyk', '1995-02-14'),
(5, 'Weronika', 'Jaskółka', '1995-06-01'),
(8, 'Jan', 'Kowalski', '2000-10-11');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `ID_uzytkownicy` int(11) NOT NULL,
  `imie` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `nazwisko` varchar(50) COLLATE utf8_unicode_520_ci NOT NULL,
  `login` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `password` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `tozsamosc` varchar(20) COLLATE utf8_unicode_520_ci NOT NULL,
  `numer_ucznia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_520_ci;

--
-- Zrzut danych tabeli `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`ID_uzytkownicy`, `imie`, `nazwisko`, `login`, `password`, `tozsamosc`, `numer_ucznia`) VALUES
(1, '', '', 'Nauczyciel_Pl', '12345', 'Nauczyciel', 101);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `lekcje`
--
ALTER TABLE `lekcje`
  ADD PRIMARY KEY (`ID_lekcje`);

--
-- Indexes for table `oceny`
--
ALTER TABLE `oceny`
  ADD PRIMARY KEY (`ID_oceny`),
  ADD KEY `ID_oceny` (`ID_oceny`),
  ADD KEY `ID_oceny_2` (`ID_oceny`);

--
-- Indexes for table `przedmioty`
--
ALTER TABLE `przedmioty`
  ADD PRIMARY KEY (`ID_przedmioty`);

--
-- Indexes for table `uczniowie`
--
ALTER TABLE `uczniowie`
  ADD PRIMARY KEY (`ID_uczniowie`);

--
-- Indexes for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`ID_uzytkownicy`),
  ADD UNIQUE KEY `login` (`login`),
  ADD UNIQUE KEY `numer_ucznia` (`numer_ucznia`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `lekcje`
--
ALTER TABLE `lekcje`
  MODIFY `ID_lekcje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `oceny`
--
ALTER TABLE `oceny`
  MODIFY `ID_oceny` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `przedmioty`
--
ALTER TABLE `przedmioty`
  MODIFY `ID_przedmioty` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `uczniowie`
--
ALTER TABLE `uczniowie`
  MODIFY `ID_uczniowie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `ID_uzytkownicy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
