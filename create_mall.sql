
--------------------------------------------------------
--  建立表格
--------------------------------------------------------
alter session set deferred_segment_creation=false;


DROP TABLE PRO_DETAIL_PROM;
DROP TABLE PROMOTION;
DROP TABLE SHOPPINGCART;
DROP TABLE ORDDETAILS;
DROP TABLE PRODUCT;
DROP TABLE PRODUCTCLASS;
DROP TABLE ORD;
DROP TABLE MEMBERLIST; --會員(要拿掉)<<正翰要注意

DROP SEQUENCE PROMOTION_SEQ;
DROP SEQUENCE PRODUCT_SEQ;
DROP SEQUENCE PRODUCTCLASS_SEQ;
DROP SEQUENCE ORD_SEQ;

--------------------------------------------------------
--  測試會員表格<<正翰要注意
--------------------------------------------------------
CREATE TABLE MEMBERLIST(
MEM_NO       VARCHAR2(7),
CONSTRAINT MEMBERLIST_PK PRIMARY KEY (MEM_NO));

-- Insert into MEMBERLIST (MEM_NO) values (0000001);
-- Insert into MEMBERLIST (MEM_NO) values (0000002);
-- Insert into MEMBERLIST (MEM_NO) values (0000003);
-- Insert into MEMBERLIST (MEM_NO) values (0000004);

--------------------------------------------------------
--  for Table ORD 訂單
--------------------------------------------------------
CREATE TABLE ORD (
    ORD_NO	        	VARCHAR2(20),
    MEM_NO	        	VARCHAR2(7)      NOT NULL,
    ORD_DATE	        TIMESTAMP        NOT NULL,	
    ORD_DELDATE	        TIMESTAMP,	
    ORD_STATUS	        VARCHAR2(10)     NOT NULL,
    ORD_BACKDELDATE	    TIMESTAMP,	
    ORD_AMOUNT	        NUMBER(7)        NOT NULL,
    ORD_BACKAMOUNT	    NUMBER(7),
    CONSTRAINT FK1_ORD_MEMBERLIST FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO), 
    CONSTRAINT ORD_PK PRIMARY KEY (ORD_NO)
);

CREATE SEQUENCE ORD_SEQ 
    INCREMENT BY 1 
    START WITH 1
    NOMAXVALUE 
    NOCACHE 
    ORDER;
