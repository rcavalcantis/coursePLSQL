create or replace 
package PK_CONTROL_EMP
is
  procedure pr_reajuste_salario(wp_percent number, 
                                wp_emp pk_estrutura_dados.ft_emp);

  procedure pr_imprimir_emps(wp_emp pk_estrutura_dados.ft_emp);
  
  procedure pr_zera_emp;
  
  procedure pr_carrega_emp(qtd number, wp_owner varchar2);
  
  procedure pr_carrega_emp_externa(wp_qtd number, wp_owner varchar2);

end;
/
create or replace package body PK_CONTROL_EMP
is

  procedure pr_reajuste_salario(wp_percent number, 
                                wp_emp pk_estrutura_dados.ft_emp) 
  is
    wl_tb_emp pk_estrutura_dados.tb_emp;
  begin
    
    wl_tb_emp := PK_CADASTRO_EMP.FC_BUSCA_FILTRO(wp_emp);
    
    for i in 1..wl_tb_emp.count 
    loop
    
      wl_tb_emp(i).sal := wl_tb_emp(i).sal + (wl_tb_emp(i).sal * wp_percent/100);
      PK_CADASTRO_EMP.PR_ALTERAREMP(wl_tb_emp(i));
    
    end loop;
    
    commit;
  
  end;
  
  procedure pr_imprimir_emps(wp_emp pk_estrutura_dados.ft_emp)
  is
    wl_tb_emp pk_estrutura_dados.tb_emp;
  begin
    
    wl_tb_emp := PK_CADASTRO_EMP.FC_BUSCA_FILTRO(wp_emp);
    
    dbms_output.put_line('**** LISTAGEM DE EMPREGADOS - POR FILTRO ****');
    for i in 1..wl_tb_emp.count 
    loop
      dbms_output.put_line('-- Código.:'||wl_tb_emp(i).empno);
      dbms_output.put_line('-- Nome...:'||wl_tb_emp(i).ename);  
      dbms_output.put_line('-- Salario:'||wl_tb_emp(i).sal);      
      dbms_output.put_line('-- Depart.:'||wl_tb_emp(i).deptno||
                            '-'||pk_cadastro_depto.fc_consulta_dept(wl_tb_emp(i).deptno).dname
                        ||' / '||pk_cadastro_depto.fc_consulta_dept(wl_tb_emp(i).deptno).loc);          
      dbms_output.put_line('*************************************');          
    end loop;
  
  end;
  
  
  procedure pr_zera_emp
  is
    ft_emp     pk_estrutura_dados.ft_emp;
    wl_tb_emp  pk_estrutura_dados.tb_emp;
  begin
  
    wl_tb_emp := PK_CADASTRO_EMP.FC_BUSCA_FILTRO(ft_emp);
    
    for i in 1..wl_tb_emp.count
    loop    
      PK_CADASTRO_EMP.PR_EXCLUIREMP(wl_tb_emp(i));
    end loop;
    
    commit;

  end;


  function fc_novo_emp return pk_estrutura_dados.tp_emp
  is
    wl_emp pk_estrutura_dados.tp_emp;
  begin
  
      select dbms_random.string('U', 5) str 
      into wl_emp.ename from dual;

      select dbms_random.string('U', 5) str 
      into wl_emp.job from dual;
      
      wl_emp.mgr      := trunc(DBMS_RANDOM.value(1,9999));

      wl_emp.hiredate := sysdate;

      wl_emp.sal      := trunc(DBMS_RANDOM.value(99,9999));
      wl_emp.deptno   := 10;
      
      return wl_emp;
  
  end;
  

  procedure pr_carrega_emp(qtd number, wp_owner varchar2)
  is
    wl_emp pk_estrutura_dados.tp_emp;
  begin
    
    for i in 1..qtd
    loop
      wl_emp := fc_novo_emp;
      wl_emp.owner := wp_owner;
      pk_cadastro_emp.pr_incluirEmp(wl_emp);
    end loop;
    commit;
    
  end;
  
  procedure pr_carrega_emp_externa(wp_qtd number, wp_owner varchar2)
  is
  
  begin
  
    case wp_owner
      when 'LOCAL' then
          pr_carrega_emp(wp_qtd, 'RODRIGO');
      else
          pr_carrega_emp(wp_qtd, wp_owner);
    end case;
  
  end;
  
end PK_CONTROL_EMP;
/
show errs;