create or replace
package PK_CADASTRO_EMP
is

    function fc_existeEmp(wp_emp pk_estrutura_dados.tp_emp)
    return boolean;
    
    procedure pr_incluirEmp(wp_emp in out pk_estrutura_dados.tp_emp);
    
    procedure pr_alterarEmp(wp_emp pk_estrutura_dados.tp_emp);
                                                
    procedure pr_excluirEmp(wp_emp pk_estrutura_dados.tp_emp);                                                
    
    function fc_recuperarEmps return pk_estrutura_dados.tb_emp; 
    
    function fc_busca_filtro(wp_filtro pk_estrutura_dados.ft_emp)
    return pk_estrutura_dados.tb_emp;

end PK_CADASTRO_EMP ;
/
create or replace
package body PK_CADASTRO_EMP
is

    function fc_existeEmp(wp_emp pk_estrutura_dados.tp_emp)
    return boolean
    is
        wl_count number;
        wb_retorno boolean;
    begin
    
        select 
            count(1) into wl_count
        from EMP where empno = wp_emp.empno;
        
        if wl_count > 0 then
            wb_retorno := true;
        else
            wb_retorno := false;
        end if;
        
        return wb_retorno;    
    end;
  
    procedure pr_incluirEmp(wp_emp in out pk_estrutura_dados.tp_emp)
    is
      wl_chave number;
    begin

        select nvl(max(empno),0) + 1
        into wp_emp.empno
        from emp;
        
        insert into EMP ( empno   ,
                          ename    ,
                          job        ,
                          mgr       ,
                          hiredate ,
                          sal          ,
                          comm    ,
                          deptno  ,
                          owner)
                  values( wp_emp.empno,
                          wp_emp.ename,
                          wp_emp.job,
                          wp_emp.mgr,
                          wp_emp.hiredate,
                          wp_emp.sal,
                          wp_emp.comm,
                          wp_emp.deptno,
                          wp_emp.owner);
                                      
    end;
    
    
    procedure pr_alterarEmp(wp_emp pk_estrutura_dados.tp_emp)
    is
    
    begin
    
          update EMP d
                        set   ename       = wp_emp.ename,
                                 job      = wp_emp.job,
                                 mgr      = wp_emp.mgr,
                                 hiredate =  wp_emp.hiredate,
                                 sal      = wp_emp.sal,
                                 comm     = wp_emp.comm,
                                 deptno   = wp_emp.deptno,
                                 owner    = wp_emp.owner
          where   empno = wp_emp.empno;
            
    end;
    
    
    procedure pr_excluirEmp(wp_emp pk_estrutura_dados.tp_emp)
    is
    
    begin
      
          delete EMP where empno = wp_emp.empno;
    
    end;
    
    function fc_recuperarEmps
    return pk_estrutura_dados.tb_emp
    is
               
       wl_tb_emp pk_estrutura_dados.tb_emp;
      
    begin
       
          select * 
          BULK COLLECT INTO wl_tb_emp
          from emp;
          
          return wl_tb_emp;
          
    end;
    
    function fc_busca_filtro(wp_filtro pk_estrutura_dados.ft_emp)
    return pk_estrutura_dados.tb_emp
    is
       cs_emp pk_estrutura_dados.ref_cursor;
       
       wl_sql varchar2(4000) := '';
       wl_tb_emp pk_estrutura_dados.tb_emp;
       wl_tp_emp pk_estrutura_dados.tp_emp;
       
       i number := 1;
       
       bInseriWhere boolean := false;
       bAnd         boolean := false;
       
    begin
    
        if wp_filtro.empno is null and
           wp_filtro.ename is null and
           wp_filtro.job   is null and
           wp_filtro.hiredate_min is null and
           wp_filtro.hiredate_max is null and
           wp_filtro.sal_min      is null and
           wp_filtro.sal_max      is null and
           wp_filtro.deptno       is null and
           wp_filtro.owner        is null then
           
            wl_sql := 'select * from EMP ';
        
        else
          
            wl_sql := 'select * from EMP where ';
            
            if (wp_filtro.sal_min is not null) and
               (wp_filtro.sal_max is not null) then
    
               wl_sql := wl_sql || 'sal >= '||wp_filtro.sal_min||' and ';
               wl_sql := wl_sql || 'sal <= '||wp_filtro.sal_max;
               bInseriWhere := true;
               bAnd := true;
    
            elsif (wp_filtro.sal_min is not null) and
                  (wp_filtro.sal_max is null) then
    
               wl_sql := wl_sql || 'sal >= '||wp_filtro.sal_min;
               bInseriWhere := true;
               bAnd := true;
               
            elsif (wp_filtro.sal_min is null) and
                  (wp_filtro.sal_max is not null) then
    
               wl_sql := wl_sql || 'sal <= '||wp_filtro.sal_max;
               bInseriWhere := true;
               bAnd := true;               
      
            end if;
            
            if wp_filtro.deptno is not null then
               
               if bAnd then
               
                 wl_sql := wl_sql || ' and deptno = '||wp_filtro.deptno;
                 bInseriWhere := true;
                 bAnd := true;                             
               else
                 wl_sql := wl_sql || ' deptno = '||wp_filtro.deptno;
                 bInseriWhere := true;
                 bAnd := true;          
                 
              end if;
               
            end if;
            
            if wp_filtro.owner is not null then
            
               if bAnd then
                  wl_sql := wl_sql || ' and owner = '||wp_filtro.owner;              
               else 
                  wl_sql := wl_sql || ' owner = '||wp_filtro.owner;                             
               end if;
            
            end if;
                      
            if not bInseriWhere then
              RAISE_APPLICATION_ERROR(PK_ESTRUTURA_DADOS.code_filtro_invalido,
                                      PK_ESTRUTURA_DADOS.erro_filtro_invalido);
            end if;
            
        end if;
        
        open cs_emp for wl_sql;
        
        loop
            fetch cs_emp into wl_tp_emp;
            exit when cs_emp%NotFound;
            wl_tb_emp(i) := wl_tp_emp;
            i := i +1;            
        end loop;
        
        close cs_emp;
        
        return wl_tb_emp;
        
    exception
      when others then
        dbms_output.put_line('FILTRO DE CONSULTA NÃO PREVISTO, FAVOR AJUSTAR!');        
    end;

end PK_CADASTRO_EMP; 
/
show errs;