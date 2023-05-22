--payment

CREATE TABLE payment.entity (
	entity_id SERIAL PRIMARY KEY
);

CREATE TABLE payment.bank (
	bank_entity_id INTEGER PRIMARY KEY,
	bank_code VARCHAR(10) UNIQUE,
	bank_name VARCHAR(55) UNIQUE,
	bank_modified_date TIMESTAMP,
	FOREIGN KEY (bank_entity_id) REFERENCES payment.entity(entity_id)
);

CREATE TABLE payment.payment_gateway (
	paga_entity_id INTEGER PRIMARY KEY,
	paga_code VARCHAR(10) UNIQUE,
	paga_name VARCHAR(55) UNIQUE,
	paga_modified_date TIMESTAMP,
	FOREIGN KEY (paga_entity_id) REFERENCES payment.entity(entity_id)
);

CREATE TABLE payment.users (
	user_id SERIAL PRIMARY KEY
);

CREATE TABLE payment.user_accounts (
	usac_entity_id INTEGER,
	usac_user_id INTEGER,
	usac_account_number VARCHAR(25) UNIQUE,
	usac_saldo INTEGER,
	usac_type VARCHAR(15) CHECK (usac_type IN ('debet', 'credit card', 'payment')),
	usac_expmonth SMALLINT,
	usac_expyear SMALLINT,
	usac_modified_date TIMESTAMP,
	FOREIGN KEY (usac_entity_id) REFERENCES payment.entity(entity_id),
	FOREIGN KEY (usac_user_id) REFERENCES payment.users(user_id),
	PRIMARY KEY (usac_entity_id, usac_user_id)
);

drop table payment.payment_transaction

CREATE TABLE payment.payment_transaction (
	patr_id SERIAL PRIMARY KEY,
	patr_trx_number VARCHAR(55) UNIQUE,
	patr_debet INTEGER,
	patr_credit INTEGER,
	patr_type CHAR(3) CHECK (patr_type IN ('TP', 'TRB', 'RPY', 'RF', 'ORM')),
	patr_note VARCHAR(255),
	patr_modified_date TIMESTAMP,
	patr_order_number VARCHAR(55),
	patr_source_id INTEGER unique,
	patr_target_id INTEGER unique,
	patr_trx_number_ref VARCHAR(55) UNIQUE,
	patr_user_id INTEGER,
	CONSTRAINT pattern_check CHECK (patr_trx_number ~ '^TRB#\d{8}-\d{4}$'),
	FOREIGN KEY (patr_user_id) REFERENCES payment.users(user_id),
	FOREIGN KEY (patr_source_id) REFERENCES payment.payment_transaction(patr_source_id),
	FOREIGN KEY (patr_target_id) REFERENCES payment.payment_transaction(patr_target_id)
);

CREATE TABLE payment.booking_orders (
	boor_order_number VARCHAR(55)
);

CREATE TABLE payment.order_menus (
	orme_order_number VARCHAR(55)
);

CREATE SEQUENCE seq_patr_trx_number
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1;
CREATE OR REPLACE FUNCTION patr_trx_number() 
    RETURNS VARCHAR AS $$
    DECLARE
        trx_number VARCHAR(55);
    BEGIN
        trx_number := CONCAT('TRB#', to_char(now(), 'YYYYMMDD'), '-', lpad(nextval('seq_patr_trx_number')::TEXT, 4, '0'));
        RETURN trx_number;
    END;
$$ LANGUAGE plpgsql;

ALTER TABLE payment.payment_transaction ALTER COLUMN patr_trx_number SET DEFAULT patr_trx_number();

INSERT INTO payment.entity (entity_id)
VALUES
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
SELECT * FROM payment.entity;

INSERT INTO payment.bank (bank_entity_id, bank_code, bank_name, bank_modified_date)
VALUES
(1, 'BCA', 'Bank Central Asia', '2023-05-22'),
(2, 'BRI', 'Bank Rakyat Indonesia', '2023-05-22'),
(3, 'BNI', 'Bank Negara Indonesia', '2023-05-22'),
(4, 'Mandiri', 'Bank Mandiri', '2023-05-22'),
(5, 'CIMB', 'CIMB Niaga', '2023-05-22'),
(6, 'BTN', 'Bank Tabungan Negara', '2023-05-22'),
(7, 'OCBC', 'OCBC NISP', '2023-05-22'),
(8, 'Maybank', 'Maybank Indonesia', '2023-05-22'),
(9, 'DBS', 'DBS Bank', '2023-05-22'),
(10, 'HSBC', 'HSBC Bank', '2023-05-22');
SELECT * FROM payment.bank;

