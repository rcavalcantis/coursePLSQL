/*
CURSOR EXPLÍCITO
*/
declare

    cursor cs_emp is
           select * from emp
           where sal > 2000;
            
    wl_rc_emp emp%rowtype;
    wl_tb_emp PK_ESTRUTURA_DADOS.tb_emp;
    i number := 0;
          
begin

    open cs_emp;

    loop  
        fetch cs_emp into wl_rc_emp;
        exit when cs_emp%NotFound;        
        i := i + 1;
        dbms_output.put_line(wl_rc_emp.empno ||' - '
                                          ||wl_rc_emp.ename  ||' - '
                                          ||wl_rc_emp.sal);
                                          
        wl_tb_emp(i) := wl_rc_emp;

    end loop;
    
    close cs_emp;

exception

  when others then
    dbms_output.put_line('erro');

end;