-- Average Attrition rate for all Departments

use hr;
create view Avg_Attrition_Rate_For_Departments as
select Department,round((count(EmployeeNumber) /50000)*100,2) as avg_attrition_rate
from hr_1
where Attrition="yes"
group by department;


-- Average Hourly rate of Male Research Scientist
create view Avg_Hourly_Rate_Male_Reaserach_Scientist as
select JobRole,round(avg(HourlyRate),0) as avg_hourly_rate
from hr_1
where gender="Male" and JobRole="Research Scientist"
group by JobRole;

-- Attrition rate Vs Monthly income stats
create view Attrition_Rate_Vs_Monthly_Income as 
select JobRole,round((count(EmployeeNumber) /50000)*100,2) as avg_attrition_rate, sum(MonthlyIncome)
from hr_1 inner join hr_2
on hr_1.EmployeeNumber=hr_2.`Employee ID`
where Attrition="yes"
group by JobRole;

-- Average working years for each Department
create view Avg_Working_Yrs_Department as
select Department,avg(TotalWorkingYears)
from hr_1 inner join hr_2
on hr_1.EmployeeNumber=hr_2.`Employee ID`
group by department;


-- Job Role Vs Work life balance
create view Job_Role_VS__WorkLife_Balnce as
select JobRole, 
count(case
	when WorkLifeBalance=1 then "Very Dissatisfied"
    when workLifeBalance=2 then "Dissatisfied"
    when WorkLifeBalance=3 then "Satisfied"
    else "Very Satisfied"
end) as Work_Life_Balance,
case
	when WorkLifeBalance=1 then "Very Dissatisfied"
    when workLifeBalance=2 then "Dissatisfied"
    when WorkLifeBalance=3 then "Satisfied"
    else "Very Satisfied"
end as Work_Life_Balance_Status
from hr_1 inner join hr_2
on hr_1.EmployeeNumber=hr_2.`Employee ID`
group by JobRole,Work_Life_Balance_Status;

alter table hr_2new rename hr_2;

-- Attrition rate Vs Year since last promotion relation
create view Attrition_Rate_Vs_Yr_Since_Last_Promotion as 
select 
case
	when YearsSinceLastPromotion<=10 then "1-10 Yrs"
    when YearsSinceLastPromotion<=20 then "11-20 Yrs"
    when YearsSinceLastPromotion<=30 then "21-30 Yrs"
    else "31 Plus Yrs"
end as Yr_since_last_promotion,
round(count(EmployeeNumber)/50000,3)*100 as "Attrtion rate"
from hr_1
inner join hr_2
on hr_1.EmployeeNumber=hr_2.`Employee ID`
where attrition = "Yes"
group by Yr_since_last_promotion
order by Yr_since_last_promotion ;