--Function_work.sql

/*
  함수(Function)
  -의미: 특정 기능을 정의해 놓은 것으로 필요 시 호출
  형식) 함수명([인수1,인수2,...])
*/

--1. 숫자 함수

--1) ABS 함수: 절댓값 반환
SELECT -10, ABS(-10) FROM DUAL; --DUAL: 의사 테이블

--2) FLOOR 함수: 소숫점 이하 절사
SELECT 34.5678, FLOOR(34.5678) FROM DUAL;

--3) ROUND함수: 소숫점 이하 반올림
SELECT 34.5678, ROUND(34.5678) FROM DUAL;

--ROUND(대상,자릿수):소숫점 위치
SELECT 34.5678, ROUND(34.5678,2) FROM DUAL;
--ROUND(대상,-자릿수): 정수 위치
SELECT 34.5678, ROUND(34.5678,-1) FROM DUAL;

--4) TRUNC 함수: 지정된 위치 절사
SELECT TRUNC(34.5678,2),TRUNC(34.5678,-1),TRUNC(34.5678) FROM DUAL;

--5) MOD함수: 나머지값 반환
SELECT MOD (27, 2), MOD (27, 5), MOD (27, 7) FROM DUAL;

--실습1) 사번이 홀수인 사람들을 검색해 보십시오.(EMP 테이블)
SELECT * FROM emp WHERE mod(empno,2)=1;

--6)LOG함수: 자연로그(밑수 e),상용로그(밑수 10)
--밑수 2일 떄
SELECT log(2,8) FROM DUAL;

--밑수 e일 때
SELECT EXP(1) FROM DUAL;
SELECT LOG(EXP(1),8) FROM DUAL;

--7)EXP함수
SELECT EXP(1) FROM DUAL; --e
SELECT EXP(2.07944) FROM DUAL; --8

/* 
  로그 함수 vs 지수 함수 역함수 관계
  f1(x): x->y
  f2(y): y->x
  
  로그함수: 지수값 반환, 완만한 변화(정규화)
  지수함수: 로그값 반환, 급격한(지수적)변환
*/

SELECT LOG(2,1),LOG(2,100),LOG(2,10000) FROM DUAL;
SELECT exp(1),exp(10),exp(100) FROM DUAL;

--8) POWER함수: 제곱
SELECT POWER(7,2) FROM DUAL;

--9) SQRT함수: 제곱근(루트)
SELECT SQRT(49) FROM DUAL;


--2.문자 처리 함수

--1) UPPER함수: 대문자 변경
SELECT 'Welcome to Oracle',UPPER('Welcome to Oracle') FROM DUAL;

--2) LOWER함수: 소문자 변경
SELECT 'Welcome to Oracle',LOWER('Welcome to Oracle') FROM DUAL;

--3)INITCAP함수: 첫글자 대문자 변경
SELECT 'WELCOME TO ORACLE',INITCAP('WELCOME TO ORACLE') FROM DUAL;

--실습2> 다음과 같이 쿼리문을 구성하면 직급이 'manager'인 사원을 검색할까?
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE JOB='manager'; --실패 직급 칼럼은 다 대문자이기 떄문

--4) LENGTH함수: 문자열의 길이 반환
SELECT LENGTH('Oracle'), LENGTH('오라클') FROM DUAL;

--5) LENGTHB함수: 문자열의 바이트 수 반환
SELECT LENGTHB('Oracle'), LENGTHB('오라클') FROM DUAL;

--6) SUBSTR 함수
-- SUBSTR(대상, 시작위치, 추출할 개수) 
SELECT SUBSTR('Welcome to Oracle', 4, 3) FROM DUAL;
SELECT SUBSTR('Welcome to Oracle', -4, 3) FROM DUAL;
--입사년도 -> 년도, 월 구분 : 'yy/mm/dd'
SELECT SUBSTR(hiredate,1,2)년도, SUBSTR(hiredate,4,2)달 FROM emp;

--실습3 9월에 입사한 사원을 출력하시오. (EMP 테이블)
SELECT * FROM emp WHERE substr(hiredate,4,2)='09';

--7)TRIM 함수: 앞/뒷 특정 문자 또는 공백 제거
SELECT TRIM('a' FROM 'aaaaORACLEaaaa') FROM DUAL;
SELECT TRIM(' Oracle ')FROM DUAL; --공백 제거

--8) REPLACE 함수: 문자열 교체
--REPLACE(컬럼명, '찾을문자', '변환문자
SELECT REPLACE('홍길동','홍','김')FROM DUAL;

ex)주민번호 뒷자리 마스킹(maksing):123456-*******
SELECT * FROM student;

SELECT name,REPLACE(jumin,jnum,'*******')
FROM (SELECT student*,SUBSTR(jumin,7,7) as jnum FROM student)
ORDER by name;

--3).날자 함수

--1)SYSDATE 함수
SELECT SYSDATE FROM DUAL;

SELECT SYSDATE-1 어제, SYSDATE 오늘, SYSDATE+1 내일 FROM DUAL;

--2)MONTHS_BETWEEN 함수
SELECT ename,SYSDATE,hiredate, 
ROUND(MONTHS_BETWEEN (SYSDATE,hiredate)) "근무 개월수" FROM EMP
ORDER BY "근무 개월수";


--4.형 변환 함수
/*
  TO_CHAR():날짜,숫자 -> 양식(format)을 이용하여 문자형 변환
  TO_DATE():문자,숫자 -> 양식(format)을 이용하여 날짜형 변환
  TO_NUMBER():문자 -> 양식(format)을 이용하여 숫자형 변환
*/

--1)TO_CHAR 함수
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT HIREDATE, TO_CHAR (HIREDATE, 'YYYY/MM/DD DAY') FROM EMP;

--시간 관련 양식
SELECT TO_CHAR(SYSDATE,'YYYY/MM/DD,HH24:MI:SS') FROM DUAL;

--숫자 -> 문자형 변환
SELECT ENAME,SAL,TO_CHAR(SAL,'L999,999')FROM emp;

SELECT ENAME,SAL,TO_CHAR(SAL,'L000,000')FROM emp;

--2)TO_DATE 함수
SELECT ENAME, HIREDATE FROM EMP
WHERE HIREDATE=TO_DATE(19810220,'YYYYMMDD'); --숫자->날짜형 변환

SELECT TRUNC(SYSDATE-TO_DATE('2008/01/01', 'YYYY/MM/DD'))
FROM DUAL; --문자->날짜형 변환

--3) TO_NUMBER 함수: 문자->숫자형 변환
SELECT '20,000' - '10,000' FROM DUAL; --오류;
SELECT TO_NUMBER('20,000', '99,999') - TO_NUMBER('10,000', '99,999') FROM DUAL;

--5.NULL처리 함수
/*
  NVL(대상,대체값)
  NVL2(대상,NULL(X),대체값)
*/
SELECT ename,sal*12 + NVL(comm,0) 연봉 FROM emp;

-수당이 결측치 -> 수당 평균 대체
SELECT AVG(comm) FROM emp; --550

SELECT ename,sal,NVL2(comm,comm,550)연봉 FROM emp;

--6.DECODE 함수
/*
  encode:인간어->기계어(암호)
  decode:기계어->인간어(해독)
*/
SELECT * FROM emp;

SELECT ename,job,deptno,DECODE(deptno,10,'기획실',20,'연구실','기타') FROM emp;



