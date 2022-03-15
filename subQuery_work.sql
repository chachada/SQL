-- subQuery_work.sql

/*
  서브쿼리 : SELECT문에 포함된 또 하나의 SELECT문
  - 용도: 단일 쿼리문으로 작업(조회)이 불가능한 경우
  예1) 동일한 테이블: 1차 검색결과 -> 2차 작업(검색, 테이블 생성, 삽입, 수정, 삭제)
  예2) 동일한 테이블의 동일한 칼럼: '우유'와 '빵'을 동시에 구매한 고객 ID
  예3) 서로 다른 테이블 조인(JOIN): 사원 테이블 -> 부서 테이블 조회
  
  형식1) 
  main query -> 2차 실행
  AS
  sub query; -> 1차 실행
  
  형식2)
  main query 비교연산자 (sub query);
*/

-- 형식1)
CREATE TABLE dept01
AS
SELECT * FROM dept;

SELECT * FROM dept01;

-- 형식2) Main: 부서(dept), Sub: 사원(emp)
SELECT * FROM dept WHERE DEPTNO=
(SELECT deptno FROM emp WHERE ename = 'SCOTT');

--1. 단일행 서브쿼리
-- 형식)main query 비교연산자 (sub qeury);

--실습1) 1. SCOTT과 같은 부서에서 근무하는 사원의 이름과 부서 번호를 출력
--          하는 SQL 문을 작성해 보시오. (EMP)
SELECT ename,deptno FROM emp 
WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SCOTT'); -- 20

-- 단일쿼리문
SELECT ename,deptno FROM emp WHERE deptno = 20;


--실습2) 2. SCOTT와 동일한 직속상관(MGR)을 가진 사원을 출력하는 SQL 문을
--        작성해 보시오. (EMP)
SELECT * FROM emp WHERE mgr = 
(SELECT mgr FROM emp WHERE ename = 'SCOTT'); --7566

-- 단일쿼리문
SELECT * FROM emp WHERE mgr = 7566;

--실습3) 3. SCOTT의 급여와 동일하거나 더 많이 받는 사원 명과 급여를 출력하시오.(EMP)

SELECT ename,sal FROM emp
WHERE sal >= (SELECT sal FROM emp WHERE ename = 'SCOTT');

--실습4) 4. DALLAS에서 근무하는 사원의 이름, 부서 번호를 출력하시오.
--        (서브쿼리 : DEPT01, 메인쿼리 : EMP)
SELECT ename,deptno FROM EMP 
WHERE deptno = (SELECT deptno FROM dept01 WHERE loc = 'DALLAS');

--실습5) 5. SALES(영업부) 부서에서 근무하는 모든 사원의 이름과 급여를
--      출력하시오.(서브쿼리 : DEPT01, 메인쿼리 : EMP
SELECT ename,sal FROM EMP 
WHERE deptno = (SELECT deptno FROM dept01 WHERE dname = 'SALES');

--실습6) 평균 급여를 구하는 쿼리문을 서브 쿼리로 사용하여
SELECT ename,sal FROM emp
WHERE sal > (SELECT AVG(SAL) FROM emp); 
--동일한 테이블: 집계된 통계를 이용하여 조회할 경우
--주의: 통계 계싼과 조회를 동시에 할 수 없다.

SELECT ename,sal FROM emp
WHERE sal > AVG(SAL); --주의: WHERE절에서 그룹함수 사용 불가
--HAVING절에서 그룹함수 사용

--2.다중 행 서브쿼리
--형식)main query IN/ANY/ALL (sub query);

--1) IN(목록)
SELECT ename,sal,deptno fROM emp
WHERE deptno IN (SELECT DISTINCT deptno FROM emp WHERE sal >= 3000);

--실습7) 7. 직급(JOB)이 MANAGER인 사람이 속한 부서의 부서 번호와
--      부서명과 지역을 출력하시오.(DEPT01과 EMP 테이블 이용)
SELECT * FROM dept01
WHERE deptno IN (SELECT deptno FROM emp where job = 'MANAGER');

--2) ALL(AND)연산자: 최댓값 기준
SELECT ename,sal FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE deptno =30); --950 ~ 2850

--실습8) 8. 영업 사원들 보다 급여를 많이 받는 사원들의 이름과 급여와 직급
--        (담당 업무)를 출력하되 영업 사원은 출력하지 않습니다. 
SELECT ename,sal,job FROM emp
WHERE sal > ALL(SELECT sal FROM emp WHERE job = 'SALESMAN');

--3) ANY(OR)
SELECT ename,sal FROM emp
WHERE sal > ANY(SELECT sal FROM emp WHERE deptno = 30);

--실습9) 9. 영업 사원들의 최소 급여를 많이 받는 사원들의 이름과
--        급여와 직급(담당 업무)를 출력하되 영업 사원은 출력하지 않습니다.
SELECT ename,sal FROM emp 
WHERE job != 'SALESMAN' and sal > ANY(SELECT sal FROM emp WHERE job = 'SALESMAN');

