--hotel

create table hotel.facility_photos(
	fapho_id serial,
	fapho_thumbnail_filename varchar(50),
	fapho_photo_filename varchar(50),
	fapho_primary smallint check (fapho_primary in (0,1)),
	fapho_url varchar(255),
	fapho_modified_date timestamp,
	fapho_faci_id integer,
	constraint fapho_faci_id_pk primary key (fapho_id, fapho_faci_id),
	foreign key(fapho_faci_id) references hotel.facilities(faci_id)
)

create table hotel.facility_price_history(
	faph_id serial,
	faph_startdate timestamp,
	faph_enddate timestamp,
	faph_low_price money,
	faph_high_price money,
	faph_rate_price money,
	faph_discount money,
	faph_tax_date timestamp,
	faph_modified_date timestamp,
	faph_faci_id integer,
	faph_user_id integer,
	constraint faph_faci_id_pk primary key (faph_id, faph_faci_id),
	foreign key(faph_faci_id) references hotel.facilities(faci_id),
	foreign key(faph_user_id) references hotel.users(user_id)
)

drop table hotel.facility_price_history

create table hotel.category_group(
	cargo_id serial primary key
)

create table hotel.facilities(
	faci_id serial primary key,
	faci_name varchar(125),
	faci_description varchar(255),
	faci_max_number integer,
	faci_measure_unit varchar(15) check (faci_measure_unit in ('people','beds')),
	faci_room_number varchar(6) unique,
	faci_startdate timestamp,
	faci_enddate timestamp,
	faci_low_price money,
	faci_high_price money,
	faci_rate_price money,
	faci_discount money,
	faci_tax_rate money,
	faci_modified_date timestamp,
	faci_hotel_id integer,
	faci_cargo_id integer,
	foreign key(faci_hotel_id) references hotel.hotels(hotel_id),
	foreign key(faci_cargo_id) references hotel.category_group(cargo_id)
)

create table hotel.address(
	addr_id serial primary key
)

create table hotel.hotels(
	hotel_id serial primary key,
	hotel_name varchar(85),
	hotel_description varchar(500),
	hotel_rating_star smallint,
	hotel_phonenumber varchar(25),
	hotel_modified_date timestamp,
	hotel_addr_id integer,
	foreign key(hotel_addr_id) references hotel.address(addr_id)
)

create table hotel.users(
	user_id serial primary key
)

create table hotel.hotel_reviews(
	hore_id serial primary key,
	hore_user_review varchar(125),
	hore_rating smallint CHECK (hore_rating in (1, 2, 3, 4,5)),
	hore_created_on timestamp,
	hore_hotel_id integer,
	hore_user_id integer,
	foreign key(hore_hotel_id) references hotel.hotels(hotel_id),
	foreign key(hore_user_id) references hotel.users(user_id)
)

drop table hotel.facilities
drop table hotel.facility_photos
drop table hotel.facility_price_history
drop table hotel.hotel_reviews
drop table hotel.hotels cascade

insert into hotel.address(addr_id)
values
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

insert into hotel.category_group(cargo_id)
values
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

insert into hotel.users(user_id)
values
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

insert into hotel.hotels(hotel_id,hotel_name,hotel_description,hotel_rating_star,hotel_phonenumber,hotel_modified_date,hotel_addr_id)
values
(1, 'Hotel A', 'Deskripsi Hotel A', 4, '1234567890', '2023-05-22', 1),
(2, 'Hotel B', 'Deskripsi Hotel B', 3, '9876543210', '2023-05-22', 2),
(3, 'Hotel C', 'Deskripsi Hotel C', 5, '5555555555', '2023-05-22', 3),
(4, 'Hotel D', 'Deskripsi Hotel D', 4, '1111111111', '2023-05-22', 4),
(5, 'Hotel E', 'Deskripsi Hotel E', 2, '9999999999', '2023-05-22', 5),
(6, 'Hotel F', 'Deskripsi Hotel F', 3, '4444444444', '2023-05-22', 6),
(7, 'Hotel G', 'Deskripsi Hotel G', 4, '7777777777', '2023-05-22', 7),
(8, 'Hotel H', 'Deskripsi Hotel H', 5, '2222222222', '2023-05-22', 8),
(9, 'Hotel I', 'Deskripsi Hotel I', 2, '8888888888', '2023-05-22', 9),
(10, 'Hotel J', 'Deskripsi Hotel J', 3, '6666666666', '2023-05-22', 10);


