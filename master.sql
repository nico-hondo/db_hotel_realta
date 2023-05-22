
create table master.regions(
region_code serial primary key,
region_name varchar(35)unique
)

create table master.country(
country_id serial primary key,
country_name varchar(55)unique,
country_region_id integer,
foreign key (country_region_id) references master.regions(region_code)
)

create table master.address(
addr_id serial primary key,
addr_line1 varchar(225),
addr_line2 varchar (225),
addr_postal_code varchar (5),
addr_spatial_location varchar,
addr_prov_id integer,
foreign key (addr_prov_id ) references master.provinces (prov_id)
)
drop table master.address

create table master.provinces(
prov_id serial primary key,
prov_name varchar(85),
prov_country_id integer,
foreign key (prov_country_id) references master.country (country_id)
)

create table master.category_group(
cagro_id serial primary key,
cagro_name varchar(25),
cagro_description varchar(255),
cagro_type varchar (255),
cagro_icon varchar(255),
cagro_icon_url varchar(255)
)

create table master.policy(
poli_id serial primary key,
poli_name varchar (55), 
poli_description varchar
)

create table master.policy_category_group(
    poca_poli_id serial ,
    poca_cagro_id integer,
    constraint poli_cagro primary key (poca_poli_id, poca_cagro_id),
    foreign key (poca_poli_id) references master.policy (poli_id),
    foreign key ( poca_cagro_id) references master.category_group ( cagro_id)
)


create table master.price_items(
prit_id serial primary key,
prit_name varchar(55)unique ,
prit_price money,
prit_description varchar(255),
prit_type varchar(15),
prit_modfield_date timestamp
)
drop table master.price_items

create table master.service_task(
seta_id serial primary key,
seta_name varchar (85)unique,
seta_seq smallint
)

create table master.members(
memb_name varchar (15)primary key,
memb_description varchar(100)
)


INSERT INTO master.category_group (cagro_name)VALUES('Ballrom')
select * from master.category_group

INSERT INTO  master.regions (region_name)VALUES('bogor')
select * from master.regions

INSERT INTO  master.country (country_name, country_region_id )VALUES('.Cibinong', 10) 
update master.country set country_name = 'kilangan'where country_region_id = 5
select * from  master.country

 
INSERT INTO master.provinces (prov_name,prov_country_id)VALUES('jawa barat', 10)
select * from  master.provinces



INSERT INTO master.address(addr_line1, addr_line2,addr_postal_code,addr_spatial_location,addr_prov_id)
VALUES('JL barat daya deket', 'no1', 9087, '7.2829° S, 112.7365° E' , 1)
select * from   master.address


INSERT INTO master.policy (poli_name,poli_description)VALUES('Anonymous User', 'Identitas dan informasi pribadi pengguna dijaga kerahasiaannya dan tidak diungkapkan'.)
select * from  master.policy

INSERT INTO master.policy_category_group (poca_poli_id, poca_cagro_id) VALUES (10, 2)
select * from master.policy_category_group

INSERT INTO master.price_items (prit_id,prit_name,prit_price,prit_description,prit_type,prit_modfield_date ) 
VALUES (10,'granita', '10.000','seger', 'soft drink', '2013-02-17' )
select * from master.price_items 

INSERT INTO master.service_task (seta_id,seta_name,seta_seq) VALUES (10, 'parking service ',10 )
select * from  master.service_task


INSERT INTO master.members (memb_name,memb_description) VALUES ('andri', 'memuaskan')
select * from master.members
