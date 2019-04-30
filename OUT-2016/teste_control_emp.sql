declare

  wl_filtro pk_estrutura_dados.ft_emp;
  wl_emp    pk_estrutura_dados.tb_emp;
  wl_reajuste number(5,2);
  --wl_dept   pk_estrutura_dados.tp_depto;

begin

  wl_filtro.sal_min := null;
  wl_filtro.sal_max := null;
  wl_reajuste  := -12;

  PK_CONTROL_EMP.PR_IMPRIMIR_EMPS(wl_filtro);
  --PK_CONTROL_EMP.PR_REAJUSTE_SALARIO(wl_reajuste, wl_filtro);
  --PK_CONTROL_EMP.PR_IMPRIMIR_EMPS(wl_filtro);

end;