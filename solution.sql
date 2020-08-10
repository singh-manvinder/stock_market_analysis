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

create table Bajajx
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double,
Flag double,
`Row` int,
`Signal` nvarchar(10)
);

insert into Bajajx
select *, 20_Day_MA - 50_Day_MA, row_number() over (order by Date), 'Hold' from Bajaj1;

alter table Bajajx 
add Flagp double;

update Bajajx curr
join Bajajx prv
on curr.Row = prv.Row - 1 
set prv.Flagp = curr.Flag;

update Bajajx
set `Signal` = 'Buy'
where Flag > 0 and Flagp < 0;

update Bajajx
set `Signal` = 'Sell'
where Flag < 0 and Flagp > 0;

select * from Bajajx;

create table Bajaj2
(
Date Date,
Close_Price double,
`Signal` nvarchar(10)
);

insert into Bajaj2
select Date, Close_Price, `Signal` from Bajajx;

select * from Bajaj2;

/* Eicher*/

create table Eicherx
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double,
Flag double,
`Row` int,
`Signal` nvarchar(10)
);

insert into Eicherx
select *, 20_Day_MA - 50_Day_MA, row_number() over (order by Date), 'Hold' from Eicher1;

alter table Eicherx 
add Flagp double;

update Eicherx curr
join Eicherx prv
on curr.Row = prv.Row - 1 
set prv.Flagp = curr.Flag;

update Eicherx
set `Signal` = 'Buy'
where Flag > 0 and Flagp < 0;

update Eicherx
set `Signal` = 'Sell'
where Flag < 0 and Flagp > 0;

select * from Eicherx;

create table Eicher2
(
Date Date,
Close_Price double,
`Signal` nvarchar(10)
);

insert into Eicher2
select Date, Close_Price, `Signal` from Eicherx;

select * from Eicher2;

/* Hero */

create table Herox
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double,
Flag double,
`Row` int,
`Signal` nvarchar(10)
);

insert into Herox
select *, 20_Day_MA - 50_Day_MA, row_number() over (order by Date), 'Hold' from Hero1;

alter table Herox 
add Flagp double;

update Herox curr
join Herox prv
on curr.Row = prv.Row - 1 
set prv.Flagp = curr.Flag;

update Herox
set `Signal` = 'Buy'
where Flag > 0 and Flagp < 0;

update Herox
set `Signal` = 'Sell'
where Flag < 0 and Flagp > 0;

select * from Herox;

create table Hero2
(
Date Date,
Close_Price double,
`Signal` nvarchar(10)
);

insert into Hero2
select Date, Close_Price, `Signal` from Herox;

select * from Hero2;

/* Infosys */

create table Infosysx
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double,
Flag double,
`Row` int,
`Signal` nvarchar(10)
);

insert into Infosysx
select *, 20_Day_MA - 50_Day_MA, row_number() over (order by Date), 'Hold' from Infosys1;

alter table Infosysx 
add Flagp double;

update Infosysx curr
join Infosysx prv
on curr.Row = prv.Row - 1 
set prv.Flagp = curr.Flag;

update Infosysx
set `Signal` = 'Buy'
where Flag > 0 and Flagp < 0;

update Infosysx
set `Signal` = 'Sell'
where Flag < 0 and Flagp > 0;

select * from Infosysx;

create table Infosys2
(
Date Date,
Close_Price double,
`Signal` nvarchar(10)
);

insert into Infosys2
select Date, Close_Price, `Signal` from Infosysx;

select * from Infosys2;

/* TCS */

create table TCSx
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double,
Flag double,
`Row` int,
`Signal` nvarchar(10)
);

insert into TCSx
select *, 20_Day_MA - 50_Day_MA, row_number() over (order by Date), 'Hold' from TCS1;

alter table TCSx 
add Flagp double;

update TCSx curr
join TCSx prv
on curr.Row = prv.Row - 1 
set prv.Flagp = curr.Flag;

update TCSx
set `Signal` = 'Buy'
where Flag > 0 and Flagp < 0;

update TCSx
set `Signal` = 'Sell'
where Flag < 0 and Flagp > 0;

select * from TCSx;

create table TCS2
(
Date Date,
Close_Price double,
`Signal` nvarchar(10)
);

insert into TCS2
select Date, Close_Price, `Signal` from TCSx;

select * from TCS2;

/* TVS */

create table TVSx
(
Date Date primary key,
Close_Price double,
20_Day_MA double,
50_Day_MA double,
Flag double,
`Row` int,
`Signal` nvarchar(10)
);

insert into TVSx
select *, 20_Day_MA - 50_Day_MA, row_number() over (order by Date), 'Hold' from TVS1;

alter table TVSx 
add Flagp double;

update TVSx curr
join TVSx prv
on curr.Row = prv.Row - 1 
set prv.Flagp = curr.Flag;

update TVSx
set `Signal` = 'Buy'
where Flag > 0 and Flagp < 0;

update TVSx
set `Signal` = 'Sell'
where Flag < 0 and Flagp > 0;

select * from TVSx;

create table TVS2
(
Date Date,
Close_Price double,
`Signal` nvarchar(10)
);

insert into TVS2
select Date, Close_Price, `Signal` from TVSx;

select * from TVS2
