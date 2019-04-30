create or replace package pk_controlador_init
is
  procedure pr_init_carga(wp_rg_emp in out pk_estrutura_dados.tp_emp,
                          wp_qtd number, wp_perc number);

  procedure pr_limpar_carga(wp_rg_emp pk_estrutura_dados.tp_emp);
  
  
  procedure pr_init_carga_AL01(wp_rg_emp in out pk_estrutura_dados.tp_emp,
                          wp_qtd number, wp_perc number);

  procedure pr_limpar_carga_AL01(wp_rg_emp pk_estrutura_dados.tp_emp);

   

end pk_controlador_init;
/

create or replace package body pk_controlador_init
is
  
  procedure pr_init_carga(wp_rg_emp in out pk_estrutura_dados.tp_emp,
                          wp_qtd number, wp_perc number)
  is
    wl_nome varchar2(15);
  begin
  
    wl_nome := wp_rg_emp.first_name;
        
    for i in 1..wp_qtd loop
      
      pk_controlador_emp.pr_inserir_emp(wp_rg_emp);      
      pk_controlador_emp.pr_reajustar_sal(wp_rg_emp,wp_perc);
      
      wp_rg_emp.employee_id := NULL;
      wp_rg_emp.first_name  := wl_nome;
    
    end loop;
    
    commit;
  
  exception
    
     when others then
     begin
       rollback;
       dbms_output.put_line(SQLCODE ||''||SQLERRM);
     
     end;
        
    
  end pr_init_carga;
  
  procedure pr_limpar_carga(wp_rg_emp pk_estrutura_dados.tp_emp)
  
  is
    wl_tb_emp  pk_estrutura_dados.tp_tb_emp;
    
  begin
     
     wl_tb_emp := pk_controlador_emp.fc_consultar_emp(wp_rg_emp);
     
     for i in 1..wl_tb_emp.count loop
     
       pk_controlador_emp.pr_excluir_emp(wl_tb_emp(i));
          
     end loop;
     
     commit;
  
  end pr_limpar_carga;


  procedure pr_init_carga_AL01(wp_rg_emp in out pk_estrutura_dados.tp_emp,
                               wp_qtd number, wp_perc number)
  is
  
  begin
     
     pk_interface.pr_init_carga(wp_rg_emp,
                                wp_qtd   ,
                                wp_perc  );
     
  end;
  

  procedure pr_limpar_carga_AL01(wp_rg_emp pk_estrutura_dados.tp_emp)
  
  is
  
  begin

     pk_interface.pr_limpar_carga(wp_rg_emp);
  
  end pr_limpar_carga_AL01;


end pk_controlador_init;
/