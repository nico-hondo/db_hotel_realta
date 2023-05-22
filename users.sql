CREATE TABLE users.members(
    memb_name VARCHAR(15) PRIMARY KEY
);


CREATE TABLE users.users(
	user_id SERIAL PRIMARY KEY,
	user_full_name VARCHAR(55),
	user_type VARCHAR(100) CHECK (user_type IN ('T = Travel Agent', 'C = Corporate', 'I = Individual')),
	user_company_name VARCHAR(225),
	user_email VARCHAR(256),
	user_phone_number VARCHAR(25) UNIQUE,
	user_modified_date TIMESTAMP
);

CREATE SEQUENCE seq_user_full_name
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1;

create or replace function user_full_name() 
	returns varchar as $$
	select CONCAT('guest',lpad(''||nextval('seq_user_full_name'),5))

end;$$
language sql;

alter table users.users alter column user_full_name set default user_full_name();



CREATE TABLE users.user_members(
    usme_user_id INTEGER,
    usme_memb_name VARCHAR(15) CHECK (usme_memb_name IN ('SILVER' , 'GOLD' , 'VIP', 'WIZARD')),
    usme_promote_date TIMESTAMP,
    usme_points SMALLINT,
    usme_type VARCHAR(15) CHECK (usme_type IN ('default', 'expired')),
	FOREIGN KEY (usme_user_id) REFERENCES users.users(user_id),
	FOREIGN KEY (usme_memb_name) REFERENCES users.members(memb_name),
	PRIMARY KEY (usme_user_id, usme_memb_name)
);

select * from users.user_members


CREATE TABLE users.roles(
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR(35)
);

CREATE TABLE users.user_roles(
    usro_user_id INTEGER,
    usro_role_id INTEGER,
    FOREIGN KEY (usro_user_id) REFERENCES users.users(user_id),
	FOREIGN KEY (usro_role_id) REFERENCES users.roles(role_id),
	CONSTRAINT user_roles_pk PRIMARY KEY (usro_user_id, usro_role_id)
);

CREATE TABLE users.address(
	addr_id serial primary key
);

CREATE TABLE users.user_profiles(
	uspro_id SERIAL PRIMARY KEY,
	uspro_national_id VARCHAR(20),
	uspro_birt_date TIMESTAMP,
	uspro_job_title VARCHAR(50),
	uspro_marital_status CHAR(1) CHECK (uspro_marital_status IN ('M', 'S')),
	uspro_gender CHAR(1) CHECK (uspro_gender IN ('F', 'M')),
	uspro_addr_id INTEGER,
	uspro_user_id INTEGER,
	FOREIGN KEY	(uspro_addr_id) REFERENCES users.address(addr_id),
	FOREIGN KEY (uspro_user_id) REFERENCES users.users(user_id)
);

CREATE TABLE users.user_bonus_points(
	ubpo_id SERIAL,
	ubpo_user_id INTEGER,
	ubpo_total_point SMALLINT,
	ubpo_bonus_type CHAR(1) CHECK (ubpo_bonus_type IN ('R' ,'P')),
	ubpo_created_on TIMESTAMP,
	FOREIGN KEY (ubpo_user_id) REFERENCES users.users(user_id),
	CONSTRAINT user_bonus_points_pk PRIMARY KEY (ubpo_id, ubpo_user_id)
);

CREATE TABLE users.user_password(
	uspa_user_id SERIAL PRIMARY KEY,
	uspa_passwordHash VARCHAR(128),
	uspa_passwordSalt VARCHAR(10),
	FOREIGN KEY (uspa_user_id) REFERENCES users.users(user_id)
);


insert into users.members (memb_name)
VALUES
('SILVER'),
('GOLD'),
('VIP'),
('WIZARD');

SELECT * FROM users.members;

insert into users.users (user_type,user_company_name,user_email,user_phone_number,user_modified_date)
values
('T = Travel Agent', 'PT A',' adi.smith@xyzindustries.com', '503-555-9832','2023-05-22'),
('C = Corporate', 'PT B',' ana.smith@xyzindustries.com','503-555-3197','2023-06-23'),
('I = Individual', 'PT C',' cika.smith@xyzindustries.com', '503-556-9931','2023-07-24'),
('I = Individual', 'PT D',' bryan.smith@xyzindustries.com','1-800-222-0491','2023-08-25'),
('C = Corporate', 'PT E',' paul.smith@xyzindustries.com','1-800-782-7892','2023-09-26'),
('T = Travel Agent', 'PT F',' dian.smith@xyzindustries.com', '503-555-9831','2023-10-27'),
('T = Travel Agent', 'PT G',' milea.smith@xyzindustries.com','503-555-3199','2023-11-28'),
('C = Corporate', 'PT H',' nathan.smith@xyzindustries.com','503-555-9931','2023-12-29'),
('T = Travel Agent', 'PT I',' salma.smith@xyzindustries.com','1-800-222-0451','2022-01-01'),
('T = Travel Agent', 'PT J',' rangga.smith@xyzindustries.com','1-800-225-5345','2022-02-02');
select * from users.users;

