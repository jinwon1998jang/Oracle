-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-13 09:30:03 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

/*
	날짜: 2025/08/13
	이름: 장진원
	내용: BankProject
 */
 
-- table 생성코드

CREATE TABLE account (
    acc_id            CHAR(14 BYTE) NOT NULL,
    cust_jumin        CHAR(14 BYTE),
    acc_type          VARCHAR2(20 BYTE) NOT NULL,
    acc_balance       NUMBER NOT NULL,
    acc_card          CHAR(1 BYTE) NOT NULL,
    acc_register_date DATE
);

ALTER TABLE account ADD CONSTRAINT account_pk PRIMARY KEY ( acc_id );

CREATE TABLE card (
    card_no            CHAR(14 BYTE) NOT NULL,
    cust_jumin         CHAR(14 BYTE),
    acc_id             CHAR(14 BYTE),
    card_register_date DATE,
    card_limit         NUMBER,
    card_approve_date  DATE,
    card_type          VARCHAR2(10 BYTE) NOT NULL
);

ALTER TABLE card ADD CONSTRAINT card_pk PRIMARY KEY ( card_no );

CREATE TABLE customer (
    cust_jumin CHAR(14 BYTE) NOT NULL,
    name       VARCHAR2(20 BYTE) NOT NULL,
    address    VARCHAR2(100 BYTE) NOT NULL,
    birth      CHAR(10) NOT NULL,
    email      VARCHAR2(100 BYTE) NOT NULL,
    hp         VARCHAR2(20 BYTE) NOT NULL,
    job        VARCHAR2(20 BYTE)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cust_jumin );

ALTER TABLE customer ADD CONSTRAINT customer__un UNIQUE ( email,
                                                          hp );

CREATE TABLE transaction (
    trans_id      NUMBER NOT NULL,
    trans_acc_id  CHAR(14 BYTE) NOT NULL,
    trans_type    CHAR(14 BYTE) NOT NULL,
    trans_message VARCHAR2(20 BYTE),
    trans_money   NUMBER,
    trans_date    DATE NOT NULL
);

ALTER TABLE transaction ADD CONSTRAINT transaction_pk PRIMARY KEY ( trans_id );

ALTER TABLE account
    ADD CONSTRAINT account_customer_fk FOREIGN KEY ( cust_jumin )
        REFERENCES customer ( cust_jumin );

ALTER TABLE card
    ADD CONSTRAINT card_account_fk FOREIGN KEY ( acc_id )
        REFERENCES account ( acc_id );

ALTER TABLE card
    ADD CONSTRAINT card_customer_fk FOREIGN KEY ( cust_jumin )
        REFERENCES customer ( cust_jumin );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_account_fk FOREIGN KEY ( trans_acc_id )
        REFERENCES account ( acc_id );

CREATE SEQUENCE transaction_trans_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER transaction_trans_id_trg BEFORE
    INSERT ON transaction
    FOR EACH ROW
    WHEN ( new.trans_id IS NULL )
BEGIN
    :new.trans_id := transaction_trans_id_seq.nextval;
END;
/

-- 데이터 입력 코드
--CUSTOMER (cust_jumin, name, address, birth, email, hp, job) INSERT
INSERT INTO customer VALUES ('760121-1234567', '정주성', '서울', '1976-01-21', 'jsung@naver.com', '010-1101-7601', '배우');
INSERT INTO customer VALUES ('750611-1234567', '이창재', '서울', '1975-06-11', 'cj@gmail.com', '010-1102-7506', '배우');
INSERT INTO customer VALUES ('890530-1234567', '전지현', '대전', '1989-05-30', 'jjh@naver.com', '010-1103-8905', '자영업');
INSERT INTO customer VALUES ('790413-1234567', '이나영', '대전', '1979-04-13', 'lee@naver.com', '010-2101-7904', '회사원');
INSERT INTO customer VALUES ('660912-1234567', '임진반', '대전', '1966-09-12', 'one@daum.net', '010-2104-6609', '배우');

