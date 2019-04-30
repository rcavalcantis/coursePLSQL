drop table emp;
drop table salgrade;
drop table dept;
--------------------------------------------------------
--  Arquivo criado - Terça-feira-Janeiro-21-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table EMP
--------------------------------------------------------

  CREATE TABLE "EMP" ("EMPNO" NUMBER(10,0), "ENAME" VARCHAR2(10 BYTE), "JOB" VARCHAR2(9 BYTE), "MGR" NUMBER(4,0), "HIREDATE" DATE, "SAL" NUMBER(7,2), "COMM" NUMBER(7,2), "DEPTNO" NUMBER(2,0), "OWNER" VARCHAR2(20))
/
--------------------------------------------------------
--  DDL for Table SALGRADE
--------------------------------------------------------

  CREATE TABLE "SALGRADE" ("GRADE" NUMBER, "LOSAL" NUMBER, "HISAL" NUMBER)
/
--------------------------------------------------------
--  DDL for Table DEPT
--------------------------------------------------------

  CREATE TABLE "DEPT" ("DEPTNO" NUMBER(2,0), "DNAME" VARCHAR2(14 BYTE), "LOC" VARCHAR2(13 BYTE))
/
REM INSERTING into EMP
SET DEFINE OFF;
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7369','SMITH','CLERK','7902',to_date('17/12/2001','DD/MM/YYYY'),'800',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7499','ALLEN','SALESMAN','7698',to_date('20/02/2003','DD/MM/YYYY'),'1600','300','30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7521','WARD','SALESMAN','7698',to_date('22/02/2001','DD/MM/YYYY'),'1250','500','30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7566','JONES','MANAGER','7839',to_date('02/04/2001','DD/MM/YYYY'),'2975',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7654','MARTIN','SALESMAN','7698',to_date('28/09/2003','DD/MM/YYYY'),'1250','1400','30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7698','BLAKE','MANAGER','7839',to_date('01/05/2003','DD/MM/YYYY'),'2850',null,'30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7782','CLARK','MANAGER','7839',to_date('09/06/2001','DD/MM/YYYY'),'2450',null,'10');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7788','SCOTT','ANALYST','7566',to_date('19/04/2002','DD/MM/YYYY'),'3000',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7839','KING','PRESIDENT',null,to_date('17/11/2003','DD/MM/YYYY'),'5000',null,'10');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7844','TURNER','SALESMAN','7698',to_date('08/09/2002','DD/MM/YYYY'),'1500','0','30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7876','ADAMS','CLERK','7788',to_date('23/05/2003','DD/MM/YYYY'),'1100',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7900','JAMES','CLERK','7698',to_date('03/12/2001','DD/MM/YYYY'),'950',null,'30');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7902','FORD','ANALYST','7566',to_date('03/12/2001','DD/MM/YYYY'),'3000',null,'20');
Insert into EMP (EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) values ('7934','MILLER','CLERK','7782',to_date('23/01/2003','DD/MM/YYYY'),'1300',null,'10');
REM INSERTING into SALGRADE
SET DEFINE OFF;
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('1','700','1200');
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('2','1201','1400');
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('3','1401','2000');
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('4','2001','3000');
Insert into SALGRADE (GRADE,LOSAL,HISAL) values ('5','3001','9999');
REM INSERTING into DEPT
SET DEFINE OFF;
Insert into DEPT (DEPTNO,DNAME,LOC) values ('10','ACCOUNTING','NEW YORK');
Insert into DEPT (DEPTNO,DNAME,LOC) values ('20','RESEARCH','DALLAS');
Insert into DEPT (DEPTNO,DNAME,LOC) values ('30','SALES','CHICAGO');
Insert into DEPT (DEPTNO,DNAME,LOC) values ('40','OPERATIONS','BOSTON');
--------------------------------------------------------
--  DDL for Index PK_EMP
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_EMP" ON "EMP" ("EMPNO")
/
--------------------------------------------------------
--  DDL for Index PK_DEPT
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_DEPT" ON "DEPT" ("DEPTNO")
/
--------------------------------------------------------
--  Constraints for Table EMP
--------------------------------------------------------

  ALTER TABLE "EMP" ADD CONSTRAINT "PK_EMP" PRIMARY KEY ("EMPNO") ENABLE
/

--------------------------------------------------------
--  Constraints for Table DEPT
--------------------------------------------------------

  ALTER TABLE "DEPT" ADD CONSTRAINT "PK_DEPT" PRIMARY KEY ("DEPTNO") ENABLE
/
--------------------------------------------------------
--  Ref Constraints for Table EMP
--------------------------------------------------------

  ALTER TABLE "EMP" ADD CONSTRAINT "FK_DEPTNO" FOREIGN KEY ("DEPTNO") REFERENCES "DEPT" ("DEPTNO") ENABLE
/


