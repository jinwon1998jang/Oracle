/*
    날짜: 20205/07/17
    이름: 장진원
    내용: 5장 데이터베이스 객체
*/

--워크북 p13
--실습하기 3-1. 데이터 사전 조회(system 접속)
-- 전체 사전 조회
SELECT * FROM DICTIONARY;
//테이블 조회(현재 사용자 기준)
SELECT TABLE_NAME FROM USER_TABLES;
//전체 테이블 조회(현재 사용자 기준)
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;
//전체 테이블 조회(system 관리자만 가능)
SELECT * FROM DBA_TABLES;
//전체 사용자 조회(system 관리자만 가능)
SELECT * FROM DBA_USERS;

select instance_name, status, database_status, host_name from v$instance;

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