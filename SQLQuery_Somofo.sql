--Hello, here is my solution of the given task. 

WITH
A_temp AS (
    SELECT A.dimension_1, M.correct_dimension_2 as dimension_2, A.measure_1
    FROM [A] A
    INNER JOIN (SELECT DISTINCT dimension_1, correct_dimension_2 FROM MAP) M ON A.dimension_1 = M.dimension_1
),
B_temp AS (
    SELECT B.dimension_1, M.correct_dimension_2 AS dimension_2, B.measure_2
    FROM [B] B
    INNER JOIN (SELECT DISTINCT dimension_1, correct_dimension_2 FROM MAP) M ON B.dimension_1 = M.dimension_1
)
SELECT COALESCE(A.dimension_1, B.dimension_1) AS dimension_1,
       COALESCE(A.dimension_2, B.dimension_2) AS dimension_2,
       ISNULL(SUM(A.measure_1), 0) AS measure_1,
       ISNULL(SUM(B.measure_2), 0) AS measure_2
FROM A_temp as A
FULL OUTER JOIN B_temp as B ON A.dimension_1 = B.dimension_1 AND A.dimension_2 = B.dimension_2
GROUP BY COALESCE(A.dimension_1, B.dimension_1), COALESCE(A.dimension_2, B.dimension_2);