create table purchasing.entity (
	entity_id serial primary key
)

create table purchasing.stocks (
	stock_id serial primary key,
	stock_name varchar(255),
	stock_description varchar(255),
	stock_quantity smallint,
	stock_reorder_point smallint,
	stock_used smallint,
	stock_scrap smallint,
	stock_size varchar(25),
	stock_color varchar(15),
	stock_modified_date timestamp
)

create table purchasing.stock_photo (
	spho_id serial primary key,
	spho_tumbnail_filename varchar(50),
	spho_photo_filename varchar(50),
	spho_primary smallint CHECK (spho_primary IN (0, 1)),
	spho_url varchar(255),
	spho_stock_id integer,
	foreign key (spho_stock_id) references purchasing.stocks (stock_id)
)

create table purchasing.vendor (
	vendor_entity_id serial,
	vendor_name varchar(55),
	vendor_active smallint CHECK (vendor_active IN (0, 1)),
    vendor_priority smallint CHECK (vendor_priority IN (0, 1)),
    vendor_register_date timestamp,
    vendor_weburl varchar(1024),
    vendor_modified_date timestamp,
    CONSTRAINT vendor_id primary key (vendor_entity_id),
    foreign key (vendor_entity_id) references purchasing.entity (entity_id)
)

create table purchasing.facilities (
    faci_id serial primary key
)

create table purchasing.vendor_product(
    vepro_id serial primary key,
    vepro_qty_stocked integer,
    vepro_qty_remaining integer,
    vepro_price money,
    vepro_stock_id integer,
    vepro_vendor_id integer,
    foreign key (vepro_stock_id) references purchasing.stocks (stock_id),
    foreign key (vepro_vendor_id) references purchasing.vendor (vendor_entity_id)
)

create table purchasing.employee (
    emp_id integer primary key
)

create table purchasing.purchase_order_header (
    pohe_id serial primary key,
    pohe_number varchar(20) UNIQUE,
    pohe_status integer CHECK (pohe_status IN(1, 2, 3, 4)),
    pohe_order_date timestamp,
    pohe_subtotal money,
    pohe_tax money,
    pohe_total_ammount money,
    pohe_refund money,
    pohe_arrival_date timestamp,
    pohe_pay_type char(2) CHECK (pohe_pay_type IN ('TR', 'CA')),
    pohe_emp_id integer,
    pohe_vendor_id integer,
    foreign key (pohe_vendor_id) references purchasing.vendor (vendor_entity_id),
    foreign key (pohe_emp_id) references purchasing.employee (emp_id)
)

create table purchasing.purchase_order_detail (
    pode_pohe_id integer primary key,
    pode_id serial,
    pode_order_qty smallint,
    pode_price money,
    pode_line_total money,
    pode_received_qty decimal(8,2),
    pode_rejected_qty decimal(8,2),
    pode_stocked_qty decimal(9,2),
    pode_modified_date timestamp,
    pode_stock_id integer,
    foreign key (pode_pohe_id) references purchasing.purchase_order_header (pohe_id),
    foreign key (pode_stock_id) references purchasing.stocks (stock_id)
)

create table purchasing.stock_detail (
    stod_stock_id integer,
    stod_id serial,
    stod_barcode_number varchar(255) UNIQUE,
    stod_status integer CHECK (stod_status IN (1, 2, 3, 4)),
    stod_notes varchar(1024),
    stod_faci_id integer,
    stod_pohe_id integer,
    constraint stod primary key (stod_stock_id, stod_id),
    foreign key (stod_faci_id) references purchasing.facilities (faci_id),
    foreign key (stod_pohe_id) references purchasing.purchase_order_header (pohe_id)
)
select * from purchasing.purchase_order_header
INSERT INTO purchasing.entity (entity_id) VALUES 
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

INSERT INTO purchasing.vendor (vendor_name, vendor_active, vendor_priority, vendor_register_date, vendor_weburl, vendor_modified_date) 
VALUES 
    ('ABC Corporation', 1, 1, '2022-01-15', 'http://www.abc-corporation.com', '2023-04-05'),
    ('XYZ Industries', 1, 0, '2021-11-20', 'http://www.xyz-industries.com', '2023-02-10'),
    ('PQR Solutions', 1, 1, '2023-03-08', 'http://www.pqr-solutions.com', '2023-05-18'),
    ('LMN Technologies', 1, 1, '2022-07-10', 'http://www.lmn-technologies.com', '2023-03-22'),
    ('EFG Enterprises', 1, 0, '2023-01-05', 'http://www.efg-enterprises.com', '2023-05-08'),
    ('HIJ Services', 1, 1, '2021-09-25', 'http://www.hij-services.com', '2023-01-14'),
    ('RST Solutions', 1, 0, '2022-05-02', 'http://www.rst-solutions.com', '2023-04-30'),
    ('UVW Incorporated', 1, 1, '2023-02-18', 'http://www.uvw-incorporated.com', '2023-05-15'),
    ('MNO Systems', 1, 0, '2021-12-12', 'http://www.mno-systems.com', '2023-03-01'),
    ('QWE Enterprises', 1, 1, '2022-09-08', 'http://www.qwe-enterprises.com', '2023-04-10');