INSERT INTO payment.payment_gateway (paga_entity_id, paga_code, paga_name, paga_modified_date)
VALUES
(1, 'PGW1', 'Payment Gateway 1', '2023-05-22'),
(2, 'PGW2', 'Payment Gateway 2', '2023-05-22'),
(3, 'PGW3', 'Payment Gateway 3', '2023-05-22'),
(4, 'PGW4', 'Payment Gateway 4', '2023-05-22'),
(5, 'PGW5', 'Payment Gateway 5', '2023-05-22'),
(6, 'PGW6', 'Payment Gateway 6', '2023-05-22'),
(7, 'PGW7', 'Payment Gateway 7', '2023-05-22'),
(8, 'PGW8', 'Payment Gateway 8', '2023-05-22'),
(9, 'PGW9', 'Payment Gateway 9', '2023-05-22'),
(10, 'PGW10', 'Payment Gateway 10', '2023-05-22');
SELECT * FROM payment.payment_gateway;

INSERT INTO payment.users (user_id)
VALUES
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
SELECT * FROM payment.user_accounts;

INSERT INTO payment.user_accounts (usac_entity_id, usac_user_id, usac_account_number, usac_saldo, usac_type, usac_expmonth, usac_expyear, usac_modified_date)
VALUES
(1, 1, '1234567890', 1000, 'debet', 12, 2025, '2023-05-22 10:00:00'),
(2, 2, '9876543210', 5000, 'credit card', 6, 2024, '2023-05-22 11:00:00'),
(3, 1, '5555555555', 2500, 'payment', 8, 2023, '2023-05-22 12:00:00'),
(4, 3, '4444444444', 800, 'debet', 9, 2024, '2023-05-22 13:00:00'),
(5, 2, '1111111111', 1500, 'payment', 5, 2025, '2023-05-22 14:00:00'),
(6, 4, '9999999999', 3000, 'credit card', 11, 2023, '2023-05-22 15:00:00'),
(7, 3, '7777777777', 2000, 'debet', 7, 2024, '2023-05-22 16:00:00'),
(8, 4, '2222222222', 3500, 'credit card', 10, 2025, '2023-05-22 17:00:00'),
(9, 1, '8888888888', 1200, 'payment', 3, 2024, '2023-05-22 18:00:00'),
(10, 2, '6666666666', 4000, 'debet', 2, 2023, '2023-05-22 19:00:00');

drop table payment.payment_transaction

INSERT INTO payment.payment_transaction (patr_id, patr_debet, patr_credit, patr_type, patr_note, patr_modified_date, patr_order_number, patr_source_id, patr_target_id, patr_trx_number_ref, patr_user_id)
VALUES
(1, 100, 0, 'TRB', 'Transfer booking payment', '2023-05-22 10:00:00', 'ORDER123', 1, 2, 'REF123', 1),
(2, 50, 0, 'TRB', 'Transfer booking payment', '2023-05-22 11:00:00', 'ORDER456', 3, 4, 'REF456', 2),
(3, 0, 200, 'TP', 'Top-up payment', '2023-05-22 12:00:00', NULL, NULL, 5, 'REF789', 1),
(4, 0, 75, 'RF', 'Refund payment', '2023-05-22 13:00:00', 'ORDER789', 6, 7, 'REF987', 3),
(5, 0, 50, 'RPY', 'Repayment payment', '2023-05-22 14:00:00', NULL, 8, 9, 'REF654', 2),
(6, 120, 0, 'ORM', 'Order menu payment', '2023-05-22 15:00:00', 'ORDER101', 10, 11, 'REF101', 4),
(7, 0, 150, 'TP', 'Top-up payment', '2023-05-22 16:00:00', NULL, NULL, 12, 'REF111', 1),
(8, 80, 0, 'TRB', 'Transfer booking payment', '2023-05-22 17:00:00', 'ORDER222', 13, 14, 'REF222', 2),
(9, 30, 100, 'RPY', 'Repayment payment', '2023-05-22 18:00:00', NULL, 15, 16, 'REF333', 3),
(10, 100, 200, 'RF', 'Refund payment', '2023-05-22 19:00:00', 'ORDER333', 17, 18, 'REF444', 4);
SELECT * FROM payment.payment_transaction;


INSERT INTO payment.booking_orders (boor_order_number)
VALUES
('ORDER123'),
('ORDER456'),
('ORDER789'),
('ORDER101'),
('ORDER222'),
('ORDER333'),
('ORDER444'),
('ORDER555'),
('ORDER666'),
('ORDER777');
SELECT * FROM payment.booking_orders;

INSERT INTO payment.order_menus (orme_order_number)
VALUES
('ORDER123'),
('ORDER456'),
('ORDER789'),
('ORDER101'),
('ORDER222'),
('ORDER333'),
('ORDER444'),
('ORDER555'),
('ORDER666'),
('ORDER777');
SELECT * FROM payment.order_menus;