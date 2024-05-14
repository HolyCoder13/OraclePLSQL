create table nabywcy_am(
kod number(4) primary key,
nazwa varchar2(15) not null,
nip varchar2(10),
adres varchar2(40) not null
);

drop table faktury_am;
create table faktury_am(
nr_faktury number(4) primary key,
data_wystawienia date DEFAULT sysdate,
wartosc number(10,2) not null,
platnosc varchar2(1) check(platnosc in('p','g')),
dla_kogo number(4) REFERENCES nabywcy_am(kod) not null
);

create table towary_am(
id_towaru number(3) primary key,
nazwa varchar2(30) not null,
stan number(10,2) check(stan>=0) not null
);

create table towary_na_fakturze_am(
nr_faktury number(4) references faktury_am(nr_faktury),
nr_towaru number(3) references towary_am(id_towaru),
ilosc number(10,2) check(ilosc>0) not null
);

select * from nabywcy_am;
describe nabywcy_am;

--2
--insert into nabywcy_am values
insert into nabywcy_am values (1,'KUL','1234567890','Lublin');
insert into nabywcy_am (kod,nazwa, nip, adres) values (2,'UMCS','1234567891','Lublin');
insert into nabywcy_am values ('3','PL','1234567890','Lublin');--insert into nabywcy values ('a','PL','1234567890','Lublin');
insert into nabywcy_am values (4,'WSZA','1234567894','Lublin');

--3
insert all   --all
 into towary_am values (1, 'komputer',3)
 into towary_am values (2, 'drukarka',5)
 into towary_am values (3, 'papier',6)
 into towary_am values (4, 'laptop',1)
 into towary_am values (5, 'dlugopis',15)
select 1 from dual;  -- false select to remain select in command, we insert data manually

select * from towary_am;

alter table nabywcy_am
add (kraj varchar2(15));
select * from nabywcy_am;
update nabywcy_am set kraj='Polska';

alter table
nabywcy_am
modify (kraj varchar2(15) not null);

update nabywcy_am set kraj='Niemcy' where kod = (select max(kod) from nabywcy_am);

insert into nabywcy_am values (5, 'Uni.de Paris', '4567892341','Pary¿', 'Francja');

select * from towary_am;
update towary_am set stan=stan+100 where id_towaru in(2,3,5);

alter table nabywcy_am modify adres varchar2(50);

create sequence s_am start with 11 increment by 1;

insert into towary_am values (s_am.nextval,'biurko',2);
insert into towary_am values (s_am.nextval,'krzeslo',2);

drop table faktury_am cascade constraints;


create table nabywcy_am(
kod number(4) primary key, --constraint pk_n primary key
nazwa varchar2(15) not null,
nip varchar2(10),
adres varchar2(40) not null
--constraint pk_n primary key(kod)  --primary key(kod)
);
select * from user_constraints;

create table faktury_am(
nr_faktury number(4) primary key, --constraint pk_f primary key
data_wystawienia date DEFAULT sysdate,
wartosc number(10,2) not null,
platnosc varchar2(1), --check(platnosc in('p','g')),   --constraint plat_check check(platnosc in('p','g')),
dla_kogo number(4) REFERENCES nabywcy_am(kod) not null
constraint plat_check check(platnosc in('p','g'))
);

select * from srednie_w_oddzialach_am;

CREATE TABLE srednie_w_oddzialach_am(
    id_oddzialu NUMBER(4) CONSTRAINT id_oddzialu_pk PRIMARY KEY,
    nazwa_oddzialu VARCHAR2(30) NOT NULL,
    srednia NUMBER(8,2) NOT NULL);
    
    
    
    
    create table stanowiska_2005a as
    select * from hr.jobs where 0=1; --copy of structure
    
    select * from stanowiska_2005am;
    
    