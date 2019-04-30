create or replace
package PK_FACHADA
is

  procedure pr_reajuste_salario(wp_percent number);

  procedure pr_imprimir_emps;
  
  procedure pr_carga_emp(wp_qtd number);
  
  procedure pr_carga_emp(wp_qtd number, wp_owner varchar2);  
  
  procedure pr_limpa_banco;


end PK_FACHADA;
/

create or replace 
package body PK_FACHADA
is

  procedure pr_reajuste_salario(wp_percent number)
  is
    wl_ft_emp pk_estrutura_dados.ft_emp;
  begin
    
    wl_ft_emp.deptno := 30;
  
    PK_CONTROL_EMP.pr_reajuste_salario(wp_percent,wl_ft_emp);
  
  end;

  procedure pr_imprimir_emps
  is
    wl_ft_emp pk_estrutura_dados.ft_emp;
  begin
    
    wl_ft_emp.deptno := 30;
    PK_CONTROL_EMP.pr_imprimir_emps(wl_ft_emp);
  end;
  

  procedure pr_carga_emp(wp_qtd number)
  is
  
  begin
    
    PK_CONTROL_EMP.PR_CARREGA_EMP(wp_qtd, 'RODRIGO');
      
  end;
  
  procedure pr_carga_emp(wp_qtd number, wp_owner varchar2)
  is
  
  begin
  
    PK_CONTROL_EMP.pr_carrega_emp_externa(wp_qtd, wp_owner);  
  
  end;
  
  procedure pr_limpa_banco
  is
  begin
      PK_CONTROL_EMP.PR_ZERA_EMP;      
  end;
  

end PK_FACHADA;
/
show errs;