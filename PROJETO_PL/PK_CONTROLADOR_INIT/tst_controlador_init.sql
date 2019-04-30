set serveroutput on;
clear;

declare

  wl_emp           PK_ESTRUTURA_DADOS.tp_emp;
  wl_emp_consulta  PK_ESTRUTURA_DADOS.tp_emp;
  
  wl_qtdEmp        integer := 100;


begin

   wl_emp.EMPLOYEE_ID   := NULL;
   wl_emp.LAST_NAME     := 'CAVALCANTI';
   wl_emp.FIRST_NAME    := 'RODRIGO';
   wl_emp.CONTROLE      := 123;
   wl_emp.MANAGER_ID    := 0;
   wl_emp.HIRE_DATE     := sysdate;
   wl_emp.SALARY        := 5000.00;
   wl_emp.COMMISSION    := 0;
   wl_emp.DEPARTMENT_ID := 50;

   wl_emp_consulta.FIRST_NAME    := NULL;
   wl_emp_consulta.LAST_NAME     := NULL;
   wl_emp_consulta.DEPARTMENT_id := 50;
   wl_emp_consulta.EMPLOYEE_ID   := NULL;

   pk_controlador_init.pr_init_carga(wl_emp,wl_qtdEmp,0);
   
   pk_controlador_init.pr_limpar_carga(wl_emp_consulta);

  
end;