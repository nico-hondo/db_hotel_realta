--booking
create table booking.users(
	user_id integer primary key
)

create table booking.special_offers(
    spof_id serial primary key, 
    spof_name varchar(55),
    spof_description varchar(255),
    spof_type varchar(50) CHECK (spof_type in ('T', 'C', 'I')),
    spof_discount money,
    spof_start_date timestamp,
    spof_end_date timestamp,
    spof_min_qty integer,
    spof_max_qty integer,
    spof_modified_date timestamp
);

create table booking.special_offers_coupons(
    soco_id serial primary key,
    soco_borde integer,
    soco_spof_id integer,
    foreign key (soco_borde) references booking.booking_order_detail(borde_id),
    foreign key (soco_spof_id) references booking.special_offers(spof_id)
);

create table booking.booking_orders(
    boor_id serial primary key,
    boor_order_number varchar(20),
    boor_order_date timestamp,
    boor_arrival_date timestamp,
    boor_total_room smallint,
    boor_total_geust smallint,
    boor_discount money,
    boor_total_tax money,
    boor_total_amount money,
    boor_down_payment money,
    boor_pay_type char(2) CHECK (boor_pay_type in ('CR', 'C', 'D', 'PG')),
    boor_is_paid char(2) CHECK (boor_is_paid in ('DP', 'P', 'R')),
    boor_type varchar(15) CHECK (boor_type in ('T', 'C', 'I')),
    boor_cardnumber varchar(25),
    boor_member_type varchar(15),
    boor_status varchar(15) CHECK (boor_status in ('booking', 'checkin', 'checkout', 'cleaning', 'cancelled')),
    boor_user_id integer, 
    boor_hotel_id integer,
    CONSTRAINT boor_order_number_check CHECK (boor_order_number ~ '^BO#\d{8}-\d{4}$'),
    foreign key (boor_user_id) references booking.users(user_id),
    foreign key (boor_hotel_id) references hotel.hotels(hotel_id)
);

CREATE SEQUENCE seq_booking_orders
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1

create or replace function orderNumber() 
	returns varchar as $$
	select CONCAT('BO','#',to_char(now(),'YYYYMMDD'),'-',lpad(''||nextval('seq_booking_orders'),4,'0'))
end;$$ 
language sql

alter table booking.booking_orders alter column boor_order_number set default orderNumber()


create table booking.booking_order_detail(
    borde_id serial primary key,
    borde_checkin timestamp,
    borde_checkout timestamp,
    borde_adults integer,
    borde_kids integer,
    borde_price money,
    borde_extra money,
    borde_discount money,
    borde_tax money,
    borde_subtotal money,
	border_boor_id integer,
    borde_faci_id integer,
    foreign key (border_boor_id) references booking.booking_orders(boor_id),
    foreign key (borde_faci_id) references hotel.facilities(faci_id)
);
select * from booking.booking_order_detail

create table booking.user_breakfast(
    usbr_borde_id integer,
    usbr_modified_date timestamp,
    usbr_total_vacant smallint,
    foreign key (usbr_borde_id) references booking.booking_order_detail(borde_id),
    constraint user_breakfast_pk primary key (usbr_borde_id, usbr_modified_date)
);

create table booking.booking_order_detail_extra(
    boex_id serial primary key,
    boex_price money,
    boex_qty smallint,
    boex_subtotal money,
    boex_measure_unit varchar(50) CHECK (boex_measure_unit in ('people', 'unit', 'kg')),
    boex_borde_id integer,
    boex_prit_id integer,
    foreign key (boex_borde_id) references booking.booking_order_detail(borde_id),
    foreign key (boex_prit_id) references booking.price_items(prit_id)
);

create table booking.price_items(
    prit_id integer primary key
);

select *from booking.special_offers

INSERT INTO booking.special_offers (spof_id, spof_name, spof_description, spof_type, spof_discount, spof_start_date, spof_min_qty, spof_max_qty, spof_modified_date)
VALUES
  (1, 'Spof 1', 'Spof 1 Description', 'T', 0.1, '2023-05-22', 2, 5, '2023-05-22'),
  (2, 'Spof 2', 'Spof 2 Description', 'C', 0.2, '2023-05-23', 3, 6, '2023-05-23'),
  (3, 'Spof 3', 'Spof 3 Description', 'I', 0.15, '2023-05-24', 1, 4, '2023-05-24'),
  (4, 'Spof 4', 'Spof 4 Description', 'T', 0.3, '2023-05-25', 2, 5, '2023-05-25'),
  (5, 'Spof 5', 'Spof 5 Description', 'C', 0.25, '2023-05-26', 3, 6, '2023-05-26'),
  (6, 'Spof 6', 'Spof 6 Description', 'I', 0.2, '2023-05-27', 1, 4, '2023-05-27'),
  (7, 'Spof 7', 'Spof 7 Description', 'T', 0.35, '2023-05-28', 2, 5, '2023-05-28'),
  (8, 'Spof 8', 'Spof 8 Description', 'C', 0.3, '2023-05-29', 3, 6, '2023-05-29'),
  (9, 'Spof 9', 'Spof 9 Description', 'I', 0.25, '2023-05-30', 1, 4, '2023-05-30'),
  (10, 'Spof 10', 'Spof 10 Description', 'T', 0.4, '2023-05-31', 2, 5, '2023-05-31');

