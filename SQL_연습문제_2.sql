/*
    날짜:2025/07/21
    이름:장진원
    내용:SQL 연습문제2
*/

--실습2-1
alter session set "_ORACLE_SCRIPT"=true;
create user college identified by 1234;
grant connect,resource,unlimited tablespace to college;

drop table student;
select * from enrollment;
alter table enrollment rename column grage to grade;


--실습2-2
create table student(
    stdNo char(8) primary key not null,
    name varchar2(20)  not null,
    birth date  not null,
    major varchar2(20) default null,
    enr_date date  not null
);
alter table course MODIFY CS_name varchar2(40);
alter table student MODIFY major varchar2(40);

alter table course MODIFY CS_name varchar2(40);
alter table course MODIFY CS_dept varchar2(40);

drop table course;
create table course(
    CS_ID number(4) primary key not null,
    CS_name varchar2(20) not null,
    CS_credit number(1) not null,
    CS_dept varchar2(20) not null
);

create table enrollment(
    enr_ID number(4) GENERATED BY DEFAULT AS IDENTITY primary key,
    enr_stdno char(8) not null,
    enr_csid number(4) default null,
    mid_score number default null,
    final_score number default null,
    total_score number default null,
    grade_score char(1) default null
);
--실습2-3

select * from student;
insert into student VALUES(20121016,'김유신','1991-01-13','국문학과','2012-02-01');
insert into student VALUES(20121026,'김춘추','1992-04-11','경제학과','2011-02-01');
insert into student VALUES(20100216,'장보고','1991-05-23','컴퓨터학과','2010-02-01');
insert into student VALUES(20120326,'강감찬','1991-02-09','영문학과','2012-02-01');
insert into student VALUES(20130416,'이순신','1992-11-30','경영학과','2012-02-01');
insert into student VALUES(20110521,'송상현','1992-07-17','컴퓨터학과','2011-02-01');

select * from course;
insert into course values(1059,'고전문학',3,'국문학과');
insert into course values(2312,'데이터베이스',3,'컴퓨터학과');
insert into course values(1203,'Easy Writing',3,'영문학과');
insert into course values(2039,'글로벌경제학',3,'경제학과');
insert into course values(2301,'프로그래밍언어',3,'컴퓨터학과');
insert into course values(2303,'컴퓨터과학 개론',2,'컴퓨터학과');
insert into course values(3012,'마케팅 전략',2,'경영학과');

insert into enrollment VALUES(1,20111126,1203,null,null,null,null);
insert into enrollment VALUES(2,20121016,2301,null,null,null,null);
insert into enrollment VALUES(3,20121016,2303,null,null,null,null);
insert into enrollment VALUES(4,20111126,2039,null,null,null,null);
insert into enrollment VALUES(5,20100216,3012,null,null,null,null);
insert into enrollment VALUES(6,20120326,3012,null,null,null,null);
insert into enrollment VALUES(7,20121016,2312,null,null,null,null);
insert into enrollment VALUES(8,20130416,3012,null,null,null,null);


--실습2-4
select * from student;
--실습2-5
select * from course where cs_dept='컴퓨터학과';
--실습2-6
select * from enrollment where enr_stdno=20121016;
--실습2-7
select name,major,enr_date from student where major='국문학과';
--실습2-8
select * from course where cs_credit=2;
--실습2-9
select stdno,name,birth from student where to_char(birth,'yyyy')>='1992';
--실습2-10

update enrollment set mid_score=36, final_score=42
where enr_stdno='20111126' and enr_csid=1203;

update enrollment SET MID_SCORE = 24, FINAL_SCORE= 62 
WHERE ENR_STDNO='20121016' AND ENR_CSID=2301;

update enrollment SET MID_SCORE = 28, FINAL_SCORE= 40 
WHERE ENR_STDNO='20121016' AND ENR_CSID=2303;

update enrollment SET MID_SCORE = 37, FINAL_SCORE= 57 
WHERE ENR_STDNO='20111126' AND ENR_CSID=2039;

update enrollment SET MID_SCORE = 28, FINAL_SCORE= 68 
WHERE ENR_STDNO='20100216' AND ENR_CSID=3012;

update enrollment SET MID_SCORE = 16, FINAL_SCORE= 65 
WHERE ENR_STDNO='20120326' AND ENR_CSID=3012;

update enrollment SET MID_SCORE = 18, FINAL_SCORE= 38 
WHERE ENR_STDNO='20121016' AND ENR_CSID=2312;

