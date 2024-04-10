create database inventory
use inventory
create table suppliers
(sid char(5) , sname  varchar(25) , sadd varchar(50) , scity varchar(25), sphone char(10), email varchar(45))
create table product 
(pid char(5), pdesc varchar (23), price int , category char(2) )
alter table product
add sid char(5) 
create table stock 
(sqty int , rql int , moq int ) 
alter table stock
add pid char(5)
create table cust 
( ciu char (5) , cname varchar (56), address varchar(56), city varchar(34), phone char(10),email varchar(56),dob date )
create table orders 
(oid char(5), odate date ,oqty int)
alter table orders
add ciu char(5)
alter table orders 
add pid char(5)
-- alter table suppliers
-- alter column sid char(5) not null 
ALTER TABLE suppliers
ALTER COLUMN sid char(5)  NOT NULL;


alter table suppliers 
alter column sadd varchar(50) not null ;
alter table suppliers 
add constraint phn  unique (sphone)
alter table product
alter column pid char(5) not null
alter table product
alter column pdesc varchar(23) not null 
alter table product 
add constraint pc check (price>0)
alter table stock 
add constraint sqt check (sqty >0)
alter table stock 
add constraint rl check (rql >0)
alter table stock 
add constraint md check (moq >=5)
alter table cust
alter column ciu char(5)  not null
alter table cust
alter column cname varchar(56) not null
alter table cust 
alter column address varchar(56)  not null 
alter table cust
alter column city varchar(34) not null
alter table cust
alter column phone varchar(10) not null ;
alter table cust
alter column email varchar(56) NOT NULL
alter table cust
add constraint db check (dob < ('2000 - 11 - 10'))
alter table orders 
alter column oid char(5) not null
alter table orders
add constraint oqt check (oqty >-1)
alter table suppliers
add constraint pkseid  primary key (sid )
alter table product
add constraint pkpid primary key (pid)
alter table cust
add constraint pkcui primary key(ciu)
alter table orders
add constraint pkoid primary key(oid)
alter table product
add constraint fkid foreign key (sid) references suppliers (sid)
alter table stock
add constraint sfk foreign key (pid) references product (pid)
alter table orders
add constraint ofk foreign key (ciu) references cust (ciu)
alter table orders
add constraint ofkid foreign key (pid) references product (pid)

create sequence sequence_value
as int
start with 1
increment by  1

create function inventoryid (@c char(1) , @i as int )
returns char(5)
as
begin
   declare @id as char(5)
   if @i <10 
   set @id = concat(@c,'000' , @i)
   else if @i < 100
   set @id = concat(@c,'00',@i)
   else if @i <1000
   set @id = concat(@c,'0',@i)
   else if @i < 10000
   set @id = concat(@c ,@i)
   else 
   set @id = 'NA'
   return  @id ;
end;


create procedure sup_table ( @name varchar (20), @a varchar(50),@sc varchar(25),@sp char(10),@smail varchar(45))
as 
begin
	 declare @i as int
	 set @i = next value for sequence_value
	 declare @id as char(5)
	 set @id = dbo.inventoryid ('S',@i)
	 insert into suppliers 
	 values(@id , @name ,@a , @sc, @sp, @smail)

	 select* from suppliers
	 where sid = @id
end
sup_table 'rahul taneja','delhi','new delhi','2221113337','rahultaneja@gmail.com'

