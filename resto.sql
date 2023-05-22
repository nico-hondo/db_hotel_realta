create table resto.facilities (
	faci_id serial primary key
)
insert into resto.facilities(faci_id) values
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10)

create table resto.users(
	user_id integer
)
insert into resto.users(user_id) values
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10)
alter table resto.users add constraint user_id primary key(user_id);
create table resto.order_menu_detail(
    omde_id serial primary key,
    orme_price money,
    orme_qty smallint,
    orme_subtotal money,
    orme_discount money,
    omde_orme_id integer,
    omde_reme_id integer,
    foreign key (omde_orme_id) references resto.order_menus(orme_id),
    foreign key(omde_reme_id) references resto.resto_menus(reme_id)
)
insert into resto.order_menu_detail (omde_id, orme_price, orme_qty, orme_subtotal, orme_discount, 
omde_orme_id, omde_reme_id) values
(001, 10.99, 5, 25.99, 0.10, 1001,1),
(002, 15.50, 8, 31, 0.16, 1002, 2),
(003, 8.75, 3, 17.50, 0.15, 1003, 3),
(004, 12.25, 10, 36.75, 0.20, 1004, 4),
(005, 9.99, 6, 19.98, 0.12, 1005, 5),
(006, 14.50, 12, 42.75, 0.25, 1006, 6),
(007, 18.99, 4, 29.99, 0.08, 1007, 7),
(008, 7.25, 7, 15.50, 0.18, 1008, 8),
(009, 11.75,9, 22.25, 0.18, 1009, 9),
(010, 6.99,2, 11.99, 0.04, 1010, 10)

select * from resto.order_menu_detail

