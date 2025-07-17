/*
    날짜:2025/07/17
    이름:장진원
    내용:6장 PL/SQL
*/

--실습 1-1 Hello, Oracle 출력
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, Orcle!');
END;
/
DECLARE
 NO NUMBER(4) := 1001;
 NAME VARCHAR2(10) := '홍길동';
 HP CHAR(13) := '010-1000-1001';
 ADDR VARCHAR2(100) := '부산광역시';
 
BEGIN
 --DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
 DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
 DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
 DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;
/ 
    
--☞ 실습 2-1. 변수 선언 및 변수값 출력
-- 콘솔 출력이 안될 경우 실행

SET SERVEROUTPUT ON;

DECLARE
 NO CONSTANT NUMBER(4) := 1001;
 NAME VARCHAR2(10);
 HP CHAR(13) := '000-0000-0000';
 AGE NUMBER(2) DEFAULT 1;
 ADDR VARCHAR2(10) NOT NULL := '부산';
BEGIN
 NAME := '김유신';
 HP := '010-1000-1001';
 DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
 DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
 DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
 DBMS_OUTPUT.PUT_LINE('나이 : ' || AGE);
 DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;
/


--☞ 실습 2-2. 열 참조형 변수 실습
DECLARE
 NO DEPT.DEPTNO%TYPE;
 NAME DEPT.DNAME%TYPE;
 DTEL DEPT.DTEL%TYPE;
BEGIN
 SELECT * INTO NO, NAME, DTEL
 FROM DEPT
 WHERE DEPTNO = 30;
 
 DBMS_OUTPUT.PUT_LINE('부서번호 : ' || NO);
 DBMS_OUTPUT.PUT_LINE('부서명 : ' || NAME);
 DBMS_OUTPUT.PUT_LINE('전화번호 : ' || DTEL);
END;
/

--☞ 실습 2-3. 행 참조형 변수 실습
DECLARE
 -- 선언
 ROW_DEPT DEPT%ROWTYPE;
BEGIN
 -- 처리
 SELECT *
 INTO ROW_DEPT
 FROM DEPT
 WHERE DEPTNO = 40;

 -- 출력
 DBMS_OUTPUT.PUT_LINE('부서번호 : ' || ROW_DEPT.DEPTNO);
 DBMS_OUTPUT.PUT_LINE('부서명 : ' || ROW_DEPT.DNAME);
 DBMS_OUTPUT.PUT_LINE('전화번호 : ' || ROW_DEPT.DTEL);
END;
/

--☞ 실습 2-4. 레코드 자료형 기본 실습
DECLARE
 -- Record Define
 TYPE REC_DEPT IS RECORD (
 deptno NUMBER(2),
 dname DEPT.DNAME%TYPE,
 dtel DEPT.DTEL%TYPE
 );
 -- Record Declare
 dept_rec REC_DEPT;
BEGIN
 -- Record Initialize
 dept_rec.deptno := 10;
 dept_rec.dname := '개발부';
 dept_rec.dtel := '부산';
 -- Record Print
 DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec.deptno);
 DBMS_OUTPUT.PUT_LINE('dname : ' || dept_rec.dname);
 DBMS_OUTPUT.PUT_LINE('dtel : ' || dept_rec.DTEL);
 DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;
/

--☞ 실습 2-5. 레코드 사용한 INSERT 실습
-- 테이블 복사(데이터 제외)
CREATE TABLE DEPT_RECORD AS SELECT * FROM DEPT WHERE 1 = 0;
DECLARE
 TYPE REC_DEPT IS RECORD (
 deptno NUMBER(2),
 dname DEPT.DNAME%TYPE,
 loc DEPT.LOC%TYPE
 );
 dept_rec REC_DEPT;
BEGIN
 dept_rec.deptno := 10;
 dept_rec.dname := '개발부';
 dept_rec.loc := '부산';
 INSERT INTO DEPT_RECORD VALUES dept_rec;

 DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;
/

--☞ 실습 2-6. 레코드를 포함하는 레코드 실습
DECLARE
 TYPE REC_DEPT IS RECORD (
 deptno DEPT.DEPTNO%TYPE,
 dname DEPT.DNAME%TYPE,
 loc DEPT.LOC%TYPE
 );
 TYPE REC_EMP IS RECORD (
 empno EMP.EMPNO%TYPE,
 ename EMP.ENAME%TYPE,
 dinfo REC_DEPT
 );
 emp_rec REC_EMP;
BEGIN
 SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
 INTO
 emp_rec.empno,
 emp_rec.ename,
 emp_rec.dinfo.deptno,
 emp_rec.dinfo.dname,
 emp_rec.dinfo.DTEL
 FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO AND E.EMPNO = 7788;

 DBMS_OUTPUT.PUT_LINE('EMPNO : ' || emp_rec.empno);
 DBMS_OUTPUT.PUT_LINE('ENAME : ' || emp_rec.ename);
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || emp_rec.dinfo.deptno);
 DBMS_OUTPUT.PUT_LINE('DNAME : ' || emp_rec.dinfo.dname);
 DBMS_OUTPUT.PUT_LINE('DTEL : ' || emp_rec.dinfo.DTEL);

 DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;