INSERT INTO booking.booking_orders (boor_id, boor_order_date, boor_arrival_date, boor_total_room, boor_total_geust, boor_discount, boor_total_tax, boor_total_amount, boor_down_payment, boor_pay_type, boor_is_paid, boor_type, boor_cardnumber, boor_member_type, boor_status, boor_user_id, boor_hotel_id)
VALUES
  (1, '2023-05-22', '2023-05-25', 2, 4, 0.1, 50.0, 500.0, 100.0, 'CR', 'DP', 'T', '1234567890123456', 'Gold', 'booking', 1, 1),
  (2, '2023-05-23', '2023-05-26', 3, 6, 0.2, 60.0, 600.0, 200.0, 'C', 'P', 'C', '2345678901234567', 'Silver', 'checkin', 2, 2),
  (3, '2023-05-24', '2023-05-27', 1, 2, 0.05, 20.0, 200.0, 50.0, 'D', 'R', 'I', '3456789012345678', 'Platinum', 'checkout', 3, 3),
  (4, '2023-05-25', '2023-05-28', 4, 8, 0.15, 70.0, 700.0, 150.0, 'PG', 'DP', 'T', '4567890123456789', 'Silver', 'cleaning', 4, 4),
  (5, '2023-05-26', '2023-05-29', 2, 4, 0.1, 30.0, 300.0, 100.0, 'CR', 'R', 'C', '5678901234567890', 'Gold', 'cancelled', 5, 5),
  (6, '2023-05-27', '2023-05-30', 1, 2, 0.05, 10.0, 100.0, 50.0, 'C', 'P', 'I', '6789012345678901', 'Silver', 'booking', 6, 6),
  (7, '2023-05-28', '2023-05-31', 3, 6, 0.2, 40.0, 400.0, 200.0, 'D', 'R', 'T', '7890123456789012', 'Platinum', 'checkin', 7, 7),
  (8, '2023-05-29', '2023-06-01', 2, 4, 0.1, 50.0, 500.0, 100.0, 'PG', 'P', 'C', '8901234567890123', 'Silver', 'checkout', 8, 8),
  (9, '2023-05-30', '2023-06-02', 1, 2, 0.05, 20.0, 200.0, 50.0, 'D', 'DP', 'T', '901234567890123', 'Silver', 'cleaning', 9, 9),
  (10, '2023-05-31', '2023-06-03', 2, 4, 0.15, 60.0, 600.0, 100.0, 'C', 'DP', 'I', '5678901234567890', 'Silver', 'cancelled', 10, 10);

select *from booking.users
select *from booking.booking_orders
select *from booking.booking_order_detail

INSERT INTO booking.booking_order_detail (borde_id, borde_checkin, borde_checkout, borde_adults, borde_kids, borde_price, borde_extra, borde_discount, borde_tax, borde_subtotal, border_boor_id, borde_faci_id)
VALUES
  (1, '2023-05-22', '2023-05-25', 2, 1, 100.0, 10.0, 0.1, 5.0, 115.0, 1, 1),
  (2, '2023-05-23', '2023-05-26', 1, 0, 80.0, 5.0, 0.05, 4.0, 79.0, 1, 2),
  (3, '2023-05-24', '2023-05-27', 2, 2, 120.0, 20.0, 0.15, 6.0, 142.0, 2, 3),
  (4, '2023-05-25', '2023-05-28', 3, 1, 150.0, 15.0, 0.2, 8.0, 164.0, 2, 4),
  (5, '2023-05-26', '2023-05-29', 2, 0, 90.0, 5.0, 0.1, 4.5, 94.5, 3, 5),
  (6, '2023-05-27', '2023-05-30', 1, 1, 70.0, 10.0, 0.05, 3.5, 77.5, 3, 6),
  (7, '2023-05-28', '2023-05-31', 4, 2, 200.0, 30.0, 0.3, 10.0, 240.0, 4, 7),
  (8, '2023-05-29', '2023-06-01', 2, 0, 110.0, 10.0, 0.1, 5.5, 124.5, 4, 8),
  (9, '2023-05-30', '2023-06-02', 1, 0, 80.0, 5.0, 0.05, 4.0, 79.0, 5, 9),
  (10, '2023-05-31', '2023-06-03', 2, 1, 120.0, 15.0, 0.2, 6.0, 141.0, 5, 10);

select *from booking.booking_order_detail_extra
INSERT INTO booking.booking_order_detail_extra (boex_id, boex_price, boex_qty, boex_subtotal, boex_measure_unit, boex_borde_id, boex_prit_id)
VALUES
  (1, 10.0, 2, 20.0, 'people', 1, 1),
  (2, 5.0, 1, 5.0, 'unit', 2, 2),
  (3, 15.0, 3, 45.0, 'kg', 3, 3),
  (4, 8.0, 2, 16.0, 'people', 4, 4),
  (5, 7.0, 1, 7.0, 'unit', 5, 5),
  (6, 12.0, 2, 24.0, 'kg', 6, 6),
  (7, 20.0, 1, 20.0, 'people', 7, 7),
  (8, 3.0, 3, 9.0, 'unit', 8, 8),
  (9, 6.0, 2, 12.0, 'unit', 9, 9),
  (10, 9.0, 1, 9.0, 'people', 10, 10);

INSERT INTO booking.special_offers_coupons (soco_id, soco_borde, soco_spof_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10)

INSERT INTO booking.price_items(prit_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

INSERT INTO booking.users(user_id) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);


select *from booking.user_breakfast
INSERT INTO booking.user_breakfast (usbr_borde_id, usbr_modified_date, usbr_total_vacant) 
VALUES
  (1, '2023-05-22', 5),
  (2, '2023-05-23', 3),
  (3, '2023-05-24', 2),
  (4, '2023-05-25', 4),
  (5, '2023-05-26', 6),
  (6, '2023-05-27', 1),
  (7, '2023-05-28', 0),
  (8, '2023-05-29', 2),
  (9, '2023-05-30', 3),
  (10, '2023-05-31', 4);
