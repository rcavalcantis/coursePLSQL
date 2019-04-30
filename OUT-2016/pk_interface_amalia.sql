create or replace 
package PK_INTERFACE_AMALIA
is

  procedure pr_carregar_emp(qtd number, owner varchar2);
  
end;
/
create or replace package body PK_INTERFACE_AMALIA
is

  procedure pr_carregar_emp(qtd number, owner varchar2)
  is
  begin
    dbms_output.put_line('ESTOU NA PORTA DE SAIDA PARA O SISTEMA DE AMÁLIA!!!');   
    for i in 1..qtd 
    loop
          dbms_output.put_line('INSERI O REGISTRO: '||i);
    end loop;
    
  end;
  
end;
/
show errs;