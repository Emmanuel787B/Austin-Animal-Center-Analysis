/* Questions To Be Answered
1.Between dogs and cat intakes, what does the shelter take in more?
2.What is the most popular dog breed to be taken in?
3.Percentages of different outcomes for dogs and cats 
4.Are black cats adopted less than other colors?
*/

--Creating Income Table--

CREATE TABLE Austin_Animal_Center_Intakes_Cleaned (
	animal_id text,
	date date, 
	intake_type text,
	intake_condition text, 
	animal_type text, 
	sex_upon_intake text, 
	age_upon_intake text,
	breed text, 
	color text
	);

--Inserting Data--

COPY Austin_Animal_Center_Intakes_Cleaned
FROM 'C:\mydirectory\Austin_Animal_Center_Intakes_Cleaned.csv'
WITH (FORMAT CSV, HEADER)

--Creating Outcome Table-- 

CREATE TABLE Austin_Animal_Center_Outcomes_Cleaned (
	animal_id text,
	date date, 
	date_of_birth date, 
	outcome_type text, 
	outcome_subtype text,
	animal_type text,
	sex_upon_outcome text,
	age_upon_outcome text,
	breed text,
	color text
	);

--Inserting Data--

COPY Austin_Animal_Center_Outcomes_Cleaned
FROM 'C:\mydirectory\Austin_Animal_Center_Outcomes_Cleaned.csv'
WITH (FORMAT CSV, HEADER)

--Checking Tables-- 

SELECT *
FROM Austin_Animal_Center_Intakes_Cleaned;

SELECT *
FROM Austin_Animal_Center_Outcomes_Cleaned;

--1. Between dogs and cat intakes, what does the shelter take in more?--

SELECT animal_type, COUNT(animal_type) AS intakes
FROM Austin_Animal_Center_Intakes_Cleaned
WHERE animal_type = 'Dog' OR animal_type = 'Cat'
GROUP BY animal_type
ORDER BY 2 DESC; 

/* The shelter takes in more dogs with 79304 intakes, comapred to 53743 cats. */

--2.What are the top 5 popular dog breeds to be taken in?--

SELECT animal_type, breed, COUNT(breed) AS Intakes
FROM Austin_Animal_Center_Intakes_Cleaned
WHERE animal_type = 'Dog'
GROUP BY animal_type, breed
ORDER BY 3 DESC
LIMIT 5

/* Pit Bulls lead with 13565 intakes, followed by Labradors, Chihuahuas, German Sheperds, and Australian Cattle Dogs respectively. */

--3.Percentages of different outcomes for dogs and cats?-- 

SELECT animal_type, outcome_type, CAST(COUNT(outcome_type) as numeric(10,2))/53652 * 100 AS Percentage
FROM Austin_Animal_Center_Outcomes_Cleaned
WHERE animal_type = 'Cat' AND outcome_type IS NOT NULL
GROUP BY animal_type, outcome_type
ORDER BY 3 DESC


SELECT animal_type, outcome_type, CAST(COUNT(outcome_type) as numeric(10,2))/53652 * 100 AS Percentage
FROM Austin_Animal_Center_Outcomes_Cleaned
WHERE animal_type = 'Dog' AND outcome_type IS NOT NULL
GROUP BY animal_type, outcome_type
ORDER BY 3 DESC

/* Dogs have higher percentage rates in adoption, with 70.85% dogs being adopted compared to 47.82% with cats. Cats have
a higher percentages in euthanizations, transfers, deaths, and disposals. */

--4. Are black cats adopted less than other colors?-- 

SELECT animal_type, outcome_type, color, COUNT(outcome_type) AS Percentage
FROM Austin_Animal_Center_Outcomes_Cleaned
WHERE animal_type = 'Cat' AND outcome_type IS NOT NULL AND outcome_type = 'Adoption'
GROUP BY animal_type, outcome_type, color 
ORDER BY 4 DESC
LIMIT 5

/* Although black cats are often seen as bad luck, black cats are the 2nd most popular color adopted from the animal center. */








