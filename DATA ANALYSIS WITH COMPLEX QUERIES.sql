SELECT *
FROM EMP;

SELECT *
FROM EMP_DEP;

-- Window Function: Rank employees by salary within department
SELECT FIRST_NAME, LAST_NAME, DEPT_ID, SALARY,
       RANK() OVER (PARTITION BY DEPT_ID ORDER BY SALARY DESC) AS Salary_Rank
FROM EMP_SAL;


-- Subquery: Employees earning above average salary
SELECT EMP_ID,FIRST_NAME, LAST_NAME, SALARY
FROM EMP_SAL
WHERE SALARY > (SELECT AVG(SALARY)
			    FROM    EMP_SAL);


-- CTE: Average salary per department
WITH DeptAvg AS (
    SELECT DEPT_ID, AVG(SALARY) AS Avg_Salary
    FROM EMP_SAL
    GROUP BY DEPT_ID
)
SELECT s.EMP_ID,s.FIRST_NAME, s.LAST_NAME,s.SALARY, d.Avg_Salary
FROM EMP_SAL s
JOIN DeptAvg d ON s.DEPT_ID = d.DEPT_ID;
