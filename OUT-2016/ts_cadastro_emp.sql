declare

  wl_tabela pk_estrutura_dados.tb_emp;
  wl_registro pk_estrutura_dados.tp_emp;
  wl_resultado varchar2(100);

begin

    
    dbms_output.put_line('*** TESTE CADASTRO EMPREGADOS ***');
    dbms_output.put_line('  ');
    dbms_output.put_line(' ## Teste INSERIR ##');
    
    wl_registro.empno := 100;
    wl_registro.ename := 'RODRIGO';
    wl_registro.job := 'ANALISTA';
    wl_registro.mgr := 2103;
    wl_registro.hiredate := SYSDATE;
    wl_registro.sal := 23500;
    wl_registro.comm := 1200;
    wl_registro.deptno := 40;

    begin
        pk_cadastro_emp.pr_incluirEMP(wl_registro);
        dbms_output.put_line('pk_cadastro_emp.pr_incluirEMP SUCESSO!!!');
    exception
        when others then
        dbms_output.put_line('pk_cadastro_emp.pr_incluirEMP FALHOU!!!');
        rollback;
    end;

    dbms_output.put_line('  ');
    dbms_output.put_line(' ## Teste ALTERAR ##');
    
    wl_registro.empno := 100;
    wl_registro.ename := 'RODRIGO';
    wl_registro.job := 'ANALISTA';
    wl_registro.mgr := 2103;
    wl_registro.hiredate := SYSDATE;
    wl_registro.sal := 23500 / 2;
    wl_registro.comm := 0;
    wl_registro.deptno := 10;
    
    begin
        pk_cadastro_emp.pr_alterarEmp(wl_registro);
        
        select count(*) into wl_resultado 
              from DEPT where deptno = wl_registro.deptno;
              
        if wl_resultado = '1' then
              dbms_output.put_line('pk_cadastro_emp.pr_incluirEMP SUCESSO!!!');
        else
            RAISE_APPLICATION_ERROR(-20001,'pk_cadastro_emp.pr_incluirEMP FALHOU!!!');
        end if;
    exception
        when others then
        dbms_output.put_line(sqlcode ||' - '|| sqlerrm);
        rollback;
    end;


    begin
        dbms_output.put_line('  ');
        dbms_output.put_line(' ## Teste EXCLUIR ##');
        
        pk_cadastro_emp.pr_excluirEmp(wl_registro);
        
        select count(1) into wl_resultado 
              from EMP where empno = wl_registro.empno;
        if wl_resultado = '0' then
            dbms_output.put_line('pk_cadastro_emp.pr_excluirEMP SUCESSO!!!');
        else
            RAISE_APPLICATION_ERROR(-20002,'pk_cadastro_emp.pr_excluirEMP FALHOU!!!');
        end if;
    exception
        when others then
        dbms_output.put_line(sqlcode ||' - '|| sqlerrm);
        dbms_output.put_line('pk_cadastro_emp.pr_excluirEMP FALHOU!!!');        
        rollback;
    end;
    
    begin
        dbms_output.put_line('  ');
        dbms_output.put_line(' ## Teste RECUPERAR ##');
    
        wl_tabela := pk_cadastro_emp.fc_recuperarEmps;
    
        if wl_tabela.count = 14 then
            dbms_output.put_line('pk_cadastro_emp.fc_recuperarEmps SUCESSO!!!');
        else
            RAISE_APPLICATION_ERROR(-20003,'pk_cadastro_emp.fc_recuperarEmps FALHOU!!!');
        end if;
    exception
        when others then
        dbms_output.put_line(sqlcode ||' - '|| sqlerrm);
        rollback;
    end;


    begin
        dbms_output.put_line('  ');
        dbms_output.put_line(' ## Teste EXISTE ##');
    
        if  NOT pk_cadastro_emp.fc_existeEmp(wl_registro) then
            dbms_output.put_line('pk_cadastro_emp.fc_existeEmp SUCESSO!!!');
        else
            RAISE_APPLICATION_ERROR(-20005,'pk_cadastro_emp.fc_existeEmp  FALHOU!!!');
        end if;
    exception
        when others then
        dbms_output.put_line(sqlcode ||' - '|| sqlerrm);
        rollback;
    end;
    
    rollback;
end;