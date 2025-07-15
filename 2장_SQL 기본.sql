/*날짜: 2025/07/12
  이름: 김철학
  내용: 2장 SQL 기본
*/

--실습 1-2. NUMBER 자료형 이해
CREATE TABLE TYPE_TEST_NUMBER(
    num1 NUMBER,
    num2 NUMBER(2),
    num3 NUMBER(3,1),
    num4 NUMBER(4,2),
    num5 NUMBER(5,6),
    num6 NUMBER(6,-1)
);
//num1 NUMBER
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (1);
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (123);
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (123.74);
INSERT INTO TYPE_TEST_NUMBER (num1) VALUES (123.12345);

//num2 NUMBER(2)
insert into TYPE_TEST_NUMBER (num2) values (12);
insert into TYPE_TEST_NUMBER (num2) values (123);
insert into TYPE_TEST_NUMBER (num2) values (1.2);
insert into TYPE_TEST_NUMBER (num2) values (1.23);
insert into TYPE_TEST_NUMBER (num2) values (12.34567);
insert into TYPE_TEST_NUMBER (num2) values (12.56789);
insert into TYPE_TEST_NUMBER (num2) values (123.56789);

//num3 NUMBER(3,1)
insert into TYPE_TEST_NUMBER (num3) values (12);
insert into TYPE_TEST_NUMBER (num3) values (123);
insert into TYPE_TEST_NUMBER (num3) values (12.1);
insert into TYPE_TEST_NUMBER (num3) values (12.1234);
insert into TYPE_TEST_NUMBER (num3) values (12.56789);
insert into TYPE_TEST_NUMBER (num3) values (123.56789);

//num4 NUMBER(4,2)
insert into TYPE_TEST_NUMBER (num4) values (12);
insert into TYPE_TEST_NUMBER (num4) values (12.11);
insert into TYPE_TEST_NUMBER (num4) values (12.123);
insert into TYPE_TEST_NUMBER (num4) values (12.1);
insert into TYPE_TEST_NUMBER (num4) values (12.22222);
insert into TYPE_TEST_NUMBER (num4) values (12.349);
insert into TYPE_TEST_NUMBER (num4) values (0.11111);

//num5 NUMBER(5,6)//잘못된 형식
insert into TYPE_TEST_NUMBER (num5) values (0.111);

//num6 NUMBER(6,-1)
insert into TYPE_TEST_NUMBER (num6) values (123456);
insert into TYPE_TEST_NUMBER (num6) values (123456.77);

//삭제
//delete from TYPE_TEST_NUMBER;

//실습하기 1-3. 문자형 자료형 이해
CREATE TABLE TYPE_TEST_CHAR (
 char1 CHAR(1),
 char2 CHAR(2),
 char3 CHAR(3),
 vchar1 VARCHAR2(1),
 vchar2 VARCHAR2(2),
 vchar3 VARCHAR2(3),
 nvchar1 NVARCHAR2(1),
 nvchar2 NVARCHAR2(2),
 nvchar3 NVARCHAR2(3)
);


//char
insert into TYPE_TEST_CHAR (char1) values ('A');
insert into TYPE_TEST_CHAR (char1) values ('가');
//VARCHAR2
insert into TYPE_TEST_CHAR (vchar1) values ('A');
insert into TYPE_TEST_CHAR (vchar2) values ('AB');
insert into TYPE_TEST_CHAR (vchar3) values ('가');
//NVARCHAR2
insert into TYPE_TEST_CHAR (nvchar1) values ('A');
insert into TYPE_TEST_CHAR (nvchar2) values ('AB');
insert into TYPE_TEST_CHAR (nvchar3) values ('가나다');

//실습하기 1-4. 테이블 생성
CREATE TABLE USER1 (
    USER_ID VARCHAR2(20),
    NAME VARCHAR2(20),
    HP CHAR(13),
    AGE NUMBER
);  
drop table user1;

//실습하기 1-5
INSERT INTO USER1 VALUES ('A101', '김유신', '010-1234-1111', 25);
INSERT INTO USER1 VALUES ('A102', '김춘추', '010-1234-2222', 23);
INSERT INTO USER1 VALUES ('A103', '장보고', '010-1234-3333', 32);
INSERT INTO USER1 (user_id, name, age) VALUES ('A104', '강감찬', 45);
INSERT INTO USER1 (user_id, name, hp) VALUES ('A105', '이순신', '010-1234-5555');


