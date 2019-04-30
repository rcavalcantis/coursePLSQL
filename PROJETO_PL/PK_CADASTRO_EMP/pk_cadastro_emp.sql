create or replace
package pk_cadastro_emp
is

  function fc_existe_emp(wp_rg_emp in pk_estrutura_dados.tp_emp) 
  return boolean;

  procedure pr_inserir_emp(wp_rg_emp in out pk_estrutura_dados.tp_emp);
  
  procedure pr_alterar_emp(wp_rg_emp pk_estrutura_dados.tp_emp);
  
  procedure pr_excluir_emp(wp_rg_emp pk_estrutura_dados.tp_emp);
  
  function fc_consultar_emp(wp_rg_emp pk_estrutura_dados.tp_emp)
  return pk_estrutura_dados.rf_cursor;


end pk_cadastro_emp;
/
create or replace
package body pk_cadastro_emp
is

  function fc_existe_emp(wp_rg_emp pk_estrutura_dados.tp_emp) 
  return boolean
  is
    wl_count   integer := 0;
    wl_retorno boolean := FALSE;
    
  begin
  
     select count(*) 
     into   wl_count
            from employee e 
     where e.employee_id = wp_rg_emp.employee_id;
     
     if wl_count > 0 then
        
        wl_retorno := TRUE;
            
     end if;
    
     return wl_retorno;
  
  end fc_existe_emp;
  
  function fc_get_id 
  return employee.employee_id%type
  is
    wl_id employee.employee_id%type;
  begin
    begin
         
     select max(e.employee_id)+1 
     into   wl_id
            from employee e;
      
     if wl_id is null then
       raise pk_estrutura_dados.e_empno_null;    
     end if;
    
     return wl_id;
    
    exception
       when pk_estrutura_dados.e_empno_null then
         return 1;
    end;
  end fc_get_id;
  
  procedure pr_inserir_emp(wp_rg_emp in out pk_estrutura_dados.tp_emp) 
  is
  
  begin
  
     wp_rg_emp.employee_id := fc_get_id;
     wp_rg_emp.FIRST_NAME  := wp_rg_emp.FIRST_NAME ||' - '||wp_rg_emp.employee_id;
          
     insert into employee (EMPLOYEE_ID      ,
                           LAST_NAME        ,
                           FIRST_NAME       ,
                           CONTROLE         ,
                           MANAGER_ID       ,
                           HIRE_DATE        ,
                           SALARY           ,
                           COMMISSION       ,
                           DEPARTMENT_ID    )
            values        (
                           wp_rg_emp.EMPLOYEE_ID      ,
                           wp_rg_emp.LAST_NAME        ,
                           wp_rg_emp.FIRST_NAME       ,
                           wp_rg_emp.CONTROLE         ,
                           wp_rg_emp.MANAGER_ID       ,
                           wp_rg_emp.HIRE_DATE        ,
                           wp_rg_emp.SALARY           ,
                           wp_rg_emp.COMMISSION       ,
                           wp_rg_emp.DEPARTMENT_ID    );
    
  end pr_inserir_emp;
  
  procedure pr_alterar_emp(wp_rg_emp pk_estrutura_dados.tp_emp)
  is
  
  begin
  
     update employee set  LAST_NAME        = wp_rg_emp.LAST_NAME  ,
                          FIRST_NAME       = wp_rg_emp.FIRST_NAME ,
                          CONTROLE         = wp_rg_emp.CONTROLE   ,
                          MANAGER_ID       = wp_rg_emp.MANAGER_ID ,
                          HIRE_DATE        = wp_rg_emp.HIRE_DATE  ,
                          SALARY           = wp_rg_emp.SALARY     ,
                          COMMISSION       = wp_rg_emp.COMMISSION ,
                          DEPARTMENT_ID    = wp_rg_emp.DEPARTMENT_ID
            
            where         EMPLOYEE_ID      = wp_rg_emp.EMPLOYEE_ID;
     
  
  end pr_alterar_emp;
  
  procedure pr_excluir_emp(wp_rg_emp pk_estrutura_dados.tp_emp)
  is
    
  begin
  
    delete employee where employee_id = wp_rg_emp.employee_id;
  
  end pr_excluir_emp;
  
  function fc_consultar_emp(wp_rg_emp pk_estrutura_dados.tp_emp)
  return pk_estrutura_dados.rf_cursor
  is
   wl_sql    varchar2(4000);
   wl_cursor pk_estrutura_dados.rf_cursor;
   wb_where  boolean := false; 

  begin
    
    wl_sql := 'select EMPLOYEE_ID      ,
                      LAST_NAME        ,
                      FIRST_NAME       ,
                      CONTROLE         ,
                      MANAGER_ID       ,
                      HIRE_DATE        ,
                      SALARY           ,
                      COMMISSION       ,
                      DEPARTMENT_ID
               from   employee';
               
    if wp_rg_emp.EMPLOYEE_ID is not null then
       if not wb_where then
          wl_sql := wl_sql || ' where ';
          wb_where := true;
       else
          wl_sql := wl_sql || ' and ';       
       end if;
       wl_sql := wl_sql || 'EMPLOYEE_ID = '||wp_rg_emp.EMPLOYEE_ID||' ';
       
    end if;


    if wp_rg_emp.DEPARTMENT_ID is not null then
       if not wb_where then
          wl_sql := wl_sql || ' where ';
          wb_where := true;
       else 
          wl_sql := wl_sql || ' and ';
       end if;
       wl_sql := wl_sql || 'DEPARTMENT_ID = '||wp_rg_emp.DEPARTMENT_ID||' ';
       
    end if;
    
    if (wp_rg_emp.FIRST_NAME IS NOT NULL) OR 
       (wp_rg_emp.LAST_NAME  IS NOT NULL) then

       if not wb_where then
          wl_sql := wl_sql || ' where ';
          wb_where := true;
       else 
          wl_sql := wl_sql || ' and ';
       end if;
              
       if wp_rg_emp.FIRST_NAME IS NOT NULL and 
          wp_rg_emp.LAST_NAME  IS NULL     then
          wl_sql := wl_sql || ' FIRST_NAME like ''%'||wp_rg_emp.FIRST_NAME||'%''';
       
       elsif wp_rg_emp.FIRST_NAME IS NULL and 
             wp_rg_emp.LAST_NAME  IS NOT NULL     then
       
          wl_sql := wl_sql || ' LAST_NAME like ''%'||wp_rg_emp.LAST_NAME||'%'')';
       
       else
       
          wl_sql := wl_sql || '(FIRST_NAME like ''%'||wp_rg_emp.FIRST_NAME||'%''';       
          wl_sql := wl_sql || ' or LAST_NAME like ''%'||wp_rg_emp.LAST_NAME||'%)'')';       
       
       end if;

              
              
    end if;
           
    open wl_cursor for wl_sql;
    
    return wl_cursor;
  
  end fc_consultar_emp;
  

end pk_cadastro_emp;
/