create table resto.resto_menus(
    reme_id serial primary key,
    reme_name varchar(55),
    reme_description varchar(255),
    reme_price money,
    reme_status varchar(15) check(reme_status in('available','empty')),
    reme_modified_date timestamp,
    reme_faci_id integer,
    foreign key(reme_faci_id) references resto.facilities(faci_id)
)
insert into resto.resto_menus( reme_faci_id,reme_id, reme_name, reme_description, reme_price,
reme_status, reme_modified_date)values
(1, 1,'Chicken Parmesan', 'Ayam panggang lezat disajikan dengan saus tomat klasik, 
 keju mozzarella meleleh, dan pasta segar.', 12.99, 'available', '2023-05-01'),
(2, 2, 'Beef Steak', 'Irisan daging sapi pilihan dengan cita rasa gurih dan lembut, 
 disajikan dengan saus steak khas dan pilihan biji-bijian.', 18.50, 'available','2023-05-01'),
(3, 3, 'Margherita Pizza', 'Pizza klasik dengan adonan tipis yang ditutupi dengan saus tomat, 
 keju mozzarella segar, dan daun basil.', 9.75, 'available', '2023-05-01'),
(4, 4, 'Grilled Salmon', 'Fillet salmon panggang yang lezat disajikan dengan sayuran panggang dan saus lemon butter.', 
 15.25, 'available', '2023-05-01'),
(5, 5, 'Spaghetti Bolognese', 'Spaghetti al dente yang disajikan dengan saus daging sapi kaya bumbu, tomat, dan rempah-rempah.', 
 8.99, 'empty', '2023-05-01'),
(6, 6, 'Sushi Platter', 'Sushi beragam dengan pilihan ikan segar, nasi yang kenyal, dan dipadu dengan saus soya dan wasabi.', 
 13.50, 'available', '2023-05-01'),
(7, 7, 'Vegetarian Burger', 'Burger lezat dengan patty nabati, keju vegan, dan berbagai pilihan sayuran segar.', 21.99, 'available', '2023-05-01'),
(8, 8, 'BBQ Ribs', 'Iga babi panggang dengan saus barbekyu khas, empuk dan lezat, disajikan dengan kentang panggang dan sayuran.', 7.25, 'empty', '2023-05-01'),
(9, 9, 'Caesar Salad', 'Salad segar dengan daun romaine, ayam panggang, parmesan, dan dressing Caesar klasik.', 11.75, 'available', '2023-05-01'),
(10, 10, 'Shrimp Pad Thai', 'Mi Thailand klasik dengan udang, tauge, kacang, dan bumbu pad Thai yang kaya rempah.', 6.99, 'empty', '2023-05-01')

drop table resto.resto_menus
create table resto.resto_menu_photos(
    remp_id serial primary key,
    remp_thumbnail_filename varchar(50),
    remp_photo_filename varchar(50),
    remp_primary smallint check(remp_primary in (0,1)),
    remp_url varchar(255),
    remp_reme_id integer,
    foreign key(remp_reme_id) references resto.resto_menus(reme_id) 
)
insert into resto.resto_menu_photos (remp_id, remp_thumbnail_filename, remp_photo_filename, 
remp_primary, remp_url, remp_reme_id) values
(1,'menu1_thumb.jpg', 'menu1_thumb', 0, 'https://example.com/menu1_photo.jpg', 1),
(2,'menu2_thumb.jpg', 'menu2_thumb', 1, 'https://example.com/menu2_photo.jpg', 2),
(3,'menu3_thumb.jpg', 'menu3_thumb', 1, 'https://example.com/menu3_photo.jpg', 3), 
(4,'menu4_thumb.jpg', 'menu4_thumb', 1, 'https://example.com/menu4_photo.jpg', 4),
(5,'menu5_thumb.jpg', 'menu5_thumb', 1, 'https://example.com/menu5_photo.jpg', 5),
(6,'menu6_thumb.jpg', 'menu6_thumb', 1, 'https://example.com/menu6_photo.jpg', 6),
(7,'menu7_thumb.jpg', 'menu7_thumb', 1, 'https://example.com/menu7_photo.jpg', 7),
(8,'menu8_thumb.jpg', 'menu8_thumb', 1, 'https://example.com/menu8_photo.jpg', 8),
(9,'menu9_thumb.jpg', 'menu9_thumb', 1, 'https://example.com/menu9_photo.jpg', 9),
(10,'menu10_thumb.jpg', 'menu10_thumb', 0, 'https://example.com/menu10_photo.jpg', 10)

CREATE SEQUENCE seq_order_menus
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function orderMenus() 
	returns varchar as $$
	select CONCAT('MENUS','#',to_char(now(),'YYYYMMDD'),'-',lpad(''||nextval('seq_order_menus'),4,'0'))
end;$$ 
language sql

alter table resto.order_menus alter column orme_order_number set default orderMenus()

create table resto.order_menus(
    orme_id serial primary key,
    orme_order_number varchar(20),
    orme_order_date timestamp,
    orme_total_item smallint,
    orme_total_discount money,
    orme_total_amount money,
    orme_pay_type char(2) check(orme_pay_type in('CR','C', 'D', 'PG', 'BO')),
    orme_cardnumber varchar(25),
    orme_is_paid char(2),
    orme_modified_date timestamp,
    orme_user_id integer,
    foreign key(orme_user_id) references resto.users(user_id)
)
insert into resto.order_menus (orme_id, orme_order_date, orme_total_item, orme_total_discount, 
orme_total_amount, orme_pay_type, orme_cardnumber, orme_is_paid, orme_modified_date, orme_user_id) 
values('1001', '2023-05-01', 5, 0.10, 100,'C', 100-23-5, 'P', '2023-05-02', 1),
('1002', '2023-05-03', 8, 0.16, 75, 'D', 100-12-1, 'B', '2023-05-05', 3),
('1003', '2023-05-06', 3, 0.15, 150, 'D', 100-15-12, 'P', '2023-05-10', 4),
('1004', '2023-05-09', 10, 0.20, 200, 'PG', 100-20-5, 'P', '2023-05-10', 9),
('1005', '2023-05-12', 6, 0.12, 80, 'BO', 100-10-3, 'B', '2023-05-20', 5),
('1006', '2023-05-15', 12, 0.25, 120, 'CR',100-55-10, 'P', '2023-05-15', 2),
('1007', '2023-05-18', 4, 0.08, 90, 'CR', 100-33-53, 'B', '2023-05-19', 6),
('1008', '2023-05-21', 7, 0.18, 175, 'C', 100-10-1, 'P', '2023-05-22', 8),
('1009', '2023-05-24', 9, 0.18, 60, 'PG', 100-21-8, 'B', '2023-05-30', 10),
('1010', '2023-05-27', 2, 0.04, 300, 'BO', 100-5-86, 'P', '2023-05-30', 7)

select * from resto.order_menus
select *from resto.order_menu_detail
select *from resto.resto_menu_photos 
select *from resto.resto_menus