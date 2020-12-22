create database CarInsuranceDWH;
use CarInsuranceDWH;

create table [DimDriver] (
  [id] int primary key,
  [first_name] varchar(50),
  [last_name] varchar(50),
  [date_of_birth] Date,
  [phone_number] varchar(50),
  [driver_license_number] varchar(50),
  [postal_number] int,
  [city] varchar(50),
  [state] varchar(50)
);

create table [DimAgent] (
  [id] int primary key,
  [username] varchar(50),
  [first_name] varchar(50),
  [last_name] varchar(50),
  [date_of_birth] Date,
  [phone_number] varchar(50),
  [postal_number] int,
  [city] varchar(50),
  [state] varchar(50)
);

create table [DimInsurance] (
  [id] int primary key,
  [coverage] float,
  [deductible] float,
  [payment_amount] float,
  [total_cost] float
);

create table [DimCar] (
  [id] int primary key,
  [model] varchar(50),
  [plate] varchar(50),
  [color] varchar(50),
  [serial_number] varchar(50),
  [manufacturer_year] Date
);

create table [FactAccident] (
  [id] int primary key,
  [agentkey] int foreign key references DimAgent(id) not null,
  [driverkey] int foreign key references DimDriver(id) not null,
  [carkey] int foreign key references DimCar(id) not null,
  [insurancekey] int foreign key references DimInsurance(id) not null,
  [damage_cost] float,
  [is_at_fault] int
);