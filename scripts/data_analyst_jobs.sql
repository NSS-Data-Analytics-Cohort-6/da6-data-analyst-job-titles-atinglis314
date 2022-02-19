--VIEW ALL DATA SHORTCUT (I know there are other ways to do this... this is just-in-case)
SELECT *
FROM data_analyst_jobs;

--Question 1
--How many rows are in the data_analyst_jobs table?
SELECT count(*)
FROM data_analyst_jobs;
--Answer: 1793

--Question 2
--Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
--Answer: ExxonMobil

--Question 3
--How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT count(*)
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT count(*)
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';
--Answer: 21 in Tennessee alone, 27 in Kentucky or Tennessee
--Note from code walk through: could have done WHERE location IN (TN, KY)

--Question 4
--How many postings in Tennessee have a star rating above 4?
SELECT count(*)
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4;
--Answer: 3

--Question 5
--How many postings in the dataset have a review count between 500 and 1000?
SELECT count(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--Answer: 151

--Question 6
--Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
SELECT location, round(avg(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT null
GROUP BY location
ORDER BY avg_rating DESC;
--Answer: Nebraska has the highest average rating, averaging at 4.20

--Question 7
--Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT DISTINCT title
FROM data_analyst_jobs;

SELECT count(DISTINCT title)
FROM data_analyst_jobs;
--Answer: 881

--Question 8
--How many unique job titles are there for California companies?
SELECT count(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA';
--Answer: 230
--Note from code walkthrough: updated query to include count function, rather than looking at "number of rows" after query runs

--Question 9
--Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT company, avg(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT null
GROUP BY company;
--Answer: 40 (41 if you don't exclude null)
--Note from code walkthrough: there are several ways to get the count AND the names/avg data, probably the best way is either two queries or a subquery in the SELECT clause

--Question 10
--Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company, round(avg(star_rating),2) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT null
GROUP BY company
ORDER BY avg_rating DESC;
--Answer: Unilever is at the top of the list, but Unilever, General Motors, Nike, American Express, Microsoft, and Kaiser Permanente appear to be tied

--Question 11
--Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT count(title)
FROM data_analyst_jobs
WHERE lower(title) LIKE '%analyst%';

SELECT count(distinct title)
FROM data_analyst_jobs
WHERE lower(title) LIKE '%analyst%';

SELECT count(distinct lower(title))
FROM data_analyst_jobs
WHERE lower(title) LIKE '%analyst%';
--Answer: 1669 postings, 774 unique titles
--Note from code walkthrough: iLIKE is LIKE but not case-sensitive, HOWEVER it runs slowly because it does more transformations. Also, ROB put the lower in the SELECT statement, which deduplicated Data Analyst and data analyst before they were counted (answer is 770 in this scenario). Probably slightly more correct

--Question 12
--How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT DISTINCT title
FROM data_analyst_jobs
WHERE LOWER(title) NOT LIKE '%analyst%' AND lower(title) NOT LIKE '%analytics%';
--Answer: 4, they all contain the word "Tableau"

--BONUS
--You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.  |  Disregard any postings where the domain is NULL.  |  Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
SELECT domain, count(title) AS hard_to_fill
FROM data_analyst_jobs
WHERE skill LIKE '%SQL%' AND days_since_posting > 21 AND domain IS NOT null
GROUP BY domain
ORDER BY hard_to_fill DESC;
--Answer: Internet and Software (62 jobs), Banks and Financial Services (61 jobs), Consulting and Business Services (57 jobs), Health Care (52 jobs)