insert into hotel.hotel_reviews(hore_id,hore_user_review,hore_rating,hore_created_on,hore_hotel_id,hore_user_id)
values
(1, 'Ulasan pengguna A', 4.5, '2023-05-22', 1, 1),
(2, 'Ulasan pengguna B', 3.8, '2023-05-22', 1, 2),
(3, 'Ulasan pengguna C', 4.2, '2023-05-22', 2, 3),
(4, 'Ulasan pengguna D', 3.0, '2023-05-22', 3, 4),
(5, 'Ulasan pengguna E', 2.5, '2023-05-22', 4, 5),
(6, 'Ulasan pengguna F', 4.7, '2023-05-22', 4, 6),
(7, 'Ulasan pengguna G', 3.9, '2023-05-22', 5, 7),
(8, 'Ulasan pengguna H', 4.8, '2023-05-22', 6, 8),
(9, 'Ulasan pengguna I', 2.1, '2023-05-22', 7, 9),
(10, 'Ulasan pengguna J', 3.5, '2023-05-22', 8, 10);

insert into hotel.facility_price_history(faph_id,faph_startdate,faph_enddate,faph_low_price,faph_high_price,faph_rate_price,faph_discount,faph_tax_date,faph_modified_date,faph_faci_id,faph_user_id)
values
(1, '2023-05-01', '2023-05-07', 100000, 150000, 120000, 0.1, '2023-05-01', '2023-05-22', 1, 1),
(2, '2023-05-08', '2023-05-14', 90000, 140000, 110000, 0.15, '2023-05-08', '2023-05-22', 1, 2),
(3, '2023-05-01', '2023-05-07', 200000, 250000, 220000, 0.0, '2023-05-01', '2023-05-22', 2, 3),
(4, '2023-05-15', '2023-05-21', 180000, 230000, 200000, 0.05, '2023-05-15', '2023-05-22', 2, 4),
(5, '2023-05-01', '2023-05-07', 50000, 100000, 80000, 0.2, '2023-05-01', '2023-05-22', 3, 5),
(6, '2023-05-08', '2023-05-14', 45000, 90000, 70000, 0.25, '2023-05-08', '2023-05-22', 3, 6),
(7, '2023-05-01', '2023-05-07', 300000, 350000, 320000, 0.0, '2023-05-01', '2023-05-22', 4, 7),
(8, '2023-05-15', '2023-05-21', 280000, 330000, 300000, 0.1, '2023-05-15', '2023-05-22', 4, 8),
(9, '2023-05-01', '2023-05-07', 150000, 200000, 170000, 0.05, '2023-05-01', '2023-05-22', 5, 9),
(10, '2023-05-08', '2023-05-14', 140000, 190000, 160000, 0.0, '2023-05-08', '2023-05-22', 5, 10);

