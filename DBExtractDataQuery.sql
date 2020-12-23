-- EXTRACT ALL ADDRESSES
Select Address.address_id,Address.street_address,Address.city,Address.state,Address.postal_number 
from Address;

-- EXTRACT ALL PERSONS
Select Person.person_id,Person.first_name,Person.last_name,Person.date_of_birth,Person.phone_number,Person.address_id
from Person;

-- EXTRACT ALL DRIVERS
Select Driver.driver_id,Driver.person_id,Driver.car_id,Driver.driver_license_number
from Driver;

-- EXTRACT ALL CARS
Select Car.car_id,Car.model,Car.plate,Car.color,Car.serial_number,Car.manufacturer_year,Car.accident_id
from Car;

-- EXTRACT ALL PAYMENTS
Select Payment.pay_id,Payment.payment_date,Payment.payment_amount
from Payment;

-- EXTRACT ALL ACCIDENTS
Select Accident.accident_id,Accident.report_date,Accident.damage_cost,Accident.is_at_fault,Accident.insurance_id
from Accident;

-- RETURN NAMES OF ALL AGENTS
select concat(p.first_name, ' ', p.last_name) as name_of_Agent
from Person p, Agent a
where p.person_id=a.person_id;

-- RETURN NAMES OF ALL DRIVERS
select concat(p.first_name, ' ', p.last_name) as name_of_driver
from Person p, Driver d
where p.person_id=d.person_id;

-- RETURN ALL DRIVERS WITH THEIR CARS 
select concat(p.first_name, ' ', p.last_name) as name_of_driver, c.model, c.plate, c.color, c.serial_number, c.manufacturer_year, c.accident_id
from  Person p, Driver d, Car c
where p.person_id=d.person_id and d.car_id=c.car_id;

-- RETURN 20 MAXIMUM PAYMENT FOR ACCIDENT
select top 20 concat(p.first_name, ' ', p.last_name) as name_of_driver, concat(a.street_address,' ',a.city) as location, d.driver_license_number,
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
