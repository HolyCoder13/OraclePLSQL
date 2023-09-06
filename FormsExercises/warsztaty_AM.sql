create table t1 ( c1 INTEGER);




create or replace procedure cw1( wejsciowy number default 1000000)
is
begin
for i in 1..wejsciowy LOOP
insert into t1(c1) values(i);
end loop;
end;


begin
cw1(7);
end;

--4

create table t6 (c1 INTEGER, t varchar2(50), col varchar2(40) );

create or replace procedure cw4(
wejsciowy number default 1000000,
tname in varchar2 default 't5',
tcol in varchar2 default 'col')
is
begin
for i in 1..wejsciowy LOOP
insert into tname(tcol) values (i);
end loop;
end;


begin
cw4(7,'t5','c5');
end;


begin
cw4(wejsciowy => 7, tname => 't4', tcol => 'col');
end;

create or replace procedure cw4v3(
wejsciowy number default 1000000,
tname in varchar2 default 't6',
tcol in varchar2 default 'col')
is
begin
for i in 1..wejsciowy LOOP
execute immediate 'insert into' || tname || '(' || tcol || ') values (:i)'
using i;
end loop;
end;

select * from t6;

begin
cw4v3(50,'t6','col');
end;
