--step02_Join2.sql

/*
  카티전 조인(Cartesian Join)
  -논리적(조건식)으로 테이블을 연결하는 방식
  
  1.Cross Join: 조건 없이 테이블 연결
  [2.Self join: 동일 테이블 조인]
  2.Inner Join: 조건 있음, 조인 대상 테이블 모두 자료가 있는 경우
  3.Outer Join: 조건 있음, 조인 대상 테이블 중 한쪽 테이블에 자료가 있는 경우
*/

--1.Cross Join
SELECT * FROM emp,dept; --모양(shape): 56(14x4) x 11(8+3)
--행: 곱, 열:덧셈

--ANSI Cross Join
SELECT * FROM emp CROSS JOIN dept;

--2.Inner Join: 조건 있음
SELECT * FROM EMP,DEPT --14x8, 4x3
WHERE EMP.DEPTNO = DEPT.DEPTNO; --조인 조건

SELECT ename, dname FROm emp,dept
WHERE emp.deptno=dept.deptno and ename='SCOTT'; --조인 조건 & 일반 조건

--칼럼의 모호성 해결: 출처 명시
SELECT ename, dname, emp.deptno FROM emp,dept
WHERE emp.deptno=dept.deptno and ename='SCOTT';

--테이블 별칭 이용
SELECT EMP.ENAME, DEPT.DNAME, EMP.DEPTNO as 부서번호
FROM EMP, DEPT --as 사용 불가
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND ENAME='SCOTT';


-- ANSI Inner Join
/*
  SELECT * FROM table1 INNER JOIN table2
  ON table1.column1 = table2.column2
*/

--ON절 조건식 표현
SELECT ENAME, DNAME, DEPTNO 
FROM EMP INNER JOIN DEPT    --조인 대상
ON EMP.DEPTNO=DEPT.DEPTNO --조인 조건
WHERE ename = 'SCOTT';   --일반 조건

--USING 이용 표현
SELECT ENAME, DNAME, DEPTNO
FROM EMP INNER JOIN DEPT
USING (DEPTNO)
WHERE ename = 'SCOTT'; 

--<문제1> 뉴욕에서 근무하는 사원의 이름과 급여를 출력하시오.(EMP, DEPT 이용)
SELECT e.ename,e.sal,d.* FROM emp e,dept d
WHERE e.deptno = d.deptno and d.loc = 'NEW YORK';

--<문제2> ACCOUNTING 부서 소속 사원의 이름, 입사일, 근무지역을 출력하시오.
SELECT e.ename,e.HIREDATE,d.LOC
FROM emp e, dept d
WHERE e.deptno = d.deptno and d.dname = 'ACCOUNTING';

--<문제3> 직급이 MANAGER인 사원의 이름, 부서명을 출력하시오.
SELECT e.ename, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno and e.job = 'MANAGER';

--<문제4> 교수번호(profno) 칼럼을 기준 조인하여 다음 그림과 같이 학생명,
--        학과, 교수명, 교수번호 칼럼을 조회하시오.
SELECT s.name 학생명, s.deptno1 학과, p.name 교수명, p.profno 교수번호
FROM student s, professor p
WHERE s.profno = p.profno;

--<문제5> <문제4>의 결과에서 101 학과만 검색되도록 하시오
SELECT s.name 학생명, s.deptno1 학과, p.name 교수명, p.profno 교수번호
FROM student s, professor p
WHERE s.profno = p.profno and s.deptno1 = 101;

--3.Outer join
/*
  조건 있음, 한쪽 테이블 자료가 있는 경우 조인
  자료 없는 테이블: +추가
  기준 테이블: +없음
  유형 Left Outer Join, Right Outer Join
*/

--Self Join: 동일 테이블 조인
SELECT e1.*, e2.*
FROM emp e1, emp e2; --196(14*14) X 16(8+8)

SELECT e1.ename 사원명, e2.ename 직속상사
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno; --조인조건

--1)Left Outer join: KING 추가
SELECT e1.ename 사원명, e2.ename 직속상사
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno(+); 


--<문제7>EMP 테이블과 DEPT 테이블을 조인하여 사원이름과 부서번호와 부서명을 출력하시오.
--      DEPT 테이블의 40번 부서와 조인할 EMP 테이블의 부서번호가 없지만,
--      아래 그림과 같이 40번 부서의 이름도 출력되도록 쿼리문을 작성해 보시오
SELECT e.ename,d.deptno,dname
FROM emp e, dept d
WHERE d.deptno = e.deptno(+) 
ORDER BY d.deptno;

--2)Right Outer Join: 오른쪽 테이블 기준
SELECT * FROM student;
SELECT * FROM professor;

SELECT s.name 학생명, p.name 교수명
FROM student s, professor p
WHERE s.profno(+) = p.profno;

--3)ANSI Left Outer Join
/*
SELECT *
FROM 테이블1 LEFT OUTER JOIN 테이블2
USING(공통칼럼);
*/

--<문제7>ANSI Left Outer Join 방식
SELECT ename,deptno,dname
FROM dept LEFT OUTER JOIN emp
using(deptno);

--4)ANSI Right Outer Join
/*
SELECT *
FROM 테이블1 RIGHT OUTER JOIN 테이블2
USING(공통칼럼);
*/

--교수가 없는 학생 출력
SELECT s.name 학생명, p.name 교수명
FROM student s RIGHT OUTER JOIN professor p
USING(profno);



