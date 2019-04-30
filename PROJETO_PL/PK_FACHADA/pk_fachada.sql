create or replace package pk_fachada 
is

  procedure pr_init_carga(wp_nome varchar2,  wp_sobre varchar2, 
                          wp_salario number, wp_qtd number, 
                          wp_perc number);

  procedure pr_limpar_carga( wp_FIRST_NAME    varchar2 := null,
                             wp_LAST_NAME     varchar2 := null,
                             wp_DEPARTMENT_id number   := null,
                             wp_EMPLOYEE_ID   number   := null);
                             
  procedure pr_init_carga_AL01(wp_nome varchar2,  wp_sobre varchar2, 
                          wp_salario number, wp_qtd number, 
                          wp_perc number);

  procedure pr_limpar_carga_AL01( wp_FIRST_NAME    varchar2 := null,
                             wp_LAST_NAME     varchar2 := null,
                             wp_DEPARTMENT_id number   := null,
                             wp_EMPLOYEE_ID   number   := null);
                             
                             

end pk_fachada;
/

create or replace package body pk_fachada 
is

  procedure pr_init_carga(wp_nome varchar2,  wp_sobre varchar2, 
                          wp_salario number, wp_qtd number, 
                          wp_perc number)
  is
    wp_rg_emp pk_estrutura_dados.tp_emp;
     
  begin
  
     wp_rg_emp.FIRST_NAME := wp_nome;
     wp_rg_emp.LAST_NAME  := wp_sobre;
     wp_rg_emp.SALARY     := wp_salario;
     
     wp_rg_emp.EMPLOYEE_ID   := NULL;
     wp_rg_emp.CONTROLE      := 123;
     wp_rg_emp.MANAGER_ID    := 0;
     wp_rg_emp.HIRE_DATE     := sysdate;
     wp_rg_emp.COMMISSION    := 0;
     wp_rg_emp.DEPARTMENT_ID := 50;
     
     
     pk_controlador_init.pr_init_carga(wp_rg_emp,wp_qtd,wp_perc);
  
  end pr_init_carga;

  procedure pr_limpar_carga( wp_FIRST_NAME    varchar2 := NULL,
                             wp_LAST_NAME     varchar2 := NULL,
                             wp_DEPARTMENT_id number   := NULL,
                             wp_EMPLOYEE_ID   number   := NULL)
  is
    wp_rg_emp  pk_estrutura_dados.tp_emp;
  begin

    wp_rg_emp.FIRST_NAME    := wp_FIRST_NAME;
    wp_rg_emp.LAST_NAME     := wp_LAST_NAME;
    wp_rg_emp.DEPARTMENT_id := wp_DEPARTMENT_id;
    wp_rg_emp.EMPLOYEE_ID   := wp_EMPLOYEE_ID;
  
    pk_controlador_init.pr_limpar_carga(wp_rg_emp);

  end pr_limpar_carga;


  procedure pr_init_carga_AL01(wp_nome varchar2,  wp_sobre varchar2, 
                               wp_salario number, wp_qtd number, 
                               wp_perc number)
  is
    wp_rg_emp pk_estrutura_dados.tp_emp;
     
  begin
  
     wp_rg_emp.FIRST_NAME := wp_nome;
     wp_rg_emp.LAST_NAME  := wp_sobre;
     wp_rg_emp.SALARY     := wp_salario;
     
     wp_rg_emp.EMPLOYEE_ID   := NULL;
     wp_rg_emp.CONTROLE      := 123;
     wp_rg_emp.MANAGER_ID    := 0;
     wp_rg_emp.HIRE_DATE     := sysdate;
     wp_rg_emp.COMMISSION    := 0;
     wp_rg_emp.DEPARTMENT_ID := 50;
     
     
     pk_controlador_init.pr_init_carga_AL01(wp_rg_emp,wp_qtd,wp_perc);
  
  end pr_init_carga_AL01;

  procedure pr_limpar_carga_AL01( wp_FIRST_NAME    varchar2 := NULL,
                                wp_LAST_NAME     varchar2 := NULL,
                                wp_DEPARTMENT_id number   := NULL,
                                wp_EMPLOYEE_ID   number   := NULL)
  is
    wp_rg_emp  pk_estrutura_dados.tp_emp;
  begin

    wp_rg_emp.FIRST_NAME    := wp_FIRST_NAME;
    wp_rg_emp.LAST_NAME     := wp_LAST_NAME;
    wp_rg_emp.DEPARTMENT_id := wp_DEPARTMENT_id;
    wp_rg_emp.EMPLOYEE_ID   := wp_EMPLOYEE_ID;
  
    pk_controlador_init.pr_limpar_carga(wp_rg_emp);

  end pr_limpar_carga_AL01;






end pk_fachada;
/