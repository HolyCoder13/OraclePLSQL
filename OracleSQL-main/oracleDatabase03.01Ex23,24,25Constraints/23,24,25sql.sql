--23

Create table Klienci_am(
id_klienta number(10) primary key,
imie varchar2(50) not null,
nazwisko varchar2(50) not null,
miejscowosc varchar2(50),
telefon varchar(15));

Create table Loty_am(
id_lotu number(10) primary key,
data_lotu date not null,
id_rozkladu_lotow number(5,0) not null);

Create table Rezerwacje_am(
id_klienta number(10,0),
id_lotu number(10,0),
cena_lotu number(6,2) not null,
data date not null,
primary key (id_klienta,id_lotu)
);


create table Lotniska_am(
id_lotniska number(6,0) primary key,
nazwa varchar2(100) not null,
miejscowosc varchar2(50),
kraj varchar2(50) not null
);

drop table Rozklad_lotow_am;

create table Rozklad_lotow_am(
id_rozkladu_lotow number(5,0),
dzien_ty_wylotu number(1,0),
godz_wylotu number (4,0),
id_lotniska_wylotu number(6,0),
dzien_ty_przylotu number(4,0),
godz_przylotu number(4,0),
id_lotniska_przylotu number(6,0)
--constraint dzien_check check(dzien_ty_wylotu >=1 and dzien_ty_wylotu<=7),
--constraint id_rozkladu_lotow, dzien_ty_wylotu, godz_wylotu, godz_przykotu, id_lotniska not null
);

alter table Rozklad_lotow_am add constraint id_lotniska_fk foreign key (id_lotniska_wylotu) references Lotniska_am(id_lotniska);

alter table Rozklad_lotow_am add constraint id_lotniska_fk_przylotu foreign key (id_lotniska_przylotu) references Lotniska_am(id_lotniska);

alter table Rozklad_lotow_am add constraint wylotCheck Check(dzien_ty_wylotu between 1 and 7);

--24
alter table Rozklad_lotow_am modify id_rozkladu_lotow primary key;
alter table Loty_am add constraint id_rozkladu_lotow_fkk foreign key (id_rozkladu_lotow) references Rozklad_lotow_am(id_rozkladu_lotow);

alter table Rezerwacje_am add constraint id_klienta_klientfk foreign key (id_klienta) references Klienci_am(id_klienta);
alter table Rezerwacje_am add constraint id_lotu_lotfk foreign key (id_lotu) references Loty_am(id_lotu);

alter table Klienci_am modify telefon varchar(15) not null;


alter table Rozklad_lotow_am add constraint przylotCheck Check(dzien_ty_przylotu between 1 and 7);

--f
alter table Rozklad_lotow_am drop constraint wylotCheck; 

alter table Rozklad_lotow_am drop constraint przylotCheck; 

--25
alter table Klienci_am add plec varchar2(1);
alter table Klienci_am add email varchar2(100);
alter table Klienci_am add ulica varchar2(100);
alter table Klienci_am add nr_budynku varchar2(6);
alter table Klienci_am add nr_lokalu varchar2(6);

alter table Klienci_am add constraint plecCheck Check(plec in('k','m'));

alter table Klienci_am add constraint k_mail Check(email like '%@%.%');