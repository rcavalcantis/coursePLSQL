create or replace package pk_interface
is
  procedure pr_init_carga(wp_rg_emp in out pk_estrutura_dados.tp_emp,
                          wp_qtd number, wp_perc number);

  procedure pr_limpar_carga(wp_rg_emp pk_estrutura_dados.tp_emp);

end pk_interface;
/

create or replace package body pk_interface
is

  procedure pr_init_carga(wp_rg_emp in out pk_estrutura_dados.tp_emp,
                          wp_qtd number, wp_perc number)
  is
    wp_nome    varchar2(15);  
    wp_sobre   varchar2(15);
    wp_salario number; 

  begin   
  
    wp_nome    := wp_rg_emp.FIRST_NAME;
    wp_sobre   := wp_rg_emp.LAST_NAME ;
    wp_salario := wp_rg_emp.SALARY    ;
                          
    aluno01.pk_fachada.pr_init_carga(wp_nome   ,
                                     wp_sobre  , 
                                     wp_salario,
                                     wp_qtd    , 
                                     wp_perc   );

     
  end pr_init_carga;


  procedure pr_limpar_carga(wp_rg_emp pk_estrutura_dados.tp_emp)
  is
  
  begin
     aluno01.pk_fachada.pr_limpar_carga( wp_rg_emp.FIRST_NAME    ,
                                         wp_rg_emp.LAST_NAME     ,
                                         wp_rg_emp.DEPARTMENT_id ,
                                         wp_rg_emp.EMPLOYEE_ID);
  end;

end pk_interface;
/
