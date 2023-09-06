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

update T1 set c2 =4000 where c1=3000;
delete from T1;