/

--☞ 실습 2-7. 테이블(연관배열) 기본 실습
DECLARE
 TYPE ARR_CITY IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
 arrCity ARR_CITY;
BEGIN
 arrCity(1) := '서울';
 arrCity(2) := '대전';
 arrCity(3) := '대구';

 DBMS_OUTPUT.PUT_LINE('arrCity(1) : ' || arrCity(1));
 DBMS_OUTPUT.PUT_LINE('arrCity(2) : ' || arrCity(2));
 DBMS_OUTPUT.PUT_LINE('arrCity(3) : ' || arrCity(3));
 DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
END;
/

-- 실습 4-1. 단일 행 결과를 처리하는 커서 사용
DECLARE
 -- 커서 데이터를 저장할 변수 선언
 V_DEPT_ROW DEPT%ROWTYPE;

 -- 커서 선언
 CURSOR c1 IS SELECT * FROM DEPT WHERE DEPTNO = 40;
BEGIN
 -- 커서 열기
 OPEN c1;

 -- 커서 데이터 입력
 FETCH c1 INTO V_DEPT_ROW;
 -- 커서 데이터 출력
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
 DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
 DBMS_OUTPUT.PUT_LINE('DTEL : ' || V_DEPT_ROW.DTEL);

 -- 커서 종료
 CLOSE c1;
END;
/

--☞ 실습 4-2. 여러 행 결과를 처리하는 커서 사용(LOOP)
DECLARE
 V_emp_ROW emp%ROWTYPE;
 CURSOR emp_curser IS SELECT * FROM emp;
BEGIN
 OPEN emp_curser;
 LOOP
    FETCH emp_curser INTO V_emp_ROW;
 
    EXIT WHEN emp_curser%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('------------------------------');
    DBMS_OUTPUT.PUT_LINE('empNO : ' || V_emp_ROW.EMPNO);
    DBMS_OUTPUT.PUT_LINE('NAME : ' || V_emp_ROW.NAME);
    DBMS_OUTPUT.PUT_LINE('regdate : ' || V_emp_ROW.regdate);
 END LOOP;

 CLOSE emp_curser;
END;
/

-- 실습 4-3. 여러 행 결과를 처리하는 커서 사용(FOR)
DECLARE
 CURSOR c1 IS SELECT * FROM DEPT;
BEGIN
 FOR c1_rec IN c1 LOOP
 DBMS_OUTPUT.PUT_LINE('------------------------------');
 DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO);
 DBMS_OUTPUT.PUT_LINE('DNAME : ' || c1_rec.DNAME);
 DBMS_OUTPUT.PUT_LINE('DTEL : ' || c1_rec.DTEL);
 END LOOP;
END;
/


-- 실습 5-1. 이름으로 환영 메시지 출력하는 간단한 프로시저 실습
-- 프로시저 생성
CREATE PROCEDURE hello_procedure (p_name in VARCHAR2)
IS
BEGIN
 DBMS_OUTPUT.PUT_LINE('안녕하세요, ' || p_name || '님!');
 DBMS_OUTPUT.PUT_LINE('환영합니다.');
END;
/
-- 프로시저 실행1
EXECUTE hello_procedure('홍길동');
-- 프로시저 실행2
EXECUTE hello_procedure('김철수');
-- 프로시저 삭제
DROP PROCEDURE hello_procedure;


/*2) 함수
- 함수(Function)는 값을 반환하는 저장 서브프로그램
- SELECT 문에서도 호출 가능하며, RETURN 문으로 값을 반환*/


--☞ 실습 5-2. 사원 번호를 입력받아 사원 이름을 반환하는 함수 실습
-- 함수 생성
CREATE FUNCTION get_emp_name (p_empno NUMBER)
RETURN VARCHAR2
IS
 v_ename VARCHAR2(20);
BEGIN
 SELECT NAME
 INTO v_ename
 FROM EMP
 WHERE EMPNO = p_empno;
 RETURN v_ename;
END;
/
-- 함수 실행
SELECT get_emp_name(1001) FROM EMP;
SELECT get_emp_name(1002) FROM DUAL;
drop FUNCTION get_emp_name;


/*3) 트리거
- 트리거(Trigger)는 특정 이벤트(INSERT, UPDATE, DELETE)가 발생할 때 자동으로 실행되는 프로그램
- 데이터 무결성 유지, 감사 기록 등을 위해 사용*/

--☞ 실습 5-3. 제목
-- 로그 테이블 생성
CREATE TABLE emp_log (
 log_date DATE,
 empno NUMBER,
 action VARCHAR2(10)
);
-- 트리거 생성
CREATE TRIGGER trgg_emp_insert
AFTER INSERT ON emp
FOR EACH ROW
BEGIN
 INSERT INTO emp_log (log_date, empno, action)
 VALUES (SYSDATE, :NEW.empno, 'INSERT');
END;
/
-- INSERT 테스트
INSERT INTO emp VALUES (2001, '테스트','M','사원', 10,sysdate);
-- 로그 확인
SELECT * FROM emp_log;
Drop TRIGGER trgg_emp_insert