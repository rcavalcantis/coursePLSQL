create or replace
PACKAGE PK_FACHADA_CURSO AS
  PROCEDURE PR_INCLUIR_FAC(WL_ename varchar2,
                           WL_job varchar2,
                           WL_sal number,
                           WL_hiredate date,
                           WL_deptno number);
END PK_FACHADA_CURSO;