update enrollment SET MID_SCORE = 25, FINAL_SCORE= 58 
WHERE ENR_STDNO='20130416' AND ENR_CSID=3012;


select * from enrollment;

--실습2-11

alter table enrollment rename column grade_score to grage;
update enrollment set
total_score=(MID_SCORE + FINAL_SCORE),
    grade_score=CASE
        WHEN (MID_SCORE + FINAL_SCORE) >= 90 THEN 'A'
        WHEN (MID_SCORE + FINAL_SCORE) >= 80 THEN 'B'
        WHEN (MID_SCORE + FINAL_SCORE) >= 70 THEN 'C'
        WHEN (MID_SCORE + FINAL_SCORE) >= 60 THEN 'D'
        ELSE 'F'
    END;

select * FROM Enrollment;

--실습2-12
SELECT *
FROM Enrollment
where enr_csid=3012
order by total_score desc;

--실습2-13

SELECT *
FROM Enrollment
where enr_csid=3012 order by total_score desc;

--실습2-14
select cs_id,cs_dept from course where cs_name in('데이터베이스','프로그래밍언어');
--실습2-15
select cs_name,cs_dept from course;
--실습2-16
select stdno,name from student order by name;
--실습2-17
select distinct enr_stdno from enrollment;
--실습2-18
SELECT
max((mid_score+final_score)) as "가장_큰_총점"
FROM Enrollment;
--실습2-19
select major, count(major)as "학생수" 
from student group by major;
--실습2-20
select enr_csid,count(*) as "수강_학생수"
from enrollment
group by enr_csid having count(*)>=2;
--실습2-21
SELECT 
STDNO,
 NAME,
 MAJOR,
 ENR_CSID,
 MID_SCORE,
 FINAL_SCORE, 
 (e.MID_SCORE +e.FINAL_SCORE) AS TOTAL_SCORE,
     CASE
        WHEN (MID_SCORE + FINAL_SCORE) >= 90 THEN 'A'
        WHEN (MID_SCORE + FINAL_SCORE) >= 80 THEN 'B'
        WHEN (MID_SCORE + FINAL_SCORE) >= 70 THEN 'C'
        WHEN (MID_SCORE + FINAL_SCORE) >= 60 THEN 'D'
        ELSE 'F'
    END AS GRADE
FROM Student S
join enrollment e on s.stdno=e.enr_stdno;

--실습2-22
SELECT Name, stdNo, ENR_CSID
FROM Student S
JOIN ENROLLMENT E
on s.stdno=e.enr_stdno where e.enr_csid=3012; 

--실습2-23
SELECT
    stdNo,
    Name,
    COUNT(*) AS "수강신청 건수",
    SUM(total_score) AS "종합점수",
    SUM(total_score) / COUNT(stdNo) AS 평균
FROM Student S
JOIN ENROLLMENT E ON S.stdNo = E.ENR_STDNO
group by stdno,name order by stdno;

--실습2-24
SELECT * FROM ENROLLMENT e
join course c 
on c.cs_id=e.enr_csid;

--실습2-25
SELECT
 COUNT(*) AS 마케팅_전략_수강_신청건수,
 AVG(TOTAL_SCORE) AS 마케팅_전략_평균
FROM Enrollment E
join course c on e.enr_csid=c.cs_id
where cs_name ='마케팅 전략';

--실습2-26
 SELECT 
ENR_StdNo, CS_Name
 FROM Enrollment E
 JOIN course c on e.enr_csid=c.cs_id
 WHERE grade='A';
 
--실습2-27
 SELECT 
STDNO,
 NAME,
 MAJOR,
 ENR_CSID,
 CS_NAME,
 CS_CREDIT,
 TOTAL_SCORE,
 GRADE
 FROM Student S
 JOIN enrollment e on s.stdno=enr_stdno
 JOIN course c on e.enr_csid=c.cs_id;
 
--실습2-28
 SELECT
 stdNo,
 Name,
 CS_Name,
 TOTAL_SCORE,
 Grade
 FROM Student S
 JOIN enrollment e on s.stdno=enr_stdno
 JOIN course c on e.enr_csid=c.cs_id; 

--실습2-29
SELECT
stdNo,
Name,
sum(cs_credit) as 이수학점
FROM Student S
JOIN enrollment e on s.stdno=enr_stdno
JOIN course c on e.enr_csid=c.cs_id
where grade !='F'
group by stdno,name
;
 
--실습2-30
SELECT 
S.STDNO, 
S.NAME, 
S.MAJOR
FROM STUDENT S
WHERE S.STDNO NOT IN (
 SELECT enr_stdno from enrollment
);