drop table t1_test;
create table t1_test(c1 numeric);

create or replace procedure cw1( wejscie number default 1000000)
is
begin
for i in 1..wejscie LOOP
insert into t1_test(c1) values(i);
end loop;
end;

begin
cw1(77);
end;

select * from t1_test;

--4

create or replace procedure cw4(
wejscie number default 1000000,
tabela in varchar2,
kolumna in varchar2
)
is
begin
for i in 1..wejscie LOOP
insert into tabela(kolumna) values wejscie;
end loop;
end;

begin
cw4(45,'t1_test','c1');
end;

--version 2

create or replace procedure cw4(
wejscie number default 1000000,
tabela in varchar2 default 't1_test',
kolumna in varchar2 default 'c1'
)
is
begin
execute immediate 'truncate table' || tabela;
for i in 1..wejscie LOOP
EXECUTE IMMEDIATE 'INSERT INTO' || tabela || '(' || kolumna || ') VALUES (' || wejscie || ')';
end loop;
end;

begin
cw4();
end;
--