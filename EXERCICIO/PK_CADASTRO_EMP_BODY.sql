create or replace
PACKAGE BODY PK_CADASTRO_EMP AS

FUNCTION FC_EXISTE(wp_rc_emp PK_ESTRUTURA_DADOS.tp_rec_emp)
RETURN BOOLEAN
IS
wl_count number;
wl_ret   boolean := FALSE;
BEGIN
    SELECT count(ename)
    INTO  wl_count  FROM emp 
    WHERE  ename = wp_rc_emp.ename;
    
    if wl_count > 0 then
      wl_ret := true;
    end if;
    
    RETURN wl_ret; 
END FC_EXISTE;

PROCEDURE PR_INCLUIR(wp_rc_emp in out PK_ESTRUTURA_DADOS.tp_rec_emp)
IS
BEGIN
  SELECT MAX(empno) into wp_rc_emp.empno from emp;
  INSERT INTO emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
  values          (wp_rc_emp.empno + 1,
                   wp_rc_emp.ename,
                   wp_rc_emp.job,
                   wp_rc_emp.mgr,
                   wp_rc_emp.hiredate,
                   wp_rc_emp.sal,
                   wp_rc_emp.comm,
                   wp_rc_emp.deptno);
END PR_INCLUIR;

END PK_CADASTRO_EMP;