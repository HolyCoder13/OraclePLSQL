declare
    v_sum number;
begin
    v_sum:=0;
    dbms_output.put_line ('suma przed inkrmeentacja '||to_char(v_sum));
    for i in 1..200 loop
    v_sum:=v_sum+i;
    dbms_output.put_line ('suma w trakcie inkr '||to_char(i)||' suma to '||to_char(v_sum));
    end loop;
end;

create table t_name(id number);
commit;


insert into T3 values (1,1);
insert into T3 values(2,2);
commit;
rollback;
select * from T3;
update T3
set c2 = 200 where c1 = 2;



CREATE OR REPLACE PROCEDURE PROCEDURE6 
(
  P1 IN VARCHAR2 
, P2 IN NUMBER 
) AS 
ex_duplikat exception;
pragma exception_init(ex_duplikat,-1);
BEGIN
    insert into T1(C1,C2) values (P1,P2);
    exception
    when ex_duplikat then
    raise_application_error(-20001,'NIe udalo sie wproawdzic wartosci'||p1||' do tabeli');
    end;
    
    
  NULL;
END PROCEDURE6;
select * from t1;
begin;
    PROCEDURE6(8,3);
    --rollback;
    end;


create table t1_replika as select * from t1 where 1=2; 
commit;
