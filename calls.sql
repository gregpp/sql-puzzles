/* Given two tables:

PHONES
name | number
--------------
Anna  1234
Bryan 8897
Tom   4709
Sarah 0987

CALLS
id | caller | callee | duration
-------------------------------
1   8593      1234      2
2   0987      4709      6
3   1234      0987      7
4   4709      1234      4
5   1234      0987      5


Write a SQL query which will list the names of people who held minimum 3 conversations with minimum total duration of 10, sorted descending by total duration and name ascending.
For the above input the output should be:

name
----
Anna
Sarah

*/

-- SOLUTION

WITH cte1
AS 
(
  SELECT id, caller AS number, duration
  FROM calls
  UNION ALL
  SELECT id, callee, duration
  FROM calls
),
cte2
AS
(
  SELECT number
  FROM cte1
  GROUP BY number
  HAVING SUM(duration) >=10 AND COUNT(id) >=3
)
SELECT name
FROM phones p
JOIN cte2
ON p.number = cte2.number
;
