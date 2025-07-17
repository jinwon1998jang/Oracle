/*
    날짜: 20205/07/17
    이름: 장진원
    내용: 5장 데이터베이스 객체
*/

--워크북 p13
--실습하기 3-1. 데이터 사전 조회(system 접속)
-- 전체 사전 조회
SELECT * FROM DICTIONARY;
--테이블 조회(현재 사용자 기준)
SELECT TABLE_NAME FROM USER_TABLES;
--전체 테이블 조회(현재 사용자 기준)
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;
--전체 테이블 조회(system 관리자만 가능)
SELECT * FROM DBA_TABLES;
--전체 사용자 조회(system 관리자만 가능)
SELECT * FROM DBA_USERS;

select instance_name, status, database_status, host_name from v$instance;

/*
2) 인덱스(Index)
- 인덱스는 데이터 검색 성능 향상을 위해 테이블 특정 컬럼에 설정하는 객체
- 테이블 특정 컬럼에 설정한 데이터의 주소, 즉 데이터의 위치 정보를 목록 형태로 만들어 놓은 구조체
- 인덱스 사용이 반드시 성능 향상으로 이어지기보다는 데이터 종류와 SQL 등 많은 요소를 고려한 설계가 필요
☞ 실습하기 3-2. 인덱스 조회
*/

-- 현재 사용자 인덱스 조회
SELECT * FROM USER_INDEXES;

--현재 사용자 인덱스 정보 조회
SELECT * FROM USER_IND_COLUMNS; 

--☞ 실습하기 3-3. 인덱스 생성
CREATE INDEX IDX_USER1_ID ON USER1(user_ID);
SELECT * FROM USER_IND_COLUMNS; 

--☞ 실습하기 3-4. 인덱스 삭제
DROP INDEX IDX_USER1_ID;
SELECT * FROM USER_IND_COLUMNS;

/*
3) 뷰(View)
- 뷰는 하나 이상의 테이블을 조회하는 SELECT문을 저장한 가상 테이블 객체
- 뷰는 테이블의 특정 컬럼의 노출을 피하거나 자주 사용하는 복잡한 SELECT문을 간편하게 사용할 목적
☞ 실습하기 3-5. 뷰 생성 권한 할당
C:\Users\chhak0503>sqlplus system/1234
다음에 접속됨:

SQL> GRANT CREATE VIEW TO 아이디;
SQL> exit */

--☞ 실습하기 3-6. 뷰 생성
CREATE VIEW VW_USER1 AS (SELECT NAME, HP, AGE FROM USER1);
CREATE VIEW VW_USER2_AGE_UNDER30 AS (SELECT * FROM USER2 WHERE AGE < 30);
CREATE VIEW VW_USER2_2_AGE_UNDER30 AS (SELECT * FROM USER2 WHERE AGE < 22);
SELECT * FROM USER_VIEWS;

--☞ 실습하기 3-7. 뷰 조회
SELECT * FROM VW_USER1;
SELECT * FROM VW_USER2_AGE_UNDER30;

--☞ 실습하기 3-8. 뷰 삭제
DROP VIEW VW_USER1;
DROP VIEW VW_USER2_AGE_UNDER30;
DROP VIEW VW_USER2_2_AGE_UNDER30;

/*
4) 시퀀스(Sequence)
- 시퀀스는 특정 규칙에 맞는 연속 숫자를 생성하는 객체
- 시퀀스로 생성되는 연속적인 번호를 식별값으로 활용하여 지속적이고 효율적인 데이터 관리
*/
--☞ 실습하기 3-9. 시퀀스 적용 테이블 생성

CREATE TABLE USER6 (
SEQ NUMBER PRIMARY KEY,
NAME VARCHAR2(20),
GENDER CHAR(1),
AGE NUMBER,
ADDR VARCHAR2(255)
); 

--☞ 실습하기 3-10. 시퀀스 생성
CREATE SEQUENCE SEQ_USER6 INCREMENT BY 1 START WITH 1; 

--☞ 실습하기 3-11. 시퀀스값 입력
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '김유신', 'M', 25, '김해시');
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '김춘추', 'M', 23, '경주시');
INSERT INTO USER6 VALUES (SEQ_USER6.NEXTVAL, '신사임당', 'F', 27, '강릉시');

/* system에서 실습
--실습하기 4-1
//오라클에서 내부 스크립트 실행이나 일반 사용자 생성을 가능하게 하기위한 세션 설정
alter session set "_ORACLE_SCRIPT"=true; 
create user test1 IDENTIFIED by 1234;

--실습하기 4-2
select *from all_users;

-- 실습하기 4-3
alter user test1 identified by 1111;

--실습하기 4-4
grant connect,resource to test1;
grant UNLIMITED tablespace to test1;

*/













