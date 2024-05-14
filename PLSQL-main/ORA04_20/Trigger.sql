create table t1(c1 number,c2 number);
create table t1_repliq as select * from t1 where 1=0;

create or replace trigger t1_replikacja
after insert or update or delete on t1
for each row
begin
if inserting then
insert into t1_repliq(c1,c2) values (:new.c1,:new.c2);
elsif updating then
update t1_repliq set c1 = :new.c1, c2=:new.c2 where c1 =: old.c1;
elsif deleting then
delete from t1_repliq where c1=:old.c1;
end if;
end;