INSERT INTO purchasing.stocks (stock_name, stock_description, stock_quantity, stock_reorder_point, stock_used, stock_scrap, stock_size, stock_color, stock_modified_date)
VALUES
    ('Baju Polos', 'Baju polos berwarna putih', 50, 10, 0, 0, 'M', 'Putih', '2023-05-01'),
    ('Sepatu Sneakers', 'Sepatu sneakers dengan desain modern', 30, 5, 0, 0, '40', 'Hitam', '2023-05-02'),
    ('Tas Ransel', 'Tas ransel dengan banyak kantong', 20, 4, 0, 0, 'One Size', 'Abu-abu', '2023-05-03'),
    ('Jam Tangan Analog', 'Jam tangan analog dengan tali kulit', 15, 3, 0, 0, 'One Size', 'Cokelat', '2023-05-04'),
    ('Celana Panjang Jeans', 'Celana panjang jeans slim fit', 40, 8, 0, 0, '32', 'Biru', '2023-05-05'),
    ('Topi Baseball', 'Topi baseball dengan logo bordir', 25, 5, 0, 0, 'One Size', 'Hitam', '2023-05-06'),
    ('Kemeja Flanel', 'Kemeja flanel motif kotak-kotak', 35, 7, 0, 0, 'L', 'Merah', '2023-05-07'),
    ('Dompet Kulit', 'Dompet kulit dengan slot kartu', 60, 12, 0, 0, 'One Size', 'Cokelat', '2023-05-08'),
    ('Handuk Mandi', 'Handuk mandi yang lembut dan menyerap', 50, 10, 0, 0, 'One Size', 'Putih', '2023-05-09'),
    ('Botol Minum Stainless Steel', 'Botol minum stainless steel tahan bocor', 30, 6, 0, 0, '750ml', 'Silver', '2023-05-10');

INSERT INTO purchasing.stock_photo (spho_tumbnail_filename, spho_photo_filename, spho_primary, spho_url, spho_stock_id)
VALUES
    ('thumbnail1.jpg', 'photo1.jpg', 1, 'http://example.com/photo1.jpg', 1),
    ('thumbnail2.jpg', 'photo2.jpg', 0, 'http://example.com/photo2.jpg', 1),
    ('thumbnail3.jpg', 'photo3.jpg', 1, 'http://example.com/photo3.jpg', 2),
    ('thumbnail4.jpg', 'photo4.jpg', 1, 'http://example.com/photo4.jpg', 3),
    ('thumbnail5.jpg', 'photo5.jpg', 0, 'http://example.com/photo5.jpg', 3),
    ('thumbnail6.jpg', 'photo6.jpg', 1, 'http://example.com/photo6.jpg', 4),
    ('thumbnail7.jpg', 'photo7.jpg', 0, 'http://example.com/photo7.jpg', 5),
    ('thumbnail8.jpg', 'photo8.jpg', 1, 'http://example.com/photo8.jpg', 6),
    ('thumbnail9.jpg', 'photo9.jpg', 1, 'http://example.com/photo9.jpg', 7),
    ('thumbnail10.jpg', 'photo10.jpg', 0, 'http://example.com/photo10.jpg', 8);

INSERT INTO purchasing.vendor_product (vepro_qty_stocked, vepro_qty_remaining, vepro_price, vepro_stock_id, vepro_vendor_id)
VALUES
    (100, 80, 50.99, 1, 1),
    (50, 40, 75.50, 2, 1),
    (200, 150, 30.99, 3, 2),
    (80, 60, 45.75, 4, 3),
    (120, 90, 65.25, 5, 4),
    (70, 50, 55.50, 6, 5),
    (150, 100, 25.99, 7, 6),
    (90, 70, 38.25, 8, 7),
    (180, 130, 80.50, 9, 8),
    (60, 50, 45.99, 10, 9);

INSERT INTO purchasing.facilities (faci_id) VALUES 
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

