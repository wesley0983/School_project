--------------------------------------------------------
--  建立表格
--------------------------------------------------------
alter session set deferred_segment_creation=false;

DROP TABLE ORD;
DROP TABLE ORDDETAILS;
DROP TABLE PRODUCT;
-- DROP TABLE SHOPPINGCART;
DROP TABLE PRODUCTCLASS;
DROP TABLE PRODUCT_DETAIL_PROMOTION;
DROP TABLE PROMOTION;
DROP TABLE MEM_BER;

DROP SEQUENCE ORD_SEQ;
--------------------------------------------------------
--  測試會員表格
--------------------------------------------------------
CREATE TABLE MEM_BER(
MEM_NO       VARCHAR2(7),
CONSTRAINT MEM_BER_PK PRIMARY KEY (MEM_NO));
--------------------------------------------------------
--  for Table ORD
--------------------------------------------------------
CREATE TABLE ORD (
ORD_NO	        	VARCHAR2(20),
MEM_NO	        	VARCHAR2(7),
ORD_DATE	        TIMESTAMP,	
ORD_DELDATE	        TIMESTAMP,	
ORD_STATUS	        VARCHAR2(10),
ORD_BACKDELDATE	    TIMESTAMP,	
ORD_AMOUNT	        NUMBER(7),
ORD_BACKAMOUNT	    NUMBER(7),
CONSTRAINT ORD_MEM_NO_FK FOREIGN KEY (MEM_NO) REFERENCES MEM_BER (MEM_NO),
CONSTRAINT ORD_PK PRIMARY KEY (ORD_NO));

CREATE SEQUENCE ORD_SEQ 
    INCREMENT BY 1 
    NOMAXVALUE 
    NOCACHE 
    ORDER;

-- Insert into ORD (ORD_NO,MEM_NO,ORD_DATE,ORD_DELDATE,ORD_STATUS,ORD_BACKDELDATE,ORD_AMOUNT,ORD_BACKAMOUNT) values (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000001','1','湯姆貓','0988888888','320','桃園市中壢區福德一路177巷60弄2號',60000,sysdate);

--------------------------------------------------------
--  for Table PRODUCT
--------------------------------------------------------
CREATE TABLE PRODUCT(
PRO_NO		            NUMBER(7),
PRO_CLASSID		        NUMBER(7),
PRO_NAME		        VARCHAR2(100),
PRO_PIC		            VARCHAR2(100),
PRO_FORMAT		        VARCHAR2(100),
PRO_BONUS		        NUMBER(7),
PRO_STOCK		        NUMBER(7),
PRO_SAFESTOCK	        NUMBER(7),
PRO_DETAILS		        VARCHAR2(1500),
PRO_SHELVE		        VARCHAR2(10),
PRO_ALL_ASSESS		    NUMBER(7),
PRO_ALL_ASSESSMAN		NUMBER(7),
--CONSTRAINT PRODUCT_PRO_CLASSID_FK FOREIGN KEY (PRO_CLASSID) REFERENCES PRODUCTCLASS (PRO_CLASSID),
CONSTRAINT PRODUCT_PK PRIMARY KEY (PRO_NO));
--------------------------------------------------------
--  for Table ORDDETAILS
--------------------------------------------------------
CREATE TABLE ORDDETAILS(
ORD_NO		        VARCHAR2(20),
PRO_NO		        VARCHAR2(7),
ORD_PROBONUNS		NUMBER(7),
PRO_COUNT		    NUMBER(7),
--CONSTRAINT ORDDETAILS_ORD_NO_FK1 FOREIGN KEY (ORD_NO) REFERENCES ORD (ORD_NO),
--CONSTRAINT ORDDETAILS_PRO_NO_FK2 FOREIGN KEY (PRO_NO) REFERENCES PRODUCT (PRO_NO),
CONSTRAINT ORDDETAILS_PK PRIMARY KEY (ORD_NO , PRO_NO));


--------------------------------------------------------
--  for Table PRODUCTCLASS
--------------------------------------------------------
CREATE TABLE PRODUCTCLASS(
PRO_CLASSID		    NUMBER(7),
PRO_NO		        NUMBER(7),
PRO_CLASSNAME		VARCHAR2(100),
--CONSTRAINT PRODUCTCLASS_PRO_NO FOREIGN KEY (PRO_NO) REFERENCES PRODUCT (PRO_NO),
CONSTRAINT PRODUCTCLASS_PK PRIMARY KEY (PRO_CLASSID));

--------------------------------------------------------
--  for Table PRODUCT_DETAIL_PROMOTION
--------------------------------------------------------
CREATE TABLE PRODUCT_DETAIL_PROMOTION(
PROM_PROJECT_ID		NUMBER(7),
PRO_NO		        NUMBER(7),
PRO_SALE		    NUMBER(7),
--CONSTRAINT PRODUCT_DETAILPROMOTION_FK1 FOREIGN KEY (PROM_PROJECT_ID) REFERENCES PROMOTION (PROM_PROJECT_ID),
--CONSTRAINT PRODUCT_DETAILPROMOTION_FK2 FOREIGN KEY (PRO_NO) REFERENCES PRODUCT (PRO_NO),
CONSTRAINT PRODUCT_DETAILPROMOTION_PK PRIMARY KEY (PROM_PROJECT_ID , PRO_NO));

--------------------------------------------------------
--  for Table PROD_CATEGORY
--------------------------------------------------------
CREATE TABLE PROMOTION(
PROM_PROJECT_ID		    NUMBER(7),
PROM_PROJECT_NAME		VARCHAR2(100),
PROM_PROJECT_SDATE		TIMESTAMP,	
PROM_PROJECT_EDATE		TIMESTAMP,	
CONSTRAINT PROMOTION_PK PRIMARY KEY (PROM_PROJECT_ID));


COMMIT;


