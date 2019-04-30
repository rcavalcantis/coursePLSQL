declare

  wl_filtro pk_estrutura_dados.ft_emp;
  wl_emp    pk_estrutura_dados.tb_emp;
  

begin

  wl_filtro.sal_min := 1000;
  wl_filtro.sal_max := null;
  wl_filtro.deptno  := 10;
    
  wl_emp := PK_CADASTRO_EMP.FC_BUSCA_FILTRO(wl_filtro);
  
  dbms_output.put_line('----- BUSCA EMP POR FILTRO -----');  
  for i in 1..wl_emp.count() 
  loop
    dbms_output.put_line('-- Código.:'||wl_emp(i).empno);
    dbms_output.put_line('-- Nome...:'||wl_emp(i).ename);  
    dbms_output.put_line('-- Salario:'||wl_emp(i).sal);      
    dbms_output.put_line('-- Depart.:'||wl_emp(i).deptno);          
    dbms_output.put_line('*************************************');          
  end loop;

end;