INSERT INTO purchasing.stock_detail (stod_stock_id, stod_barcode_number, stod_status, stod_notes, stod_faci_id, stod_pohe_id)
VALUES
    (1, 'AB123CD', 1, 'Baju polos berwarna putih', 1, 1),
    (1, 'XY456EF', 2, 'Baju polos berwarna putih', 2, 2),
    (2, 'PQ789GH', 1, 'Sepatu sneakers dengan desain modern', 3, 3),
    (3, 'JK321LM', 3, 'Tas ransel dengan banyak kantong', 4, 4),
    (4, 'RS654NO', 2, 'Jam tangan analog dengan tali kulit', 5, 5),
    (5, 'UV987IJ', 1, 'Celana panjang jeans slim fit', 1, 6),
    (6, 'DE123FG', 4, 'Topi baseball dengan logo bordir', 2, 7),
    (7, 'HI456KL', 3, 'Kemeja flanel motif kotak-kotak', 3, 8),
    (8, 'MN789OP', 1, 'Dompet kulit dengan slot kartu', 4, 9),
    (9, 'QR321ST', 2, 'Handuk mandi yang lembut dan menyerap', 5, 10);


INSERT INTO purchasing.employee (emp_id) VALUES 
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

INSERT INTO purchasing.purchase_order_header (pohe_number, pohe_status, pohe_order_date, pohe_subtotal, pohe_tax, pohe_total_ammount, pohe_refund, pohe_arrival_date, pohe_pay_type, pohe_emp_id, pohe_vendor_id)
VALUES
    ('PO001', 1, '2023-05-01', 1000.00, 100.00, 1100.00, 0.00, '2023-05-10', 'TR', 1, 1),
    ('PO002', 2, '2023-05-02', 1500.00, 150.00, 1650.00, 0.00, '2023-05-12', 'CA', 2, 2),
    ('PO003', 3, '2023-05-03', 800.00, 80.00, 880.00, 0.00, '2023-05-15', 'TR', 3, 3),
    ('PO004', 1, '2023-05-04', 1200.00, 120.00, 1320.00, 0.00, '2023-05-08', 'CA', 4, 4),
    ('PO005', 4, '2023-05-05', 900.00, 90.00, 990.00, 0.00, '2023-05-20', 'TR', 5, 5),
    ('PO006', 2, '2023-05-06', 2000.00, 200.00, 2200.00, 0.00, '2023-05-13', 'CA', 6, 6),
    ('PO007', 1, '2023-05-07', 1800.00, 180.00, 1980.00, 0.00, '2023-05-09', 'TR', 7, 7),
    ('PO008', 3, '2023-05-08', 700.00, 70.00, 770.00, 0.00, '2023-05-17', 'CA', 8, 8),
    ('PO009', 2, '2023-05-09', 1600.00, 160.00, 1760.00, 0.00, '2023-05-14', 'TR', 9, 9),
    ('PO010', 4, '2023-05-10', 1000.00, 100.00, 1100.00, 0.00, '2023-05-18', 'CA', 10, 10);


INSERT INTO purchasing.purchase_order_detail (pode_pohe_id, pode_order_qty, pode_price, pode_line_total, pode_received_qty, pode_rejected_qty, pode_stocked_qty, pode_modified_date, pode_stock_id)
VALUES
    (1, 10, 9.99, 99.90, 5.00, 0.00, 5.00, '2023-05-01', 1),
    (2, 5, 19.99, 99.95, 5.00, 0.00, 5.00, '2023-05-01', 2),
    (3, 8, 14.99, 119.92, 8.00, 0.00, 8.00, '2023-05-02', 3),
    (4, 15, 12.99, 194.85, 10.00, 0.00, 10.00, '2023-05-03', 4),
    (5, 20, 8.99, 179.80, 20.00, 0.00, 20.00, '2023-05-04', 5),
    (6, 12, 11.99, 143.88, 12.00, 0.00, 12.00, '2023-05-05', 6),
    (7, 6, 16.99, 101.94, 4.00, 0.00, 4.00, '2023-05-06', 7),
    (8, 18, 7.99, 143.82, 15.00, 0.00, 15.00, '2023-05-07', 8),
    (9, 10, 9.99, 99.90, 8.00, 0.00, 8.00, '2023-05-08', 9),
    (10, 5, 19.99, 99.95, 5.00, 0.00, 5.00, '2023-05-09', 10);
	
select *from purchasing.employee
select *from purchasing.entity
select *from purchasing.facilities
select *from purchasing.purchase_order_detail
select *from purchasing.purchase_order_header
select *from purchasing.stock_detail
select *from purchasing.stock_photo
select *from purchasing.stocks
select *from purchasing.vendor
select *from purchasing.vendor_product