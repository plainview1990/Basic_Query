select * from movie_gross
select top 10 * from movie_gross
where total_gross > 100000000 and genre = 'Action'
order by total_gross desc

select distinct genre from movie_gross

select top 5 movie_title, release_date, 
DATEPART(year,release_date) year,
DATEPART(month,release_date) month,
DATEPART(day,release_date) day,
DATEPART(DAYOFYEAR,release_date) day_of_year,
DATEPART(week,release_date) week,
DATENAME(weekday,release_date) day_name,
DATENAME(month,release_date) month_name,
format(release_date,'dddd','th') th_date,
format(release_date,'MMM','th') th_month_Initial,
format(release_date,'MMMM','th') th_month,
format(release_date,'yyy','th') th_year,
format(release_date,'dddd','en') en_date,
format(release_date,'MMM','en') en_month_Initial,
format(release_date,'MMMM','en') en_month,
format(release_date,'yyy','en') en_year
from movie_gross

select *,
DATEPART(weekday,release_date) day_of_week,
format(release_date,'dddd','en') day_name
from movie_gross
order by day_of_week

select format(release_date,'dddd','en') day_name,
count(*) number
from movie_gross
group by format(release_date,'dddd','en')
order by count(*) desc

select * from movie_gross
where DATEPART (year,release_date) = 1990
order by release_date

select count(*) Number, sum(total_gross) Total from movie_gross
where DATEPART (year,release_date) = 1990

select * from movie_gross
where genre = 'Action' or genre = 'Comedy'

select * from movie_gross
where genre in('Action', 'Comedy') and mpaa_rating in('PG','R')

select * from movie_gross
where total_gross > 300000000 and total_gross < 500000000
order by total_gross desc

select * from movie_gross
where total_gross between 300000000 and 500000000
order by total_gross desc

select * from movie_gross
--where movie_title like '%toy story%'
--where movie_title like '__n%'
where movie_title like '[0-9]%'
order by movie_title

select * from movie_gross
where genre is null

select * from revenue
select	year,	
		isnull(studio_entertainment,0) + 
		isnull(disney_consumer_products,0) +
		isnull(disney_interactive,0) +
		isnull(walt_disney_parks_and_resorts,0) + 
		isnull(disney_media_networks,0) [total-null], 
		total 
		from revenue

select * from revenue
select	sum(disney_media_networks) [total revenue disney_media_networks],
		count(*) [count all],
		count(disney_media_networks) [count disney_media_networks],
		avg(disney_media_networks) [average revenue disney_media_networks], 
		min(disney_media_networks) [minimum revenue disney_media_networks],
		max(disney_media_networks) [maximum revenue disney_media_networks]
		from revenue

select top 10 *, newid() random_id from movie_gross
select top 10 percent *, newid() random_id from movie_gross
order by newid()

select * from director
select top 1 with ties director , count(*) no_movies from director
group by director
order by no_movies desc

select * from data_science

drop table if exists data_science
select top 70 percent *
into data_science
from movie_gross
order by newid()

drop table if exists test_data;
with cte as (
select * from movie_gross
except
select * from data_science
)
select * into test_data from cte

select * from test_data

select * from movie_gross
order by inflation_adjusted_gross desc offset 1 row fetch next 10 row only

--select movie_title + '  ('+genre+')'
--select concat(movie_title,' (',release_date,') ')
select *, concat(movie_title,' (',year(release_date),') ') name_with_year
--select *, concat(movie_title,' (',format(total_gross,'n0'),' ) ')
from movie_gross

select top 10 movie_title, 
upper(movie_title),
lower(movie_title),
len(movie_title),
SUBSTRING(movie_title,1,10)
from movie_gross

select top 1 with ties movie_title,
len(movie_title) [length]
from movie_gross
order by length desc

select * from director
select movie_title, director,
charindex(' ',director) [space],
substring(director, 1, charindex(' ',director) -1) [first_name],
substring(director, charindex(' ',director) +1, 100) [last_name],
left(director, charindex(' ',director) -1) [first_name2]
from director

select movie_title,
substring(director, 1, charindex(' ',director) -1) [first_name],
substring(director, charindex(' ',director) +1, 100) [last_name]
from director
order by last_name

select getdate()
select datediff(day,'1990-08-09',getdate())
select datediff(minute,'2023-01-01 00:00','2023-01-01 01:09')
select datediff(minute,'2023-01-01 00:00','2023-01-01 01:09') % 60
select getdate(), dateadd(day, 5, getdate())
select format(getdate(), 'dddd dd-MM-yyyy'), format(dateadd(day, 5, getdate()), 'dddd dd-MM-yyyy')
select convert(datetime,'2023-01-01')
select cast('2023-01-01' as datetime)

select movie_title, release_date,
datediff(year,release_date,getdate()) diff_year
from movie_gross

create table car_park (
	plate_no nvarchar(8),
	time_in datetime,
	time_out datetime
);
insert into car_park values
	(N'กก 1234','2023-01-01 11:00', '2023-01-01 13:00'),
	(N'ขข 5678','2023-01-01 11:00', '2023-01-01 11:10'),
	(N'คค 0000','2023-01-01 11:50', '2023-01-01 14:00'),
	('AZ 2020','2023-01-01 11:50', '2023-01-02 15:10')