insert into users.user_members (usme_user_id, usme_memb_name, usme_promote_date, usme_points, usme_type)
values
('1', 'SILVER','1990-01-01','1','default'),
('2','GOLD','1985-05-15','2','expired'),
('3','GOLD', '1982-09-30','3','default'),
('4','SILVER','1995-07-20','4','expired'),
('5','GOLD','1993-12-10','5','default'),
('6','SILVER','1988-06-25','6','expired'),
('7','WIZARD','1979-03-12','7','default'),
('8','VIP','1991-11-05','8','expired'),
('9','SILVER','1987-08-18','9','default'),
('10','WIZARD','1994-04-05','10','expired');
select * from users.user_members

INSERT INTO users.roles (role_id, role_name)
VALUES
(1, 'Role 1'),
(2, 'Role 2'),
(3, 'Role 3'),
(4, 'Role 4'),
(5, 'Role 5'),
(6, 'Role 6'),
(7, 'Role 7'),
(8, 'Role 8'),
(9, 'Role 9'),
(10, 'Role 10');
SELECT * FROM users.roles;

INSERT INTO users.user_roles (usro_user_id, usro_role_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);
SELECT * FROM users.user_roles;

insert into users.address (addr_id) VALUES 
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
	
SELECT * FROM USERS.ADDRESS

insert into users.user_profiles (uspro_id,uspro_national_id,uspro_birt_date,uspro_job_title ,uspro_marital_status,uspro_gender,uspro_addr_id,uspro_user_id)
	values
 ('1','1234567890', '1990-01-01',' manager', 'M','F','1','1'),
 ('2','0987654321', '1985-05-15',' designer','S','M','2','2'),
 ('3', '2468135790', '1982-09-30',' analyst', 'S','M','3','3'),
 ('4', '1357924680', '1995-07-20',' developer','M','F','4','4'),
 ('5', '9876543210', '1993-12-10',' executive','S','M','5','5'),
 ('6',  '2468013579', '1988-06-25',' chef', 'M','F','6','6'),
 ('7', '9876543211', '1979-03-12',' backend','S','M','7','7'),
 ('8', '1357924681', '1991-11-05',' programmer','M','F','8','3'),
 ('9', '0987654322', '1987-08-18',' painting','S','M','9','4'),
 ('10', '1234567891', '1994-04-05',' data statistic','M','F','10','6');
 select * from users.user_profiles
 
 INSERT INTO users.user_bonus_points (
	ubpo_id,
	ubpo_user_id,
	ubpo_total_point,
	ubpo_bonus_type,
	ubpo_created_on)
	values
(1, 1, 100, 'R', '2023-01-01 10:00:00'),
(2, 1, 50, 'P', '2023-02-02 11:00:00'),
(3, 2, 200, 'R', '2023-03-03 12:00:00'),
(4, 2, 75, 'P', '2023-04-04 13:00:00'),
(5, 3, 150, 'R', '2023-05-05 14:00:00'),
(6, 3, 90, 'P', '2023-06-06 15:00:00'),
(7, 4, 250, 'R', '2023-07-07 16:00:00'),
(8, 4, 80, 'P', '2023-08-08 17:00:00'),
(9, 5, 180, 'R', '2023-09-09 18:00:00'),
(10, 5, 60, 'P', '2023-10-10 19:00:00');
select * from users.user_bonus_points

INSERT INTO users.user_password (
	uspa_user_id,
	uspa_passwordHash,
	uspa_passwordSalt)
	values
(1, 'hash1', 'salt1'),
(2, 'hash2', 'salt2'),
(3, 'hash3', 'salt3'),
(4, 'hash4', 'salt4'),
(5, 'hash5', 'salt5'),
(6, 'hash6', 'salt6'),
(7, 'hash7', 'salt7'),
(8, 'hash8', 'salt8'),
(9, 'hash9', 'salt9'),
(10, 'hash10', 'salt10');

select * from users.user_password