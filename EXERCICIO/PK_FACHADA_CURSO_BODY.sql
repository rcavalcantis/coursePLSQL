create or replace
PACKAGE BODY PK_FACHADA_CURSO AS

  PROCEDURE PR_INCLUIR_FAC(WL_ename varchar2,
                           WL_job varchar2,
                           WL_sal number,
                           WL_hiredate date,
                           WL_deptno number)
  IS
    wl_rec_emp PK_ESTRUTURA_DADOS.tp_rec_emp;
    
  BEGIN
    wl_rec_emp.ename     :=  wl_ename;
    wl_rec_emp.ename     :=  wl_job;
    wl_rec_emp.sal       :=  wl_sal;
    wl_rec_emp.hiredate  :=  wl_hiredate;
    wl_rec_emp.deptno    :=  wl_deptno;
    
    PK_CONTROL_EMP.PR_INCLUIR_CTRL(wl_rec_emp);
  
  END PR_INCLUIR_FAC;

END PK_FACHADA_CURSO;