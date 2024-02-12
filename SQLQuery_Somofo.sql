--Hello, here is my solution of the given task. 
--I wasn't sure of one thing during reading task describtion if the 'distinct pairs' should be applied before joining tables A and B or after.
--In the first solution (which is my preffered option if I have to choose only one, better option :)) I assumed that after joining, and in the second (which is commented below) before.

WITH
A_temp AS (
    SELECT A.d1, M.d2_correct as d2, A.m1
    FROM [somofo].[dbo].[A] A
    INNER JOIN (SELECT DISTINCT d1, d2_correct FROM MAP) M ON A.d1 = M.d1
),
B_temp AS (
    SELECT B.d1, M.d2_correct AS d2, B.m2
    FROM [somofo].[dbo].[B] B
    INNER JOIN (SELECT DISTINCT d1, d2_correct FROM MAP) M ON B.d1 = M.d1
)
SELECT COALESCE(A.d1, B.d1) AS d1,
       COALESCE(A.d2, B.d2) AS d2,
       ISNULL(SUM(A.m1), 0) AS sum_m1,
       ISNULL(SUM(B.m2), 0) AS sum_m2
FROM A_temp as A
FULL OUTER JOIN B_temp as B ON A.d1 = B.d1 AND A.d2 = B.d2
GROUP BY COALESCE(A.d1, B.d1), COALESCE(A.d2, B.d2);

/*
WITH
A_temp AS (
    SELECT A.d1, M.d2_correct as d2, sum(A.m1) as m1
    FROM [somofo].[dbo].[A] A
    INNER JOIN (SELECT DISTINCT d1, d2_correct FROM MAP) M ON A.d1 = M.d1
GROUP BY A.d1, M.d2_correct
),
B_temp AS (
    SELECT B.d1, M.d2_correct AS d2, B.m2
    FROM [somofo].[dbo].[B] B
    INNER JOIN (SELECT DISTINCT d1, d2_correct FROM MAP) M ON B.d1 = M.d1
)
SELECT COALESCE(A.d1, B.d1) AS d1,
       COALESCE(A.d2, B.d2) AS d2,
       ISNULL(SUM(A.m1), 0) AS sum_m1,
       ISNULL(SUM(B.m2), 0) AS sum_m2
FROM A_temp as A
FULL OUTER JOIN B_temp as B ON A.d1 = B.d1 AND A.d2 = B.d2
GROUP BY COALESCE(A.d1, B.d1), COALESCE(A.d2, B.d2);
*/