-- INSERT INTO ORD (ORD_NO,MEM_NO,ORD_DATE,ORD_DELDATE,ORD_STATUS,ORD_BACKDELDATE,ORD_AMOUNT,ORD_BACKAMOUNT) values (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 11, '0'),0000001,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0000000001,CURRENT_TIMESTAMP,0000001,0000001)
-- Insert into ORD (ORD_NO,MEM_NO,ORD_DATE,ORD_DELDATE,ORD_STATUS,ORD_BACKDELDATE,ORD_AMOUNT,ORD_BACKAMOUNT) values (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000001','1','湯姆貓','0988888888','320','桃園市中壢區福德一路177巷60弄2號',60000,sysdate);

--------------------------------------------------------
--  for Table PRODUCTCLASS 商品類別
--------------------------------------------------------
CREATE TABLE PRODUCTCLASS(
    PRO_CLASSID		    VARCHAR2(7),
    PRO_CLASSNAME		VARCHAR2(100) NOT NULL,
    CONSTRAINT PRODUCTCLASS_PK PRIMARY KEY (PRO_CLASSID)
);

CREATE SEQUENCE PRODUCTCLASS_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;

--------------------------------------------------------
--  for Table PRODUCT 商品
--------------------------------------------------------
CREATE TABLE PRODUCT(
    PRO_NO		            VARCHAR2(7),
    PRO_CLASSID		        VARCHAR2(7)     NOT NULL,
    PRO_NAME		        VARCHAR2(100)   NOT NULL,
    PRO_PIC		            BLOB,
    PRO_PIC_EXT	        	VARCHAR2(10),
    PRO_FORMAT		        VARCHAR2(100)   NOT NULL,
    PRO_BONUS		        NUMBER(7)       NOT NULL,
    PRO_STOCK		        NUMBER(7)       NOT NULL,
    PRO_SAFESTOCK	        NUMBER(7)       NOT NULL,
    PRO_DETAILS		        VARCHAR2(1500),
    PRO_SHELVE		        VARCHAR2(10)    NOT NULL,
    PRO_ALL_ASSESS		    NUMBER(7),
    PRO_ALL_ASSESSMAN		NUMBER(7),
    -- CONSTRAINT SHOPPINGCART_PRO_NO_FK2 FOREIGN KEY (PRO_NO) REFERENCES PRODUCT (PRO_NO),
    CONSTRAINT FK1_PRODUCT_PRODUCTCLASS FOREIGN KEY (PRO_CLASSID) REFERENCES PRODUCTCLASS (PRO_CLASSID),
    CONSTRAINT PRODUCT_PK PRIMARY KEY (PRO_NO)
);

CREATE SEQUENCE PRODUCT_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE 
    ORDER;

--------------------------------------------------------
--  for Table ORDDETAILS 訂單明細
--------------------------------------------------------
CREATE TABLE ORDDETAILS(
    ORD_NO		        VARCHAR2(20) NOT NULL,
    PRO_NO		        VARCHAR2(7) NOT NULL,
    ORD_PROBONUNS		NUMBER(7) NOT NULL,
    PRO_COUNT		    NUMBER(7) NOT NULL,
    CONSTRAINT FK1_ORDDETAILS_ORD FOREIGN KEY (ORD_NO) REFERENCES ORD (ORD_NO),
    CONSTRAINT FK2_ORDDETAILS_PRO FOREIGN KEY (PRO_NO) REFERENCES PRODUCT (PRO_NO),
    CONSTRAINT ORDDETAILS_PK PRIMARY KEY (ORD_NO , PRO_NO)
);
-- INSERT INTO ORDDETAILS (
-- ORD_NO,
-- PRO_NO,
-- ORD_PROBONUNS,
-- PRO_COUNT) values ()

--------------------------------------------------------
--  for Table SHOPPINGCART 購物車  <<會用Redis
--------------------------------------------------------
CREATE TABLE SHOPPINGCART(
    MEM_NO		    VARCHAR2(7)     NOT NULL,
    PRO_NO		    VARCHAR2(7)     NOT NULL,
    PRO_COUNT		NUMBER(7)       NOT NULL,
    CONSTRAINT FK1_SHOPPINGCART_MEMBERLIST FOREIGN KEY (MEM_NO) REFERENCES MEMBERLIST (MEM_NO),
    CONSTRAINT SHOPPINGCART_PK PRIMARY KEY (MEM_NO , PRO_NO)
);


--------------------------------------------------------
--  for Table PROMOTION 促銷專案
--------------------------------------------------------
CREATE TABLE PROMOTION(
    PROM_PROJECT_ID		    VARCHAR2(7),
    PROM_PROJECT_NAME		VARCHAR2(100)   NOT NULL,
    PROM_PROJECT_SDATE		TIMESTAMP       NOT NULL,	
    PROM_PROJECT_EDATE		TIMESTAMP       NOT NULL,	
    CONSTRAINT PROMOTION_PK PRIMARY KEY (PROM_PROJECT_ID)
);

CREATE SEQUENCE PROMOTION_SEQ 
    INCREMENT BY 1 
    START WITH 1
    MAXVALUE 999
    NOCYCLE
    NOCACHE
    ORDER;

--------------------------------------------------------
--  for Table PRO_DETAIL_PROM 商品促銷明細
--------------------------------------------------------
CREATE TABLE PRO_DETAIL_PROM(
    PROM_PROJECT_ID		VARCHAR2(7)    NOT NULL,
    PRO_NO		        VARCHAR2(7)    NOT NULL,
    PRO_SALE		    NUMBER(7)      NOT NULL,
    CONSTRAINT FK1_PRO_DETAIL_PROM_PRODUCT FOREIGN KEY (PRO_NO) REFERENCES PRODUCT (PRO_NO),
    CONSTRAINT FK2_PRO_DETAIL_PROM_PROMOTION FOREIGN KEY (PROM_PROJECT_ID) REFERENCES PROMOTION (PROM_PROJECT_ID),
    CONSTRAINT PRODUCT_DETAILPROMOTION_PK PRIMARY KEY (PROM_PROJECT_ID , PRO_NO)
);



COMMIT;

