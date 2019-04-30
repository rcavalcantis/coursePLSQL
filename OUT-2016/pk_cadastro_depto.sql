create or replace
package PK_CADASTRO_DEPTO
is

    function fc_existeDept(wp_deptno number)
    return boolean;
    
    /*sobrecarga de método*/
    function fc_existeDept(wp_dname varchar2)
    return boolean;
    
    procedure pr_incluirDept(wp_depto pk_estrutura_dados.tp_depto);
    
    procedure pr_alterarDept(wp_depto pk_estrutura_dados.tp_depto);
                                                
    procedure pr_excluirDept(wp_deptno number);                                                
    
    procedure pr_listarDept(wp_deptno dept.deptno%type default null);
    
    function fc_recuperarDepts return pk_estrutura_dados.tb_depto; 
    
    function fc_consulta_dept(wp_deptno number) return pk_estrutura_dados.tp_depto;
    

end PK_CADASTRO_DEPTO;
/

create or replace
package body PK_CADASTRO_DEPTO
is

function fc_existeDept(wp_deptno number)
return boolean
is
    wl_count number;
    wb_retorno boolean;
begin

    select 
        count(1) into wl_count
    from DEPT where deptno = wp_deptno;
    
    if wl_count > 0 then
        wb_retorno := true;
    else
        wb_retorno := false;
    end if;
    
    return wb_retorno;    

end;


function fc_existeDept(wp_dname varchar2)
return boolean
is
    wl_count number;
    wb_retorno boolean;
begin

    select 
        count(1) into wl_count
    from DEPT where dname like ('%'||wp_dname||'%');
    
    if wl_count > 0 then
        wb_retorno := true;
    else
        wb_retorno := false;
    end if;
    
    return wb_retorno;    

end;



procedure pr_incluirDept(wp_depto pk_estrutura_dados.tp_depto)
is

begin

    insert into DEPT (deptno, dname, loc) values
                     (wp_depto.deptno, wp_depto.dname, wp_depto.loc);
                               
    dbms_output.put_line('Departamento '||upper(wp_depto.dname)
                                      ||' inserido com SUCESSO!');                                  
    
    commit;

exception

    when DUP_VAL_ON_INDEX then
        rollback;
        dbms_output.put_line('Registro '||wp_depto.deptno||' já existe!'
                             || 'erroORA'||sqlcode);

    when others then
        rollback;
        dbms_output.put_line('Falha na INSERÇÃO!');
        dbms_output.put_line('sqlcode: '||sqlcode);
        dbms_output.put_line('sqlerrm: '||SQLERRM);
        dbms_output.put_line('backtrace: '||
                              DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
end;

procedure pr_alterarDept(wp_depto pk_estrutura_dados.tp_depto)
is

begin

      if fc_existeDept(wp_depto.deptno) then
      
          update DEPT d
                set   d.dname  = wp_depto.dname,
                      d.loc    = wp_depto.loc
          where       d.deptno = wp_depto.deptno;
        
          dbms_output.put_line('Departamento '||wp_depto.dname
                                              ||' alterado com SUCESSO!');                                          
          
          commit;
      else

          dbms_output.put_line('Departamento '||wp_depto.dname
                                            ||' não existe!');                                          
      end if;          

exception
      
      when others then
        rollback;
        dbms_output.put_line('Falha na ALTERAÇÃO!');
        dbms_output.put_line('sqlcode: '||sqlcode);
        dbms_output.put_line('sqlerrm: '||SQLERRM);
        dbms_output.put_line('backtrace: '||
                              DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
end;

procedure pr_excluirDept(wp_deptno number)
is

begin
  
      if fc_existeDept(wp_deptno) then
          delete dept where deptno = wp_deptno;
          dbms_output.put_line('Departamento '||wp_deptno
                                            ||' excluído com SUCESSO!');                                          
          commit;
      else
          dbms_output.put_line('Departamento INEXISTENTE!');                                          
      end if;


exception
    when others then
        rollback;
        dbms_output.put_line('Falha na EXCLUSÃO!');                                          
        dbms_output.put_line('sqlcode: '||sqlcode);
        dbms_output.put_line('sqlerrm: '||SQLERRM);
        dbms_output.put_line('backtrace: '||
                              DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
end;

procedure pr_listarDept(wp_deptno dept.deptno%type default null)
is

  wl_rc_depto PK_ESTRUTURA_DADOS.tp_depto; 
  wl_tb_depto PK_ESTRUTURA_DADOS.tb_depto;

  procedure listaTotal
  is
  begin
    select * 
    BULK COLLECT INTO wl_tb_depto
    from dept d;

    for i in 1..wl_tb_depto.count 
    loop
    
        wl_rc_depto := wl_tb_depto(i);
        
        dbms_output.put_line('-------------');
        dbms_output.put_line('Departamento: '||wl_rc_depto.deptno||
                                        ' - '||wl_rc_depto.dname||
                                        ' - '||wl_rc_depto.loc);
    end loop;   
  end;
  
begin

    if wp_deptno is null then

      listaTotal;

    else          
      begin
  
          select * 
          --BULK COLLECT INTO wl_tb_depto
          into wl_rc_depto
          from dept d
          where d.DEPTNO = wp_deptno;
          
          dbms_output.put_line('-------------');
          dbms_output.put_line('Departamento: '||wl_rc_depto.deptno||
                                          ' - '||wl_rc_depto.dname||
                                          ' - '||wl_rc_depto.loc);
          
      exception
          when NO_DATA_FOUND then
              begin
                  dbms_output.put_line('-- REGISTRO '||wp_deptno||' INEXISTENTE! --');      
                  dbms_output.put_line('-- CONSULTE POR UM DOS DEPTO ABAIXO --');      
                  listaTotal;
              end;
      end;
      
    end if;
end;

function fc_recuperarDepts
return pk_estrutura_dados.tb_depto
is
           
   wl_tb_depto pk_estrutura_dados.tb_depto;
  
begin
   
      select * 
      BULK COLLECT INTO wl_tb_depto
      from dept d;
      
      return wl_tb_depto;
      
end;


function fc_consulta_dept(wp_deptno number) return pk_estrutura_dados.tp_depto
is
   wl_rc_depto pk_estrutura_dados.tp_depto;
begin
   
      select * 
      into wl_rc_depto
      from dept d
      where d.DEPTNO = wp_deptno;

      
      return wl_rc_depto;
      
end;


end PK_CADASTRO_DEPTO; 
/
show errs;