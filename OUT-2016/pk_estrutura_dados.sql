create or replace
package pk_estrutura_dados
is

  type tp_depto is record (deptno  dept.deptno%type,
                                             dname   dept.dname%type,
                                             loc     dept.loc%type);

  type tb_depto is table of tp_depto
           index by binary_integer;

  type tp_emp  is record (empno   emp.empno%type,
                          ename   emp.ename%type,
                          job       emp.job%type,
                          mgr       emp.mgr%type,
                          hiredate emp.hiredate%type,
                          sal          emp.sal%type,
                          comm    emp.comm%type,
                          deptno   emp.deptno%type,
                          owner   emp.owner%type);
  
  type tb_emp is table of emp%rowtype  index by binary_integer;
  
  type ft_emp is record(empno   emp.empno%type,
                       ename   emp.ename%type,
                       job       emp.job%type,
                       hiredate_min emp.hiredate%type,
                       hiredate_max emp.hiredate%type,
                       sal_min   emp.sal%type,
                       sal_max  emp.sal%type,
                       deptno    emp.deptno%type,
                       owner    emp.owner%type);
                                         
  type ref_cursor  is ref cursor;                                         

  /* DEFINIÇÃO DE EXCEÇÕES*/
  
  code_registro_duplicado  number := -20001;
  erro_registro_duplicado   varchar2(100) := 'REGISTRO JÁ EXISTE';
  code_registro_inexistente number := -20002;
  erro_registro_inexistente  varchar2(100) := 'REGISTRO NÃO EXISTE';

  code_filtro_invalido number       := -20003;
  erro_filtro_invalido varchar2(100):= 'Filtro de pesquisa inválido! Mude o critério.';
  

end pk_estrutura_dados;
/
show errs;