//실습하기 1-6
SELECT * FROM USER1;
SELECT * FROM USER1 WHERE USER_ID = 'A101';
select * from user1 where name='김춘추';
SELECT * FROM USER1 WHERE age > 30;
select user_id, name, age from user1;
update user1 set hp='010-1234-4444' where user_id='A104';
update user1 set age=51 where user_id='A105';

//실습하기 1-7
update user1 set 
        hp='010-1234-1001',
        age=27
        where
            user_id='A101';

//실습하기 1-8
delete from user1 where user_id='A101';
delete from user1 where user_id='A102' AND age=25;
delete from user1 where age>30;


----------------------------------------
//2.제약조건
----------------------------------------

--실습하기 2-1
CREATE TABLE USER2(
    USER_ID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    HP CHAR(13),
    AGE NUMBER(2)
);

--primary key(기본키) 컬럼은 중복 안됨
insert into user2 values('A101','김유신','010-1234-1111',23);
insert into user2 values('A102','김춘추','010-1234-2222',21);

//실습하기 2-2
create table user3 (
    user_id varchar2(20) primary key,
    name varchar2(20),
    hp char(13) UNIQUE,
    age number(2)
);
insert into user3 values('a101','김유신','010-1234-1001',23);
insert into user3 values('a102','김춘추','010-2222-1001',25);


//실습하기 2-3
CREATE TABLE PARENT(
    pid varchar2(20) primary key,
    name varchar2(20),
    hp char(13) unique
);
Create table child(
    cid varchar2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    hp char(13) unique,
    parent varchar2(20),
    foreign key (parent) references parent (pid)
);

INSERT INTO PARENT VALUES ('P101', '김서현', '010-1234-1001');
INSERT INTO PARENT VALUES ('P102', '이성계', '010-1234-1002');
INSERT INTO PARENT VALUES ('P103', '신사임당', '010-1234-1003');

INSERT INTO CHILD VALUES ('C101', '김유신', '010-1234-2001', 'P101');
INSERT INTO CHILD VALUES ('C102', '이방우', '010-1234-2002', 'P102');
INSERT INTO CHILD VALUES ('C103', '이방원', '010-1234-2003', 'P102');
INSERT INTO CHILD VALUES ('C104', '이이', '010-1234-2004', 'P103');
-- 부모 테이블에 p105에 해당하는 값이 없기 때문에 참조 무결성 제약조건 위배
INSERT INTO CHILD VALUES ('C105', '김철수', '010-1234-2005', 'P105');

--실습하기 2-4
CREATE TABLE USER4(
    name varchar2(20) not null,
    gender char(1) not null,
    age number(2) default 1,
    addr varchar2(255)
);

INSERT INTO USER4 VALUES ('김유신', 'M', 23, '김해시');
INSERT INTO USER4 VALUES ('김춘추', 'M', 21, '경주시');
INSERT INTO USER4 (NAME, GENDER, ADDR) VALUES ('신사임당', 'F', '강릉시');
INSERT INTO USER4 (NAME, GENDER) VALUES ('이순신', 'M');
INSERT INTO USER4 (NAME, AGE) VALUES ('정약용', 33);--성별은 not null(반드시 입력)이기 때문에 해당 쿼리 에러


//실습하기 2-4
CREATE TABLE USER5 (
    NAME VARCHAR2(20) not null,
    gender char(1) not null check(gender in('M','F')),
    AGE NUMBER(2) default 1 check(age>0 and age<100),
    addr VARCHAR2(255)
); 

INSERT INTO USER5 VALUES ('김유신', 'M', 23, '김해시');
INSERT INTO USER5 VALUES ('김춘추', 'M', 21, '경주시');
INSERT INTO USER5 (NAME, GENDER, ADDR) VALUES ('신사임당', 'F', '강릉시');
INSERT INTO USER5 (NAME, GENDER) VALUES ('이순신', 'M');
INSERT INTO USER5 (NAME, AGE) VALUES ('정약용', 33);


--실습하기 2-5: IDENTITY
CREATE TABLE USER7 (
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NAME VARCHAR2(20),
    AGE NUMBER,
    EMAIL VARCHAR2(100)
); 

insert into user7 (name,age,email) values ('김유신',25,'kim@gmail.com');
INSERT INTO USER7 (NAME, AGE, EMAIL) VALUES ('장보고', 35, 'jang@gmail.com');
INSERT INTO USER7 (NAME, AGE, EMAIL) VALUES ('이순신', 45, 'lee@gmail.com'); 

select *from user7;