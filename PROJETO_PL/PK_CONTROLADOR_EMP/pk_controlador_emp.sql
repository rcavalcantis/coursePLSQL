create or replace package pk_controlador_emp
is

  procedure pr_inserir_emp(wp_rg_emp in out pk_estrutura_dados.tp_emp);
  
  procedure pr_alterar_emp(wp_rg_emp in out pk_estrutura_dados.tp_emp);

  procedure pr_excluir_emp(wp_rg_emp in out pk_estrutura_dados.tp_emp);

  function fc_consultar_emp(wp_rg_emp pk_estrutura_dados.tp_emp)
  return   pk_estrutura_dados.tp_tb_emp;
  
  procedure pr_imprimir_consulta(wp_tb_emp pk_estrutura_dados.tp_tb_emp);

  procedure pr_reajustar_sal(wp_rg_emp in out pk_estrutura_dados.tp_emp, wp_perc number);


end pk_controlador_emp;
/
create or replace package body pk_controlador_emp
is
  
  procedure pr_inserir_emp(wp_rg_emp in out pk_estrutura_dados.tp_emp)
  is
  
  begin
     
     if not pk_cadastro_emp.fc_existe_emp(wp_rg_emp) then    
        pk_cadastro_emp.pr_inserir_emp(wp_rg_emp);        
     else     
        dbms_output.put_line('Empregado já existe!');        
     end if;
       
  end pr_inserir_emp;
  
  procedure pr_alterar_emp(wp_rg_emp in out pk_estrutura_dados.tp_emp)
  is
  
  begin
     
     if pk_cadastro_emp.fc_existe_emp(wp_rg_emp) then    
        pk_cadastro_emp.pr_alterar_emp(wp_rg_emp);        
     else     
        dbms_output.put_line('Empregado não existe!');        
     end if;
       
  end pr_alterar_emp;
   
   
  procedure pr_excluir_emp(wp_rg_emp in out pk_estrutura_dados.tp_emp)
  is
  
  begin
     
     if pk_cadastro_emp.fc_existe_emp(wp_rg_emp) then    
        pk_cadastro_emp.pr_excluir_emp(wp_rg_emp);        
     else     
        dbms_output.put_line('Empregado não existe!');        
     end if;
       
  end pr_excluir_emp;
  
  
  function fc_consultar_emp(wp_rg_emp pk_estrutura_dados.tp_emp)
  return   pk_estrutura_dados.tp_tb_emp
  is
    wl_tb_emp  pk_estrutura_dados.tp_tb_emp;
    cs_emp     pk_estrutura_dados.rf_cursor;
    wl_ind     number := 0;
    
  begin
  
    cs_emp := pk_cadastro_emp.fc_consultar_emp(wp_rg_emp);
    
    if cs_emp%IsOpen then
      loop
         wl_ind := wl_ind + 1;
         fetch cs_emp into wl_tb_emp(wl_ind);
         exit when cs_emp%NotFound;
      end loop;
      close cs_emp;
    else
      dbms_output.put_line('Consulta inexistente!');            
    end if;  
    
    return wl_tb_emp;

  end fc_consultar_emp;
  
  procedure pr_imprimir_consulta(wp_tb_emp pk_estrutura_dados.tp_tb_emp)
  is
  
  begin
    
    for i in 1..wp_tb_emp.count loop    

      dbms_output.put_line('--------------------------------');        
      dbms_output.put_line('Codigo....: '||wp_tb_emp(i).EMPLOYEE_ID);        
      dbms_output.put_line('Nome......: '||wp_tb_emp(i).FIRST_NAME);        
      dbms_output.put_line('Sobrenome.: '||wp_tb_emp(i).LAST_NAME);        
      dbms_output.put_line('Controle..: '||wp_tb_emp(i).CONTROLE);        
      dbms_output.put_line('Gerente...: '||wp_tb_emp(i).MANAGER_ID);        
      dbms_output.put_line('Dt.Cad....: '||to_char(wp_tb_emp(i).HIRE_DATE,'dd/mm/yyyy'));        
      dbms_output.put_line('Salario...: R$ '||to_char(wp_tb_emp(i).SALARY,'999,999.99'));        
      dbms_output.put_line('Comissao..: '||wp_tb_emp(i).COMMISSION);      
      dbms_output.put_line('Depart....: '||wp_tb_emp(i).DEPARTMENT_ID);
    
    end loop;
 
  end pr_imprimir_consulta;
  
  procedure pr_reajustar_sal(wp_rg_emp in out pk_estrutura_dados.tp_emp, wp_perc number)
  is
  
  begin
    wp_rg_emp.SALARY := wp_rg_emp.SALARY * ((wp_perc / 100)+1);
    
    pk_controlador_emp.pr_alterar_emp(wp_rg_emp);
  
  end pr_reajustar_sal;
  
 
end pk_controlador_emp;
/