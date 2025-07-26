-- practice project 1 to 9 days topics
-- project title :- EMPLOYEE MANAGEMENET & ORDERS SYSTEM

-- topics in this project:- (tables,constraints,joins,views,indexes,stored procedure,functions)
/* project problem statemnet :-
1 employees ka data store hoga
2 dept. data store hoga
3 orders ka data store hoga
4 discount calculate karna hain (function se)
5 salary increment karna hain (stored procedure se)
6 joins use karne hain (employee + department)
7 views banana hain
8 index banana hain
9 triggers and transaction bad main add karennge (day 10 +)
*/
drop database companydb;
create database companydb;               -- (1 DATABASE CREATE)
use companydb;

create table department (  -- department table    (2 TABLES)
dept_id int primary key,
dept_name varchar(50) unique not null
);
insert into department values
(1,"hr"),
(2,"finance"),
(3,"it");

create table employee (   -- employee table    
emp_id int primary key,
emp_name varchar(50) not null,
salary int check (salary >0),
dept_id int,
foreign key (dept_id) references department (dept_id)
);
insert into employee values
(101, "amit", 40000, 1),
(102, "priya", 50000, 2),
(103, "ravi", 45000, 3),
(104, "sneha", 60000, 2);

create table orders (     -- orders table
order_id int primary key,
emp_id int,
amount int,
foreign key (emp_id) references employee (emp_id)
);
insert into orders values
(1, 101, 1200),
(2, 102, 800),
(3, 103, 400),
(4, 104, 1500);

-- show employee name with department name :-   (3 JOINS)
select e.emp_name, d.dept_name
from employee e
inner join department d on e.dept_id = d.dept_id;

-- create view for high salary employees (salary > 45000) :-       (4 VIEWS)
create view highsalaryemployees as 
select emp_id, emp_name, salary from employee
where salary > 45000;
		     -- select * from highsalaryemployees; isse output dikhega
             
-- create index on orders amount                                          (5 INDEX)
create index idx_amount on 
orders(amount);

-- increase salary by given amount for given emp_id                        (6 STORED PROCEDURE)
delimiter //
create procedure increasesalary (
in empid int,
in increment int
)
begin
     update employee
     set salary = salary + increment
     where emp_id = empid;
end //
delimiter ;
call increasesalary (103, 5000);      -- call procedure

-- calculate 10% discount on order amount                              (7 FUNCTION)
delimiter //
create function calculatediscount (price int)
returns int 
deterministic
begin
      return price * 0.10;
end //
delimiter ;
select order_id amount,
calculatediscount(amount) as discount from orders;