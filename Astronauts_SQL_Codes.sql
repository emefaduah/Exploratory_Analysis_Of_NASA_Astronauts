/*
Astronauts are people trained to pilot a spacecraft,travel in spacecraft or work in space.
There is no doubt that being an astronauts comes with lots of advantadges. One of the main avantadges of being 
an astronaut is the fact that you get to fly in space and see the stars  plus they are one of the highest paid profesionals in the world however 
it comes with some disadvantadges.Being in spaceship for too long can harm your bones and blood of astronauts, and can affect thier mental health.In addition, they are
susceptible to increased level of dangerous radiation. Would you like to be an astronaut? What does it take to be one?

This project aim is to explore Astronauts data sourced from Kaggle (NASA astronauts, 1959-2020) and make some insights to encourage people whose dream job 
is to be an astronaut. If you are consdering becoming an Astronaut, based on my findings I can make recommenations on major decisions to take to increase  your chances.

Some questions I want to find out is 
1) The life expectancy of an astronaut? The life expectancy of female and male astronauts?
2) Do we have almost equal number of female and male astronauts?
3) What educational background does most astronaut have? What is the level of education of most astronaut?
4) The top 5 Undergraduate Universities astronauts attended?
5) The top Countries/States austronauts come from?
6) What is the average number of space flight and space walk of astronauts?
7) What is the average hours of space flight and space walk of astronauts?
*/

/* Using project database*/
USE project;

/* Select all coloumns in the table austronauts*/
SELECT * FROM  astronauts;

/* Total Number of astronauts*/
SELECT  COUNT(*) AS Total_Number_Of_Astronauts
FROM astronauts;

/* Status of the astronaut*/
SELECT Status, COUNT(*) AS Number
FROM astronauts
GROUP BY Status;

/*  Military Branch of the astronaut*/
SELECT Military_Branch, COUNT(*) AS Number
FROM astronauts
GROUP BY Military_Branch;

/*  Top 5 Rank of the astronaut*/
SELECT Military_Rank, COUNT(*) AS Number
FROM astronauts
GROUP BY Military_Rank
ORDER BY Number DESC
LIMIT 5;

/* Gender of the astronaut*/
SELECT Gender, COUNT(*) AS Number
FROM astronauts
GROUP BY Gender;

/*What is the Average life Expectancy of Astronaut*/
SELECT ROUND(AVG(life_Expectancy),0) AS Average_Life_Expectancy
FROM(
SELECT 
	CASE 
		WHEN Status = 'Deceased' THEN Substring_index(Death_Date,'/',-1) - Substring_index(Birth_Date,'/',-1) 
		WHEN Status != 'Deceased' THEN  2020 - Substring_index(Birth_Date,'/',-1) 
    END AS life_Expectancy
 FROM astronauts  
 ) AS Life_Expect;

/*What is the Average life Expectancy of a Female Astronaut*/
SELECT ROUND(AVG(Female_life_Expectancy),0) AS Female_Average_Life_Expectancy
FROM(
SELECT 
	CASE 
		WHEN Status = 'Deceased' AND Gender ='Female' THEN Substring_index(Death_Date,'/',-1) - Substring_index(Birth_Date,'/',-1) 
		WHEN Status != 'Deceased' AND Gender ='Female' THEN  2020 - Substring_index(Birth_Date,'/',-1) 
    END AS Female_life_Expectancy
 FROM astronauts  
 ) AS Life_Expect;


/*What is the Average life Expectancy of a Male Astronaut*/
SELECT ROUND(AVG(Male_life_Expectancy),0) AS Female_Average_Life_Expectancy
FROM(
SELECT 
	CASE 
		WHEN Status = 'Deceased' AND Gender ='Male' THEN Substring_index(Death_Date,'/',-1) - Substring_index(Birth_Date,'/',-1) 
		WHEN Status != 'Deceased' AND Gender ='Male' THEN  2020 - Substring_index(Birth_Date,'/',-1) 
    END AS Male_life_Expectancy
 FROM astronauts  
 ) AS Life_Expect;

/* What Educational background does most Astronuat have*/
SELECT Graduate_Major, COUNT(Graduate_Major) AS Number
FROM astronauts
GROUP BY Graduate_Major
ORDER BY Number DESC 
LIMIT 10;

SELECT Undergraduate_Major, COUNT(Undergraduate_Major) AS Number
FROM astronauts
GROUP BY Undergraduate_Major
ORDER BY Number DESC
LIMIT 10 ;

/*What is the level of education of most astronaut*/
SELECT COUNT(*) AS Number_of_Astronauts,
COUNT(Undergraduate_Major) AS Astronauts_with_Undergraduate_Degrees,
COUNT(Graduate_Major)AS Astronauts_with_Graduate_Degrees
FROM astronauts;

/* TOP 5  undergraduate Universities astronuats attended*/
SELECT  Substring_index(Alma_Mater,';',1) AS UnderGrad_University, Count(*) AS Number
FROM  astronauts
GROUP BY UnderGrad_University
ORDER BY Number DESC
LIMIT 5;

/* TOP Countries/States austronauts come from*/
SELECT  Substring_index(Birth_Place,',',-1) AS CITY, Count(*) AS Number
FROM  astronauts
GROUP BY CITY
ORDER BY Number DESC
LIMIT 5;

/*Average number of space flight and space Walks*/
SELECT ROUND(AVG(Space_Flights),2) AS Average_Number_Of_Space_Flight , ROUND(AVG(Space_Walks),2) AS Average_Number_Of_Space_Walks
FROM astronauts;

/*Average hours of space flight and space Walks*/
SELECT ROUND(AVG(Space_Flight_hr),0) AS Average_Hours_Of_Space_Flight , ROUND(AVG(Space_Walks_hr),0) AS Average_Hours_Of_Space_Walks
FROM astronauts;

