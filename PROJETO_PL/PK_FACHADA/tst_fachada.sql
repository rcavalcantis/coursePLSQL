set serveroutput on;
clear;

declare

  wl_emp           PK_ESTRUTURA_DADOS.tp_emp;
  wl_emp_consulta  PK_ESTRUTURA_DADOS.tp_emp;
  
  wl_qtdEmp        integer := 50;


begin
   
  
  pk_fachada.pr_init_carga('RODRIGO', 'CAVALCANTI', 
                            15875.25, wl_qtdEmp, 0);

  pk_fachada.pr_limpar_carga(null,null,50,null);
                                                 

  pk_fachada.pr_init_carga_AL01('RODRIGO', 'CAVALCANTI', 
                                15875.25, wl_qtdEmp, 0);

  pk_fachada.pr_limpar_carga_AL01(null,null,50,null);

  
end;