create or replace
package pk_estrutura_dados
is

  type tp_emp is record (
       EMPLOYEE_ID      employee.EMPLOYEE_ID%type,
       LAST_NAME        employee.LAST_NAME%type,
       FIRST_NAME       employee.FIRST_NAME%type,
       CONTROLE         employee.CONTROLE%type,
       MANAGER_ID       employee.MANAGER_ID%type,
       HIRE_DATE        employee.HIRE_DATE%type,
       SALARY           employee.SALARY%type,
       COMMISSION       employee.COMMISSION%type,
       DEPARTMENT_ID    employee.DEPARTMENT_ID%type);
              
  type tp_dep is record (
       DEPARTMENT_ID    department.department_id%type,
       NAME_DEP         department.name_dep%type,
       LOCATION_ID      department.location_id%type,
       DELECAO_LOGICA   department.delacao_logica%type);
                          
  type tp_job is record (
       JOB_ID           jobs.job_id%type,
       FUNCTION_JOB     jobs.function_job%type);
       
  type rf_cursor is ref cursor;
  
  type tp_tb_emp is table of tp_emp index by BINARY_INTEGER;
  
  wg_emp_cd_geral number          := -20500;
  wg_emp_tx_geral varchar2(4000)  := 'REGISTRO JÁ EXISTENTE';
  
  e_empno_null   exception;
  
         

end pk_estrutura_dados;
/