set serveroutput on;
clear;

declare

  wl_emp           PK_ESTRUTURA_DADOS.tp_emp;
  wl_emp_consulta  PK_ESTRUTURA_DADOS.tp_emp;
  
  wl_rf_cursor PK_ESTRUTURA_DADOS.rf_cursor;


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
  
  if pk_cadastro_emp.fc_existe_emp(wl_emp) then
  
     dbms_output.put_line('Existe');
     pk_cadastro_emp.pr_alterar_emp(wl_emp);
     --pk_cadastro_emp.pr_excluir_emp(wl_emp);     
  else
    
     dbms_output.put_line('Não Existe');
     pk_cadastro_emp.pr_inserir_emp(wl_emp);   
     
  end if;
 
--rollback;

  wl_emp_consulta.FIRST_NAME    := NULL;
  wl_emp_consulta.LAST_NAME     := NULL;
  wl_emp_consulta.DEPARTMENT_id := 10;
  wl_emp_consulta.EMPLOYEE_ID   := NULL;
  
  wl_rf_cursor := pk_cadastro_emp.fc_consultar_emp(wl_emp_consulta);
  
  if wl_rf_cursor%isOpen then
  
    loop
      fetch wl_rf_cursor into wl_emp;
        
        exit when wl_rf_cursor%notFound;
        
        dbms_output.put_line('--------------------------------');        
        dbms_output.put_line('Codigo....: '||wl_emp.EMPLOYEE_ID);        
        dbms_output.put_line('Nome......: '||wl_emp.FIRST_NAME);        
        dbms_output.put_line('Sobrenome.: '||wl_emp.LAST_NAME);        
        dbms_output.put_line('Controle..: '||wl_emp.CONTROLE);        
        dbms_output.put_line('Gerente...: '||wl_emp.MANAGER_ID);        
        dbms_output.put_line('Dt.Cad....: '||to_char(wl_emp.HIRE_DATE,'dd/mm/yyyy'));        
        dbms_output.put_line('Salario...: R$ '||to_char(wl_emp.SALARY,'999,999.99'));        
        dbms_output.put_line('Comissao..: '||wl_emp.COMMISSION);      
        dbms_output.put_line('Depart....: '||wl_emp.DEPARTMENT_ID);
      
    end loop;
    
    
  end if;
  
  close wl_rf_cursor;
  
  
end;
