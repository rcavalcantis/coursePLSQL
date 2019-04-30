create or replace
PACKAGE BODY PK_CONTROL_EMP AS

PROCEDURE PR_INCLUIR_CTRL(wp_rec_emp in out PK_ESTRUTURA_DADOS.tp_rec_emp)
is

BEGIN
  if not PK_CADASTRO_EMP.FC_EXISTE(wp_rec_emp) then
     PK_CADASTRO_EMP.PR_INCLUIR(wp_rec_emp);
  else
     raise_application_error(-20000,'EMPREGADO JÁ CADASTRADO! - FALHOU');
  end if;
END PR_INCLUIR_CTRL;

END PK_CONTROL_EMP;