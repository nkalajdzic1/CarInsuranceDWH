-- RETURN NAMES OF ALL AGENTS
select concat(p.first_name, ' ', p.last_name) as name_of_Agent
from Person p, Agent a
where p.person_id=a.person_id;

-- RETURN NAMES OF ALL DRIVERS
select concat(p.first_name, ' ', p.last_name) as name_of_driver
from Person p, Driver d
where p.person_id=d.person_id;

-- RETURN ALL CARS WITH DRIVERS AND AGENTS
select concat(p.first_name, ' ', p.last_name) as name_of_driver, c.model, c.plate, c.color, c.serial_number, c.manufacturer_year, c.accident_id
from  Person p, Driver d, Car c
where p.person_id=d.person_id and d.car_id=c.car_id;

-- RETURN MAXIMUM PAYMENT FOR ACCIDENT
select top 1 concat(p.first_name, ' ', p.last_name) as name_of_driver, concat(a.street_address,' ',a.city) as location, d.driver_license_number,
c.car_id, c.model, c.plate, ac.report_date, i.issued_date, pa.payment_amount
from Person p, Driver d, Address a, Car c, Accident ac, Insurance i, Payment pa
where p.person_id=d.person_id 
and a.address_id=p.address_id 
and	d.car_id=c.car_id
and c.accident_id=ac.accident_id
and ac.insurance_id=i.insurance_id
and i.pay_id=pa.pay_id
order by pa.payment_amount DESC;

-- RETURN ALL DRIVERS WHO WERE NOT FAULT IN ACCIDENTS
select concat(p.first_name, ' ', p.last_name) as name_of_driver, d.driver_license_number, c.model, c.plate
from Person p, Driver d, Car c, Accident a
where p.person_id=d.person_id
and d.car_id=c.car_id
and a.accident_id=c.accident_id
and a.is_at_fault=0;

-- RETURN ACCIDENTS MADE IN PAST YEAR
select concat(p.first_name, ' ', p.last_name) as name_of_driver, d.driver_license_number, c.model, c.plate, a.report_date
from Person p, Driver d, Car c, Accident a
where p.person_id=d.person_id
and d.car_id=c.car_id
and a.accident_id=c.accident_id
and DATEPART(YYYY,a.report_date) = DATEPART(YYYY, DATEADD(m,-1,getdate()))
order by a.report_date desc;

-- RETURN NUMBER OF ACCIDENTS FOR EACH AGENT HE HAD TO PROCESS
select concat(p.first_name, ' ', p.last_name) as name_of_agent, COUNT(ac.accident_id) number_of_accidents
from Driver d, Person p, Agent a, Car c, Accident ac
where p.person_id=a.person_id 
and a.driver_id=d.driver_id
and d.car_id=c.car_id
and c.accident_id=ac.accident_id
group by concat(p.first_name, ' ', p.last_name); 