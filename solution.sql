create database Assignment;

use Assignment;

select * from Bajaj;
select * from Eicher;
select * from Hero;
select * from Infosys;
select * from TCS;
select * from TVS;

create table Bajaj1
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double
);

insert into Bajaj1
select str_to_date(date, '%d-%M-%Y') as formatted_date, `Close Price`,
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding),
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
from Bajaj
order by formatted_date;

select * from Bajaj1;

create table Eicher1
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double
);

insert into Eicher1
select str_to_date(date, '%d-%M-%Y') as formatted_date, `Close Price`,
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding),
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
from Eicher
order by formatted_date;

select * from Eicher1;

create table Hero1
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double
);

insert into Hero1
select str_to_date(date, '%d-%M-%Y') as formatted_date, `Close Price`,
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding),
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
from Hero
order by formatted_date;

select * from Hero1;

create table Infosys1
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double
);

insert into Infosys1
select str_to_date(date, '%d-%M-%Y') as formatted_date, `Close Price`,
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding),
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
from Infosys
order by formatted_date;

select * from Infosys1;

create table TCS1
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double
);

insert into TCS1
select str_to_date(date, '%d-%M-%Y') as formatted_date, `Close Price`,
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding),
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
from TCS
order by formatted_date;

select * from TCS1;

create table TVS1
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double
);

insert into TVS1
select str_to_date(date, '%d-%M-%Y') as formatted_date, `Close Price`,
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding),
avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
from TVS
order by formatted_date;

select * from TVS1;

create table Master
(
Date date primary key,
Bajaj double,
TCS double,
TVS double,
Infosys double,
Eicher double,
Hero double
);

insert into Master
select 
b.Date, b.Close_Price, tcs.Close_Price, tvs.Close_Price, 
i.Close_Price, e.Close_Price, h.Close_Price
from Bajaj1 b
join TCS1 tcs
on b.Date = tcs.Date
join TVS1 tvs
on b.Date = tvs.Date
join Infosys1 i
on b.Date = i.Date
join Eicher1 e
on b.Date = e.Date
join Hero1 h
on b.Date = h.Date;

select * from Master;
