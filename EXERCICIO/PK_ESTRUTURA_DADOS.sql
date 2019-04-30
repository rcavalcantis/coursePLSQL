CREATE OR REPLACE PACKAGE 
PK_ESTRUTURA_DADOS AS

type tp_tb_emp is table of emp%rowtype;

type tp_rec_emp is record (empno emp.empno%type,
                           ename emp.ename%type,
                           job   emp.job%type,
                           hiredate emp.hiredate%type,
                           sal   emp.sal%type,
                           deptno emp.deptno%type
			   incluido boolean);

type tp_rec_dept is record (cod	 dept.

				)

END PK_ESTRUTURA_DADOS;

	= is table of emp%rowtype PARA EMP
	= UM RECORD PARCIAL PARA EMP SEM OS CAMPOS mgr e comm, ACRESCENTANDO UM CAMPO "INCLUIDO" BOOLEAN
	= UM RECORD PARA DEPT

