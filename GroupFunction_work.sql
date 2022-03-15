--GroupFunction_work.sql

/*
  그룹함수: 그룹별 통계(집계)를 구하는 함수
  -통계/집계 함수: 복수행(vector) 입력-> 상수(scala) 출력 -> 차원 축소
  -일반 숫자함수(한 개의 상수)
  -그룹 함수(여러개의 상수)
  -주의: SELECT절에서 일반 칼럼(함수)과 그룹함수와 함께 사용 불가
  -그룹 칼럼과 그룹함수는 함께 사용
*/

--1.SUM함수
SELECT SUM(SAL) FROM EMP;
SELECT SUM(COMM) FROM EMP; --NULL 제외:2200

--2.AVG함수: 대푯값(평균,중앙값,최빈값)
SELECT AVG(SAL) FROM e  mp;

--<문제1>‘SCOTT’사원이 소속된 부서의 급여 합계와 평균을 구하시오.(서브쿼리 이용)
SELECT sum(sal),avg(sal) FROM emp
WHERE deptno = (SELECT deptno FROM emp WHERE ename='SCOTT');

--MIN,MAX 함수: 범위(range)
SELECT MAX(SAL), MIN(SAL) FROM EMP;
SELECT ename, MAX(SAL), MIN(SAL) FROM EMP; --오류:일반 칼럼(함수)과 그룹함수는 함꼐 사용 불가

--<문제2>가장 최근에 입사한 사원의 입사일과 입사한지 가장 오래된 사원의 입사일
--      을 출력하는 쿼리문을 작성하시오. (MAX, MIN 함수 이용)
SELECT min(hiredate) 최근입사일 ,max(hiredate) 오래된입사일 FROM emp;

--4.COUNT함수
SELECT COUNT(COMM) FROM EMP; --4:NULL 제외
SELECT COUNT(*), COUNT(COMM) FROM EMP;
SELECT COUNT(JOB) 업무수 FROM EMP;
SELECT COUNT(DISTINCT JOB) 업무수 FROM EMP;

--<문제3>30번 부서 소속 사원중에서 커미션을 받는 사원의 수를 구하시오.
SELECT count(*) FROM emp WHERE comm >0 and deptno = 30;

--5.분산/표준편차: 산포도(평균에서 분산된 정도)

--1)보너스 분산
SELECT VARIANCE(bonus) FROM professor;

--2)보너스 표준편차
SELECT STDDEV(bonus) FROM professor;

--표준편차 = 분산의 제곱근(SQRT)
SELECT SQRT(VARIANCE(bonus)) FROM professor;
--분산 = 표준편차의 제곱
SELECT POWER(STDDEV(bonus),2) FROM professor;

/*
  모분산 = SUM((X-mu)^2)/N (mu:모평균,N:모집수)
  표본분산 = SUM(X-X')^2 / n-1 (X':표본평균,n:표본수)
*/

--1.변량의 평균
SELECT AVG(bonus) FROM professor;

--2.(변량-평균)^2
SELECT POWER(bonus-78,2) FROM professor;

--3.SUM((변량-평균)^2)
SELECT SUM(POWER(bonus-78,2)) FROM professor;

--4.모분산
SELECT SUM(POWER(bonus-78,2))/COUNT(bonus) FROM professor;

--5.표본분산
SELECT SUM(POWER(bonus-78,2))/(COUNT(bonus)-1) FROM professor;

--6.GROUP BY 절
/*
  GROUP BY 그룹 칼럼(범주형)
  -SELECT절 그룹 칼럼과 그룹 함수는 함께 사용 가능
*/

--1)그룹 칼럼은 SELECT절 사용 가능
SELECT deptno FROM emp GROUP BY deptno;

--2)그룹 칼럼과 그룹 함수 사용 가능
SELECT deptno, round(avg(sal),2) from emp
GROUP BY deptno ORDER BY deptno;

SELECT deptno, max(sal), min(sal) FROM emp
GROUP BY deptno;

--<문제4>부서별로 가장 급여를 많이 받는 사원의 정보(사원 번호, 사원이름,
--      급여, 부서번호)를 출력하시오.(IN, MAX(), GROUP BY, subQuery 이용)
SELECT empno,ename,sal,deptno FROM emp
WHERE sal IN (SELECT max(sal) FROM emp GROUP BY deptno);

--7.HAVING 조건
/*
  일반 조건절: WHERE조건식
  GROUP BY문 조건절 : HAVING 조건식
*/

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000;

SELECT DEPTNO, MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING MAX(SAL) > 2900;

--<문제5> <문제4>의 결과에서 'SCOTT' 사원을 제외하고, 급여(SAL)를 내림차순으로 정렬하시오.
SELECT empno,ename,sal,deptno FROM emp
WHERE sal IN (SELECT max(sal) FROM emp GROUP BY deptno)
AND ename !='SCOTT' ORDER BY SAL DESC;





