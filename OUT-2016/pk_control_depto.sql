create or replace
package pk_control_depto
is

    procedure pr_incluir(wp_dept pk_estrutura_dados.tp_depto);
    
    procedure pr_alterar(wp_dept pk_estrutura_dados.tp_depto);
                                                
    procedure pr_excluir(wp_dept pk_estrutura_dados.tp_depto);                                                
    
    procedure pr_listarDepts;

end pk_control_depto;
/

create or replace
package body pk_control_depto
is
    
    procedure pr_incluir(wp_dept pk_estrutura_dados.tp_depto)
    is
    
    begin
      
        pk_cadastro_depto.pr_incluirdept(wp_dept);
        
        commit;
        
    exception
        when DUP_VAL_ON_INDEX then
            rollback;
            dbms_output.put_line(pk_estrutura_dados.erro_registro_duplicado);
        when others then
            rollback;
            dbms_output.put_line(sqlcode ||' - '|| sqlerrm 
                                                || ' pk_control_depto.pr_incluir');
    end;


    procedure pr_alterar(wp_dept pk_estrutura_dados.tp_depto)
    is
    
    begin
    
        if pk_cadastro_depto.fc_existedept(wp_dept) then
            pk_cadastro_depto.pr_alterardept(wp_dept);
        else
            pk_cadastro_depto.pr_incluirdept(wp_dept);
        end if;

        commit;
        
    exception
        when others then
            rollback;
            dbms_output.put_line(sqlcode ||' - '|| sqlerrm 
                                                || ' pk_control_depto.pr_alterar ');
    end;

    procedure pr_excluir(wp_dept pk_estrutura_dados.tp_depto)
    is
    
    begin
    
        if pk_cadastro_depto.fc_existedept(wp_dept) then
            pk_cadastro_depto.pr_excluirdept(wp_dept);
        else
            RAISE_APPLICATION_ERROR(pk_estrutura_dados.code_registro_inexistente,
                                                           pk_estrutura_dados.erro_registro_inexistente);
        end if;

        commit;
        
    exception
        when others then
            rollback;
            dbms_output.put_line(sqlcode ||' - '|| sqlerrm 
                                                || ' pk_control_depto.pr_excluir ');
    end;
    
    procedure pr_listarDepts
    is
        wl_lista pk_estrutura_dados.tb_depto;
    begin
    
        wl_lista := pk_cadastro_depto.fc_recuperardepts;
        
        dbms_output.put_line('*** LISTAGEM DE DEPARTAMENTOS INSTRUTOR***');
        for i in 1..wl_lista.count 
        loop
        
            dbms_output.put_line(i || ' - ' || wl_lista(i).deptno
                                                   ||' : '||wl_lista(i).dname 
                                                   ||' - '||wl_lista(i).loc);
        
        end loop;
        
        pk_interfacealuno5.pr_listardepts;
    
    end;
    
    
end pk_control_depto;
