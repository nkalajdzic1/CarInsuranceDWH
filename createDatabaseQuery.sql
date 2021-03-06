create database CarInsurance;
use CarInsurance;

create table [Address] (
  [address_id] int primary key,
  [street_address] varchar(50),
  [city] varchar(50),
  [state] varchar(50),
  [postal_number] int
);

create table [Person] (
  [person_id] int primary key,
  [first_name] varchar(50),
  [last_name] varchar(50),
  [date_of_birth] Date,
  [phone_number] varchar(50),	
  [address_id] int foreign key references Address(address_id) not null
);

create table [Agent] (
  [agent_id] int primary key,
  [person_id] int foreign key references Person(person_id) not null unique,
  [driver_id] int not null,	
  [username] varchar(50)
);	

create table [Driver] (
  [driver_id] int primary key,
  [person_id] int foreign key references Person(person_id) not null unique,
  [car_id] int not null,
  [driver_license_number] varchar(50)
);

alter table Agent
add foreign key (driver_id) references Driver(driver_id);

create table [Car] (
  [car_id] int primary key,
  [model] varchar(50),
  [plate] varchar(50),
  [color] varchar(50),
  [serial_number] varchar(50),
  [manufacturer_year] Date,
  [accident_id] int						      -- treba dodati foreign key ovdje
);

alter table Driver 
add foreign key (car_id) references Car(car_id);

create table [Payment] (
  [pay_id] int primary key,
  [payment_date] Date,
  [payment_amount] float
);

create table [Insurance] (
  [insurance_id] int primary key,
  [coverage] float,
  [deductible] float,
  [issued_date] Date,
  [pay_id] int foreign key references Payment(pay_id) not null unique
);

create table [Accident] (
  [accident_id] int primary key,
  [report_date] Date,
  [damage_cost] float,
  [is_at_fault] int,
  [insurance_id] int foreign key references Insurance(insurance_id) not null unique,
  constraint value_constraint_is_at_fault CHECK (is_at_fault = 0 OR is_at_fault = 1)
);

alter table Car 
add foreign key (accident_id) references Accident(accident_id);