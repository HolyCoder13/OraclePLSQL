Create table student07.plyty(
id_plyty number(8),
tytul varchar2(50 Byte),
rok_wydania number(4),
data_premiery date,
kategoria varchar2(3 byte),
czas number(6,2),
cena number(4,2)
);

create table student07.wykonawcy(
id_wykonawcy number(5),
zespol char(1 byte)
);

create table student07.utwory(
id_utworu number(8),
id_wykonawcy number(5),
tytul varchar2(50 byte),
jezyk varchar2(20 byte),
czas_trwania number(5,2)
);

create table student07.utwory_na_plycie(
id_plyty number(8),
id_utworu number(8),
nr number(3),
nr1 number(4)
);

--2

alter table student07.wykonawcy modify id_wykonawcy primary key;
--alter table student07.wykonawcy add constraint wykonawcy_pk id_wykonawcy primary key;
alter table student07.utwory modify id_utworu primary key;
alter table student07.plyty modify id_plyty primary key;

select * from user_constraints where table_name='student07.plyty';

ALTER table utwory add constraint utwory_fk foreign key (id_wykonawcy) references wykonawcy(id_wykonawcy);
alter table utwory_na_plycie add constraint utwory_na_plycie_fk foreign key (id_plyty) references plyty(id_plyty);
alter table utwory_na_plycie add constraint utwory_na_plycie_fk foreign key (id_utworu) references utwory(id_utworu);

alter table wykonawcy modify zespol not null;
alter table utwory modify (tytul not null, jezyk not null, czas_trwania not null);
alter table plyty modify (tytul not null, rok_wydania not null, kategoria not null, czas not null, cena not null);


alter table wykonawcy add historia varchar2(250);
alter table plyty add opis varchar2(250);
alter table plyty modify (czas number(5,2),cena number(5,2));
alter table wykonawcy modify ( zespol varchar2(250)  );

alter table utwory_na_plycie drop column nr1;

alter table plyty modify (czas check(czas>0), rok_wydania check(rok_wydania>1800), data_premiery check(to_char(data_premiery,'yyyy-mm--dd')>'1800-12-31'),
cena check(cena>=0));

alter table utwory modify (czas_trwania check(czas_trwania>0));