--교재 p26
//1
select * from emp;
//2
select empno,ename from emp;
//3
select empno,'good morning~~!' "Good Morning" from emp;
select empno, 'good morning~~!' "Good Morning",'nice morning~~!' "nice Morning" from emp;
select empno,ename,'good morning~~!' "Good Morning" from emp;
//4
select empno,ename from emp;
select empno as "no",ename "name" from emp;
//5
select deptno from emp;
select distinct deptno from emp;

select distinct deptno from emp;
select job, ename from emp;
select job, ename from emp order by 1,2;

//6
select ename,job from emp;
select ename||job from emp;
select ename||'-'||job from emp;
select ename||' ''s job is'||job from emp;

//6-p1
select name||'''s ID: '||ID||', weight is '||weight ||'KG' as "ID AND WEIGHT" from student;
//6-p2
select *from emp;
select ename||'('||job||'), '||ename||''''||job||'''' as "NAME AND JOB" from emp;
//6-p3
select ename||'''s sal is $'||sal as "NAME AND Sal" from emp;

select empno, ename from emp where empno=7000;
select ename,sal from emp where sal<900;

select ename,sal from emp where ename='SMITH';
select ename,hiredate from emp where hiredate='80/12/17';

//8
Select ename,sal from emp where deptno =10;
Select ename,sal,sal*100 from emp where deptno =10;
Select ename,sal,sal*1.1 from emp where deptno =10;

//9
Select empno,ename,sal from emp where sal >=4000;
Select empno,ename,sal from emp where ename >='W';
select ename,hiredate from emp;
select ename,hiredate from emp where hiredate >= '81/12/25';

select empno, ename,sal from emp where sal BETWEEN 2000 And 3000;
select empno, ename,sal from emp where sal >=2000 AND sal<= 3000;

select ename from emp order by ename;
select ename from emp where ename BETWEEN 'JAMES' AND 'WARTIN' order by ename;
select empno,ename,deptno from emp where deptno in(10,20);
select empno,ename,sal from emp where sal like '1%';
select empno,ename,sal from emp where ename like 'A%';
select empno,ename,hiredate from emp where hiredate like '80%';
select empno,ename,hiredate from emp ;
select empno,ename,hiredate from emp where hiredate like '___12%';
select empno,ename,comm from emp where deptno in(20,30);