-- คำนวณค่าจอดรถ 10 บาท ต่อ 1 ชม.
declare @rate int = 10
select *,
datediff(minute,time_in,time_out) [Minute],
datediff(minute,time_in,time_out) / 60 [Hour],
datediff(minute,time_in,time_out) % 60 [Minute/Hr.],
datediff(minute,time_in,time_out) / 60 * @rate + iif(datediff(minute,time_in,time_out) % 60 > 0, @rate, 0)  [Fee]
from car_park

select top 10 *,
format(inflation_adjusted_gross,'N'),
format(inflation_adjusted_gross,'n0'),
format(inflation_adjusted_gross,'#,##0'),
format(inflation_adjusted_gross,'#,##0,,'),
format(inflation_adjusted_gross,'#,##0,,.0 M')
from movie_gross

select * from movie_gross

with whatever as (
select genre, sum(inflation_adjusted_gross) [sum_gross_of_genre] from movie_gross group by genre
)
select *,
sum_gross_of_genre *1.0 / (select sum(sum_gross_of_genre) from whatever) sum_gross_of_total,
format(sum_gross_of_genre *1.0 / (select sum(sum_gross_of_genre) from whatever), 'P') percent_of_total
from whatever
order by percent_of_total desc

select sum(inflation_adjusted_gross), count(*), avg(inflation_adjusted_gross) from movie_gross
select genre, sum(inflation_adjusted_gross), count(*), avg(inflation_adjusted_gross) from movie_gross group by genre

select genre, sum(inflation_adjusted_gross) summary, count(*) no_movies, avg(inflation_adjusted_gross) average
from movie_gross
group by genre
having count(*) > 100
order by genre



select datepart(year, release_date) year, genre, sum(total_gross) gross
from movie_gross
where datepart(year, release_date) > 2013
group by genre, datepart(year, release_date)

select datepart(year, release_date) year, genre, sum(total_gross) gross
from movie_gross
where datepart(year, release_date) > 2013
group by grouping sets (
			(datepart(year, release_date), genre),
			(datepart(year, release_date)),
			(genre),
			()
)
having datepart(year, release_date) is not null
order by year, genre

select datepart(month, dt) month, sum(revenue) revenue from daily_sales
group by datepart(month, dt)
union
select null, sum(revenue) from daily_sales
order by month

select datepart(year, dt) year, datepart(quarter, dt) quarter, datepart(month, dt) month, sum(revenue) total from daily_sales
group by rollup(datepart(year, dt), datepart(quarter, dt), datepart(month, dt))
order by year, quarter, month


select movie_title,mpaa_rating, 
	case mpaa_rating
	when 'G' then 'General Audiences'
	when 'PG' then 'Parental Guidance'
	when 'PG-13' then 'Parental Guidance-13'
	when 'R' then 'Restricted'
	else mpaa_rating
	end as rating
from movie_gross
order by mpaa_rating


with whatever as(
select *, 
	case
	when inflation_adjusted_gross > 500000000 then '5 Stars Movies'
	when inflation_adjusted_gross between 100000000 and 500000000 then 'Pop Corn Movies'
	else 'Rotten Tomato Movies'
	end as commentator
from movie_gross
order by inflation_adjusted_gross desc
)
select commentator, count(commentator) number from whatever group by commentator

select * from movie_gross inner join director on movie_gross.movie_title = director.movie_title

select movie_gross.movie_title, movie_gross.release_date, director.director
from movie_gross inner join director 
on movie_gross.movie_title = director.movie_title

select movie_gross.movie_title, release_date, director
from movie_gross left join director 
on movie_gross.movie_title = director.movie_title

with whatever as(
select m.movie_title, m.release_date, d.director, c.song
from movie_gross as m right join director as d
on m.movie_title = d.movie_title right join disney_char as c
on m.movie_title = c.movie_title
)
select year(release_date) year, director, song from whatever 
where release_date is not null
order by release_date

with tb as(
select genre, datepart(year,release_date) year, sum(inflation_adjusted_gross) summary from movie_gross
where genre in('action','adventure') and datepart(year,release_date) > 2010
group by datepart(year,release_date), genre
)
select ac.year, ac.summary [action], ad.summary [adventure]
from tb ac inner join tb ad on ac.year = ad.year and ac.genre = 'action' and ad.genre = 'adventure'


drop table if exists soccer
create table soccer (
	rank int,
	team nvarchar(50)
);
insert into soccer values
	(1,'FC Bayern Munich'),
	(2,'LB Leipzig'),
	(3,'Borussia Dortmund'),
	(4,'FC Union Berlin')

--select * from soccer home cross join soccer away
select home.team, away.team from soccer home cross join soccer away
--select concat(home.team, ' (',home.rank, ')') [home team], concat(away.team, ' (',away.rank, ')') [away team] from soccer home cross join soccer away
--where home.team != away.team		-- กรณีแข่งแบบทีมเหย้า-ทีมเยือน
where home.team > away.team		-- กรณีแข่งแบบเจอกันครั้งเดียว

with casino1 as(
select value as card from string_split('A,2,3,4,5,6,7,8,9,10,J,Q,K',',')
),
	casino2 as(
select value as symbol from string_split(N'♠,♥,♦,♣',',')
--https://en.wikipedia.org/wiki/Playing_card_suit
)
select concat(card,symbol) dealer from casino1 cross join casino2
--select top 2 concat(card,symbol) dealer from casino1 cross join casino2
--order by newid()