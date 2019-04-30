set serveroutput on;
clear;

declare

  wl_emp           PK_ESTRUTURA_DADOS.tp_emp;
  wl_emp_consulta  PK_ESTRUTURA_DADOS.tp_emp;
  wl_tb_emp        PK_ESTRUTURA_DADOS.tp_tb_emp;
  
  wl_qtdEmp        integer := 1;


begin

   wl_emp.EMPLOYEE_ID   := 7955;
   wl_emp.LAST_NAME     := 'ALENCAR';
   wl_emp.FIRST_NAME    := 'HILDA';
   wl_emp.CONTROLE      := 123;
   wl_emp.MANAGER_ID    := 0;
   wl_emp.HIRE_DATE     := sysdate;
   wl_emp.SALARY        := 25354.45;
   wl_emp.COMMISSION    := 0;
   wl_emp.DEPARTMENT_ID := 10;

   pk_controlador_emp.pr_inserir_emp(wl_emp);
   pk_controlador_emp.pr_inserir_emp(wl_emp);


  wl_emp_consulta.FIRST_NAME    := NULL;
  wl_emp_consulta.LAST_NAME     := NULL;
  wl_emp_consulta.DEPARTMENT_id := 10;
  wl_emp_consulta.EMPLOYEE_ID   := NULL;

  
  pk_controlador_emp.pr_reajustar_sal(wl_emp,10.00);
  
  wl_tb_emp := pk_controlador_emp.fc_consultar_emp(wl_emp_consulta);
  
  pk_controlador_emp.pr_imprimir_consulta(wl_tb_emp);
  
  pk_controlador_emp.pr_alterar_emp(wl_emp);
  
  pk_controlador_emp.pr_excluir_emp(wl_emp);
  
end;