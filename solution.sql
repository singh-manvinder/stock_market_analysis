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
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 20 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') 
        rows between 20 preceding and current row)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 50 preceding)
	else null
end)
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
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 20 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 20 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 50 preceding)
	else null
end)
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
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 20 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 20 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 50 preceding)
	else null
end)
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
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 20 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 20 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 50 preceding)
	else null
end)
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
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 20 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 20 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 50 preceding)
	else null
end)
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
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 20 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 20 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 50 preceding)
	else null
end)
from TVS
order by formatted_date;

select * from TVS1;

delete from Bajaj1 where 50_Day_MA is null;
delete from Eicher1 where 50_Day_MA is null;
delete from Hero1 where 50_Day_MA is null;
delete from Infosys1 where 50_Day_MA is null;
delete from TCS1 where 50_Day_MA is null;
delete from TVS1 where 50_Day_MA is null;

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
