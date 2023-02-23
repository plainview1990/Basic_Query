select * from sales

select distinct status from sales

select tenant, sale_employee, owner, partner, enduser,
format(POCStartDate,'dd-MM-yyyy','en') [POC Sart Date],
format(POCEndDate,'dd-MM-yyyy','en') [POC End Date],
datediff(day,getdate(),POCEndDate) date_diff
from Sales
where datepart(year,POCEndDate) = 2023 --is not null
order by date_diff
-- ระบุเงื่อนไข ต้องการหา Tenant ที่กำลังจะหมดสัญญา POC ในปี 2023

select partner, count(*) total from sales
where status not in('DEL','DIS')
group by partner
order by total desc
-- ระบุเงื่อนไข ค้นหาจาก partner ที่มีลูกค้ามากที่สุด โดยไม่รวมลูกค้าที่มี Status Disable หรือ Delete

select tenant, enduser, status, owner, sale_employee,
format(POCStartDate,'dd-MM-yyyy','en') [POC Sart Date],
format(POCEndDate,'dd-MM-yyyy','en') [POC End Date],
datediff(day,getdate(),POCEndDate) date_diffPOC,
format(PRODStartDate,'dd-MM-yyyy','en') [PROD Sart Date],
format(PRODEndDate,'dd-MM-yyyy','en') [PROD End Date],
datediff(day,getdate(),PRODEndDate) date_diffPROD
from sales
where partner = 'E-Business Plus Co.Ltd.' and status not in('DEL','DIS')
order by date_diffPOC
-- ระบุเงื่อนไข แสดงข้อมูลที่ต้องการของ End User ทั้งหมด จากการระบุชื่อ partner และไม่รวมลูกค้าที่มี Status Disable หรือ Delete

select owner, count(owner) cnt1 from Sales
where status not in('DEL','DIS') and POCStartDate between '02-01-2023' and getdate()
group by owner
order by cnt1 desc

select tenant, status, sale_employee, owner, partner, enduser,
format(POCStartDate,'dd-MM-yyyy','en') [POC Sart Date],
format(POCEndDate,'dd-MM-yyyy','en') [POC End Date]
from Sales
where status not in('DEL','DIS') and POCStartDate between '02-01-2023' and getdate()
order by POCStartDate
-- ระบุเงื่อนไข ต้องการทราบว่าเซลล์คนไหนมีลูกค้าใหม่เข้ามาแล้วบ้าง ตั้งแต่วันที่ 1 Feb 2023 ถึงวันที่ปัจจุบัน

select sale_employee, count(sale_employee) cnt2 from Sales
where status not in('DEL','DIS')
group by sale_employee
order by cnt2 desc

select tenant, status ,partner, enduser,
format(POCStartDate,'dd-MM-yyyy','en') [POC Sart Date],
format(POCEndDate,'dd-MM-yyyy','en') [POC End Date],
datediff(day,getdate(),POCEndDate) date_diffPOC,
format(PRODStartDate,'dd-MM-yyyy','en') [PROD Sart Date],
format(PRODEndDate,'dd-MM-yyyy','en') [PROD End Date],
datediff(day,getdate(),PRODEndDate) date_diffPROD
from Sales
where owner like 'Phannarai%' and status not in('DEL','DIS')
order by POCEndDate asc
-- ระบุเงื่อนไข ต้องการทราบว่าเซลล์คนไหนมีลูกค้าที่ยัง active อยู่มากที่สุด และแสดงข้อมูลที่ต้องการของ End User ทั้งหมด

select tenant, count(tenant) duplicate_tenant from sales
group by tenant having count(tenant) > 1
order by duplicate_tenant desc
-- ระบุเงื่อนไข ค้นหาเลข Tenant ที่ซ้ำกัน เพื่อดู SO ซ้ำกันในระบบ