--ACCOUNT (acc_id, cust_jumin, acc_type, acc_balance, acc_card, acc_register_date) INSERT
INSERT INTO account VALUES ('1011-1001-1001', '760121-1234567', '자유입출금', 4160000, 'Y', TO_DATE('2020-01-21 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO account VALUES ('1011-1001-1002', '890530-1234567', '자유입출금', 376000, 'Y', TO_DATE('2020-06-11 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO account VALUES ('1011-1001-1003', '790413-1234567', '자유입출금', 1200000, 'Y', TO_DATE('2020-05-30 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO account VALUES ('1011-2001-1004', '660912-1234567', '정기적금', 1000000, 'N', TO_DATE('2020-04-13 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO account VALUES ('1011-1002-1005', '750611-1234567', '자유입출금', 820000, 'Y', TO_DATE('2020-09-12 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));

--CARD (card_no, cust_jumin, acc_id, card_register_date, card_limit, card_approve_date, card_type) INSERT
INSERT INTO card VALUES ('2111-1001-1001', '760121-1234567', '1011-1001-1001', TO_DATE('2020-01-21', 'YYYY-MM-DD'), 1000000, TO_DATE('2020-02-10', 'YYYY-MM-DD'), 'check');
INSERT INTO card VALUES ('2041-1001-1002', '890530-1234567', '1011-1001-1002', TO_DATE('2020-06-11', 'YYYY-MM-DD'), 3000000, TO_DATE('2020-06-15', 'YYYY-MM-DD'), 'check');
INSERT INTO card VALUES ('2011-1001-1003', '790413-1234567', '1011-1001-1003', TO_DATE('2020-05-30', 'YYYY-MM-DD'), 5000000, TO_DATE('2020-06-25', 'YYYY-MM-DD'), 'check');
INSERT INTO card VALUES ('2611-1001-1005', '750611-1234567', '1011-1002-1005', TO_DATE('2020-09-12', 'YYYY-MM-DD'), 1500000, TO_DATE('2020-10-10', 'YYYY-MM-DD'), 'check');

--TRANSACTION (trans_acc_id, trans_type, trans_message, trans_money, trans_date) (trans_id)는 자동 증분 SEQUENCE
INSERT INTO transaction (trans_acc_id, trans_type, trans_message, trans_money, trans_date) VALUES ('1011-1001-1001', '입금', '2월 정기급여', 3500000, TO_DATE('2020-02-10 12:36:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO transaction (trans_acc_id, trans_type, trans_message, trans_money, trans_date) VALUES ('1011-1001-1003', '출금', 'ATM 출금', 300000, TO_DATE('2020-02-10 12:37:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO transaction (trans_acc_id, trans_type, trans_message, trans_money, trans_date) VALUES ('1011-1001-1002', '출금', '2월 급여', 2800000, TO_DATE('2020-02-10 12:38:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO transaction (trans_acc_id, trans_type, trans_message, trans_money, trans_date) VALUES ('1011-1001-1001', '출금', '2월 공과금', 116200, TO_DATE('2020-02-10 12:39:21', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO transaction (trans_acc_id, trans_type, trans_message, trans_money, trans_date) VALUES ('1011-1002-1005', '출금', 'ATM 출금', 50000, TO_DATE('2020-02-10 12:40:21', 'YYYY-MM-DD HH24:MI:SS'));

-- 작업3. SQL 실행
-- 1) 모든 고객 정보를 조회하시오.
SELECT * FROM customer;

-- 2) 모든 카드 정보를 조회하시오.
SELECT * FROM card;

-- 3) 모든 예금계좌 정보를 조회하시오.
SELECT * FROM account;

-- 4) 가장 최근 거래 내역 3건 조회하시오.
SELECT *
FROM transaction
ORDER BY trans_date DESC
FETCH FIRST 3 ROWS ONLY;

--또는
SELECT *
FROM (
    SELECT *
    FROM transaction
    ORDER BY trans_date DESC
)
WHERE ROWNUM <= 3;

-- 5) 카드 한도금액이 200만원 이상인 고객의 이름과 카드 종류 조회하시오.
SELECT
    c.name,
    t.card_type
FROM customer c
JOIN card t ON c.cust_jumin = t.cust_jumin
WHERE t.card_limit >= 2000000;

-- 6) 예금계좌별 거래 건수 조회하시오.
SELECT
    trans_acc_id,
    COUNT(*) AS transaction_count
FROM transaction
GROUP BY trans_acc_id;

-- 7) 거래금액이 100만원 이상인 거래 내역 조회하시오.(최근 거래순)
SELECT *
FROM transaction
WHERE trans_money >= 1000000
ORDER BY trans_date DESC;

-- 8) 계좌와 연결된 카드 정보 조회(계좌ID, 카드ID, 카드종류) 하시오.
SELECT
    a.acc_id,
    c.card_no,
    c.card_type
FROM account a
JOIN card c ON a.acc_id = c.acc_id;

-- 9) 예금구분이 '입금'인 거래의 총합 조회하시오.
SELECT SUM(trans_money) AS total_deposit
FROM transaction
WHERE trans_type = '입금';

-- 10) 예금잔고가 4,000,000원 이상인 고객에 대한 고객명, 주민번호, 전화번호, 주소를 조회하시오.
SELECT
    c.name,
    c.cust_jumin,
    c.hp,
    c.address
FROM customer c
JOIN account a ON c.cust_jumin = a.cust_jumin
WHERE a.acc_balance >= 4000000;