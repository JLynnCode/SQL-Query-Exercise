-- INSERT INTO [table] (column1, column2, ...) VALUES (row1c1, row1c2, row1c3, ...), (row2c1, row2c2, row2c3,...), (...)
INSERT INTO location_table (city, state_column, country)
	 VALUES ('Nashville', 'Tennessee', 'United States'),
			('Memphis', 'Tennessee', 'United States'),
			('Phoenix', 'Arizona', 'United States'),
			('Denver', 'Colorado', 'United States');

--------------------------------------------------------------------

INSERT INTO person ("firstName", "lastName", age, location_id)
	 VALUES ('Chickie', 'Ourtic', 21, 1),
	 		('Hilton', 'O`Hanley', 37, 1),
			('Barbe', 'Purver', 50, 3),
			('Reeta', 'Sammons', 34, 2),
			('Abbott', 'Fisbburne', 49, 1),
			('Winnie', 'Whines', 19, 4),
			('Samantha', 'Leese', 35, 2),
			('Edoudard', 'Lorimer', 29, 1),
			('Mattheus', 'Shaplin', 27, 3),
			('Donnell', 'Corney', 25, 3),
			('Wallis', 'Kauschke', 28, 3),
			('Melva', 'Lanham', 20, 2),
			('Amelina', 'McNirlan', 22, 4),
			('Courtney', 'Holley', 22, 1),
			('Sigismond', 'Vala', 21, 4),
			('Jacquelynn', 'Halfacre', 24, 2),
			('Alanna', 'Spino', 25, 3),
			('Isa', 'Slight', 32, 1),
			('Kakalina', 'Renne', 26, 3);
			
---------------------------------------------------------------------

INSERT INTO interest (title) 
	 VALUES ('Programming'), ('Gaming'), ('Computers'),
	 		('Music'), ('Movies'), ('Cooking'), ('Sports');
			
---------------------------------------------------------------------

INSERT INTO person_interest(person_id, interest_id)
	 VALUES (1, 1), (1, 2), (1, 6), (2, 1), (2, 7), (2, 4),
	 		(3, 1), (3, 3), (3, 4), (4, 1), (4, 2), (4, 7),
			(5, 6), (5, 3), (5, 4), (6, 2), (6, 7), (7, 1),
			(7, 3), (8, 2), (8, 4), (9, 5), (9, 6), (10, 7),
			(10, 5), (11, 1), (11, 2), (11, 5), (12, 1), (12, 4),
			(12, 5), (13, 2), (13, 3), (13, 7), (14, 2), (14, 4),
			(14, 6), (15, 1), (15, 5), (15, 7), (16, 2), (16, 3),
			(16, 4), (17, 1), (17, 3), (17, 5), (17, 7), (18, 2),
			(18, 4), (18, 6), (19, 1), (19, 2), (19, 3), (19, 4),
			(19, 5), (19, 6), (19, 7)

---------------------------------------------------------------------
--UPDATE [table] SET [column] = [new value] WHERE [condition]
UPDATE person SET age = age + 1 WHERE id = 2
								   OR id = 7
								   OR id = 9
								   OR id = 15
								   OR id = 13
								   OR id = 19
								   OR id = 6
								   OR id = 5;

---------------------------------------------------------------------
--DELETE FROM [table] WHERE [condition]
DELETE FROM person WHERE id = 3 OR id = 18;
DELETE FROM person_interest WHERE person_id = 3 OR person_id = 18;

---------------------------------------------------------------------
--SELECT [column] FROM [table] WHERE [condition]
SELECT "firstName", "lastName" FROM person;

--Names of people who live in Nashville, TN
SELECT "firstName", "lastName", location_table.city, location_table.state_column
	 FROM person
	 JOIN location_table ON person.location_id = location_table.id
	 WHERE location_table.id = 1
	 
--Counts of how many people live in each of the four cities	 
SELECT location_table.city, COUNT(location_id) 
	 FROM location_table, person
	 WHERE location_table.id = location_id
	 GROUP BY location_table.city;
	 
--Counts of how many people are interested in each of the 7 interests
SELECT title, COUNT(person_interest.interest_id)
	 FROM interest, person_interest
	 WHERE id = person_interest.interest_id
	 GROUP BY interest.title;
	 
--Also wrote it with a JOIN while helping a classmate troubleshoot their query
--So here's an extra, as a treat
SELECT title, COUNT(person_interest.interest_id) 
	 FROM interest 
	 JOIN person_interest ON person_interest.interest_id = interest.id
	 GROUP BY title
	 
--Names of people who live in Nashville, TN with an interest in Programming
SELECT "firstName", "lastName", location_table.city,
		location_table.state_column, interest.title
	 FROM person
	 JOIN location_table 
	 	ON person.location_id = location_table.id
	 	AND location_table.id = 1
	 JOIN person_interest 
	 	ON person.id = person_interest.person_id
	 	AND person_interest.interest_id = 1
	 JOIN interest 
	 	ON person_interest.interest_id = interest.id
	 	AND interest.id = 1

-----------------------******BONUS ROUND*****-----------------------
--Counting the number of people in age ranges: 20-30, 30-40, 40-50
--Struggled to find some examples of using CASE along with GROUP BY
--in PostgreSQL, but this was my best effort :) 
SELECT
	 SUM (CASE WHEN age >= 20 AND age < 31
		  	   THEN 1
		  	   	 END) AS "20-30",
	 SUM (CASE WHEN age >= 30 AND age < 41
		 	   THEN 1
		 	     END) AS "30-40",
	 SUM (CASE WHEN age >= 40 AND age < 51
		  	   THEN 1
		  		 END) as "40-50"
FROM person

---------------------------------------------------------------------
--Test & Check Express, displaying data since 1970
SELECT location_id, interest_id, person."firstName", person_id FROM person_interest JOIN person ON person.id = person_id