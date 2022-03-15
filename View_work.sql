--View_work.sql

/*
  뷰(view): 실제 물리적인 테이블을 보여주는 기능
  -용도: 물리적인 테이블의 서로 접근 권한 설정
*/

--1.기본 테이블(물리적 테이블)생성
CREATE TABLE dept_copy
as
SELECT * FROM dept;

CREATE TABLE emp_copy
AS
SELECT * FROM emp;

--2.뷰(VIEW) 생성: 서브쿼리 이용
CREATE VIEW emp_view30 --30번 부서 전용
AS
SELECT empno,ename,deptno
FROM emp
WHERE deptno=30;
/*
  물리 테이블: EMP
  가상 테이블: EMP_VIEW30
  
  scott사용자: view 생성 권한
  SQL> conn system/1234
  SQL> grant create view to scott;
*/

--뷰 확인: SELECT절 이용
SELECT * FROM emp_view30; --내용 확인
DESC emp_view30; --구조 확인

--3.뷰의 데이터사전 뷰:USER_XXXX
SELECT * FROM USER_VIEWS;

--4.뷰 삭제
DROP VIEW emp_view30;

--5.뷰 사용 목적
/*
  1.복잡한 SQL문 사용시
  2.보안목적: 접근권한에 따른 정보 제공
*/

--1)복잡한 SQL문 사용시
CREATE OR REPLACE VIEW join_view -- 수정 가능 뷰 생성
AS
  (SELECT s.name,s.deptno1,p.profno
  FROM student s, professor p
  WHERE s.profno = p.profno and s.deptno1 = 101)
WITH READ ONLY; --읽기전용 뷰

SELECT * FROM join_view;

--2)보안 목적: 접근권한에 따른 정보 제공

--[1]영업사원 제공 뷰
CREATE OR REPLACE VIEW sales_view
AS
(SELECT empno,ename,comm FROM emp
WHERE job = 'SALESMAN')
WITH READ ONLY; --읽기 전용 뷰(INSERT,UPDATE,DELETE 차단)

--뷰 내용 확인
SELECT * FROM sales_view;
--WHERE절
SELECT * FROM sales_view WHERE comm>0;

DELETE FROM sales_view WHERE empno = 7499; --오류: 삭제 불가

--[2]일반사원 제공 뷰
CREATE OR REPLACE VIEW check_view
AS
(SELECT empno,ename,hiredate,deptno FROM emp
WHERE job = 'CLERK')
WITH READ ONLY;

SELECT * FROM check_view;

SELECT * FROM USER_VIEWS;

--6.뷰 생성에 사용되는 다양한 옵션
CREATE OR REPLACE VIEW view_chk30
AS
SELECT empno,ename,sal,comm,deptno
FROM emp_copy
WHERE deptno=30 WITH CHECK OPTION; --조건에 사용되는 칼럼값 수정 방지

SELECT * FROM view_chk30;

--뷰->물리적 테이블 수정
UPDATE view_chk30 SET deptno=20 WHERE sal>=1500; --오류

--7.뷰에서 의사칼럼(ROWNUM)이용: 급여수령자 TOP3

--1)가장 많은 급여 수령자 순으로 뷰
CREATE OR REPLACE VIEW desc_sal_view
AS
SELECT empno,ename,sal,hiredate
FROM emp
ORDER BY sal DESC
WITH READ ONLY;

--2)급여 수령자 TOP3
SELECT * FROM desc_sal_view
WHERE ROWNUM <= 3;


