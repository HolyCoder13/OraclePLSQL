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
  P1 IN VARCHAR2,
  P2 IN NUMBER 
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
    
    
    create or replace trigger tr_przyklad
    for Update on T1
    compound trigger
    v_licznik Number(10);
    
    before statement is
    begin
    dbms_output.put_line('Przed updatem raz dla polecenia');
    v_licznik:=0;
    end before statement;
    
    before each row is
    begin
     dbms_output.put_line('Przed updatem dla rekordu ='||:OLD.c1);
     end before each row;
     after each row is
     begin
      dbms_output.put_line('Po updacie dla rekordu= '||:NEW.c1);
      v_licznik:=v_licznik+1;
      end after each row;
      after statement is
      begin
      dbms_output.put_line('Po updacie dla polecenia');
      dbms_output.put_line('liczba wstawionych rekordow '||v_licznik);
      end after statement;
      end tr_przyklad;
    
    create or replace trigger tr_dziennik
    after insert or update or delete on T1
    declare
    v_operacja varchar2(10);
    v_liczba_rek number;
    begin
    case
    when inserting then v_operacja :='INSERT'  ;
    when updating then v_operacja :='UPDATE'  ;
    when deleting then v_operacja :='DELETE'  ;
    end case;
    select count(*) into v_liczba_rek from T1;
    Insert into dziennik
    (data,uzytkownik,operacja,tabela,liczba_rekordow)
    values
    (sysdate,user,v_operacja,'T1'v_liczba_rek);
    end;
    
    create table dziennik(
    data date, uzytkownik varchar2(20), operacja varchar2(10), tabela varchar2(100), liczba_rekordow number);
--1
 create or replace trigger tr_ograniczenie
    before insert or update on T1
    for each row
    
    declare
    ex_negative exception;
    pragma exception_init(negative_value_exception,-20001);
    
    begin
    exception
    when ex_negative then
   raise_application_error(-20001,'Wartosc w kolumnie c2 musi byc dodatnia');

    end;
    
Insert into T1(c2) values (-1);

--2
create table t1_replika as select * from t1 where 1=2; 
commit;

create or replace trigger t1_replikacja
after insert or update or delete on T1
for each row
begin
if inserting then
insert into T1_replika (c1,c2) values (:new.c1,:new:c2);
elsif updating then
update T1_replika set c1 = :new.c1, c2=:new.c2 where c1 =: old.c1;
elsif deleting then
delete from T1_replika where c1=:old.c1;
end if;
end;

insert into T1(c1,c2) values (3,4);
