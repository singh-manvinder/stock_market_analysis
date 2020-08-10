/* Create a new schema named 'Assignment' */
create database Assignment;

use Assignment;

/* After this csv has been importe manually using mysql workbench tool */

/* Check imported data */
select * from Bajaj;
select * from Eicher;
select * from Hero;
select * from Infosys;
select * from TCS;
select * from TVS;

/* 1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks) */

/* Create Bajaj1 */
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
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
	else null
end)
from Bajaj
order by formatted_date;

select * from Bajaj1;

/* Create Eicher1 */

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
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
	else null
end)
from Eicher
order by formatted_date;

select * from Eicher1;

/* Create Hero1 */

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
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
	else null
end)
from Hero
order by formatted_date;

select * from Hero1;

/* Create Infosys1 */

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
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
	else null
end)
from Infosys
order by formatted_date;

select * from Infosys1;

/* Create TCS1 */

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
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
	else null
end)
from TCS
order by formatted_date;

select * from TCS1;

/* Create TVS1 */

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
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 19 preceding)
	else null
end),
(case when
	row_number() over (order by str_to_date(date, '%d-%M-%Y')) >= 50 then
		avg(`Close Price`) over (order by str_to_date(date, '%d-%M-%Y') rows 49 preceding)
	else null
end)
from TVS
order by formatted_date;

select * from TVS1;

/* Delete the null data (data of first 50 days) as we don't have to do analysis on that*/
/* Safe update or delete should be off in preferences */

delete from Bajaj1 where 50_Day_MA is null;
delete from Eicher1 where 50_Day_MA is null;
delete from Hero1 where 50_Day_MA is null;
delete from Infosys1 where 50_Day_MA is null;
delete from TCS1 where 50_Day_MA is null;
delete from TVS1 where 50_Day_MA is null;

/* 2. Create a master table containing the date and close price of all the six stocks. (Column header for the price is the name of the stock) */

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

/* 3. Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 'bajaj2'. Perform this operation for all stocks. */

/* Creating intermetidate table {Stock}x */

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

select * from TVS2;

/* 4. Create a User defined function, that takes the date as input and returns the signal for that particular day (Buy/Sell/Hold) for the Bajaj stock. */

delimiter $$
create function fn_get_signal(inp_date nvarchar(100))  
returns nvarchar(10) reads sql data
begin
	declare val nvarchar(10);
	set val = (select `signal` from Bajaj2 where Date = str_to_date(inp_date, '%d-%M-%Y') limit 1);
    return val;
end; $$
delimiter ;

select fn_get_signal('11-July-2018');

/* Analysis */

/* Dates on which you should buy stock and which stock*/
select *, 'Bajaj' as Stock
from Bajaj2 where `Signal` = 'Buy'
union 
select *, 'Eicher' as Stock
from Eicher2 where `Signal` = 'Buy'
union 
select *, 'Hero' as Stock
from Hero2 where `Signal` = 'Buy'
union 
select *, 'Infosys' as Stock
from Infosys2 where `Signal` = 'Buy'
union 
 select *, 'TCS' as Stock
from TCS2 where `Signal` = 'Buy'
union 
select *, 'TVS' as Stock
from TVS2 where `Signal` = 'Buy';


/* Dates on which you should sell stocks and which stock */
select *, 'Bajaj' as Stock
from Bajaj2 where `Signal` = 'Sell'
union 
select *, 'Eicher' as Stock
from Eicher2 where `Signal` = 'Sell'
union 
select *, 'Hero' as Stock
from Hero2 where `Signal` = 'Sell'
union 
select *, 'Infosys' as Stock
from Infosys2 where `Signal` = 'Sell'
union 
 select *, 'TCS' as Stock
from TCS2 where `Signal` = 'Sell'
union 
select *, 'TVS' as Stock
from TVS2 where `Signal` = 'Sell';

/* Activity per stock */

select Stock, count(*) as `Action (Buy/Sell)` from 
(select *, 'Bajaj' as Stock
from Bajaj2 where `Signal` = 'Sell' or `Signal` = 'Buy'
union 
select *, 'Eicher' as Stock
from Eicher2 where `Signal` = 'Sell'
union 
select *, 'Hero' as Stock
from Hero2 where `Signal` = 'Sell'
union 
select *, 'Infosys' as Stock
from Infosys2 where `Signal` = 'Sell'
union 
 select *, 'TCS' as Stock
from TCS2 where `Signal` = 'Sell'
union 
select *, 'TVS' as Stock
from TVS2 where `Signal` = 'Sell') t1
group by Stock
order by `Action (Buy/Sell)` desc;

/* Spread of each stock */
select 
round(max(Bajaj) - min(Bajaj), 2) Bajaj,
round(max(Eicher) - min(Eicher), 2) Eicher,
round(max(Hero) - min(Hero), 2) Hero,
round(max(Infosys) - min(Infosys), 2) Infosys,
round(max(TCS) - min(TCS), 2) TCS,
round(max(TVS) - min(TVS), 2) TVS
from Master