insert into hotel.facility_photos(fapho_id,fapho_thumbnail_filename,fapho_photo_filename,fapho_primary,fapho_url,fapho_modified_date,fapho_faci_id)
values
(1, 'thumbnail1.jpg', 'photo1.jpg', 1, 'https://example.com/photo1.jpg', '2023-05-22', 1),
(2, 'thumbnail2.jpg', 'photo2.jpg', 0, 'https://example.com/photo2.jpg', '2023-05-22', 2),
(3, 'thumbnail3.jpg', 'photo3.jpg', 1, 'https://example.com/photo3.jpg', '2023-05-22', 3),
(4, 'thumbnail4.jpg', 'photo4.jpg', 1, 'https://example.com/photo4.jpg', '2023-05-22', 4),
(5, 'thumbnail5.jpg', 'photo5.jpg', 0, 'https://example.com/photo5.jpg', '2023-05-22', 5),
(6, 'thumbnail6.jpg', 'photo6.jpg', 1, 'https://example.com/photo6.jpg', '2023-05-22', 6),
(7, 'thumbnail7.jpg', 'photo7.jpg', 1, 'https://example.com/photo7.jpg', '2023-05-22', 7),
(8, 'thumbnail8.jpg', 'photo8.jpg', 0, 'https://example.com/photo8.jpg', '2023-05-22', 8),
(9, 'thumbnail9.jpg', 'photo9.jpg', 1, 'https://example.com/photo9.jpg', '2023-05-22', 9),
(10, 'thumbnail10.jpg', 'photo10.jpg', 1, 'https://example.com/photo10.jpg', '2023-05-22', 10);


insert into hotel.facilities(faci_id,faci_name,faci_description,faci_max_number,faci_measure_unit,faci_room_number,faci_startdate,faci_enddate,faci_low_price,faci_high_price,faci_rate_price,faci_discount,faci_tax_rate,faci_modified_date,faci_hotel_id,faci_cargo_id)
values
(1, 'Kolam Renang', 'Fasilitas kolam renang', 50, 'people', 2, '2023-05-01', '2023-06-02', 100000, 150000, 120000, 0.1, 0.05, '2023-05-22', 1, 1),
(2, 'Gym', 'Fasilitas pusat kebugaran', 30, 'people', 1, '2023-05-01', '2023-06-02', 200000, 250000, 220000, 0.0, 0.05, '2023-05-22', 1, 2),
(3, 'Restoran', 'Fasilitas restoran', 10, 'people', 4, '2023-05-01', '2023-06-02', 50000, 100000, 80000, 0.2, 0.1, '2023-05-22', 2, 3),
(4, 'Spa', 'Fasilitas spa', 8, 'beds', 6, '2023-05-01', '2023-06-02', 300000, 350000, 320000, 0.0, 0.05, '2023-05-22', 2, 4),
(5, 'Lapangan Tenis', 'Fasilitas lapangan tenis', 3, 'people', 7, '2023-05-01', '2023-06-02', 150000, 200000, 170000, 0.05, 0.0, '2023-05-22', 3, 5),
(6, 'Ruang Pertemuan', 'Fasilitas ruang pertemuan', 5, 'beds', 8, '2023-05-01', '2023-06-02', 400000, 450000, 420000, 0.1, 0.1, '2023-05-22', 3, 6),
(7, 'Kolam Renang', 'Fasilitas kolam renang', 30, 'people', 9, '2023-05-01', '2023-06-02', 200000, 250000, 220000, 0.0, 0.05, '2023-05-22', 4, 7),
(8, 'Ruang Serbaguna', 'Fasilitas ruang serbaguna', 1, 'beds', 3, '2023-05-01', '2023-06-02', 300000, 350000, 320000, 0.0, 0.0, '2023-05-22', 4, 8),
(9, 'Kolam Renang', 'Fasilitas kolam renang', 40, 'people', 5, '2023-05-01', '2023-06-02', 150000, 200000, 170000, 0.05, 0.05, '2023-05-22', 5, 9),
(10, 'Lapangan Bulu Tangkis', 'Fasilitas lapangan bulu tangkis', 2, 'beds', 10, '2023-05-01', '2023-06-02', 100000, 150000, 120000, 0.0, 0.05, '2023-05-22', 2, 10);

select *from hotel.facilities
select *from hotel.facility_photos
select *from hotel.facility_price_history
select *from hotel.hotel_reviews
select *from hotel.hotels

