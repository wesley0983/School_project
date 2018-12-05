--------------------------------------------------------
--  建立表格
--------------------------------------------------------
alter session set deferred_segment_creation=false;

DROP TABLE ORD;
DROP TABLE ORDDETAILS;
DROP TABLE PRODUCT;
DROP TABLE SHOPPINGCART;
DROP TABLE PRODUCTCLASS;
DROP TABLE PRODUCT_DETAIL_PROMOTION;
DROP TABLE PROMOTION;


--------------------------------------------------------
--  for Table PROD_CATEGORY
--------------------------------------------------------
CREATE TABLE ORD (
ORD_NO	        	VARCHAR2(20),
MEM_NO	        	NUMBER(7),
ORD_DATE	        TIMESTAMP,	
ORD_DELDATE	        TIMESTAMP,	
ORD_STATUS	        VARCHAR2(10),
ORD_BACKDELDATE	    TIMESTAMP,	
ORD_AMOUNT	        NUMBER(7),
ORD_BACKAMOUNT	    NUMBER(7),
CONSTRAINT ORD_NO_PRIMARY_KEY PRIMARY KEY (ORD_NO));

CREATE SEQUENCE ORD_SEQ 
    INCREMENT BY 1 
    NOMAXVALUE 
    NOCACHE 
    ORDER;

Insert into ORD (ORD_NO,MEM_NO,ORD_DATE,ORD_DELDATE,ORD_STATUS,ORD_BACKDELDATE,ORD_AMOUNT,ORD_BACKAMOUNT) values (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ord_seq.NEXTVAL), 6, '0'),'M000001','1','湯姆貓','0988888888','320','桃園市中壢區福德一路177巷60弄2號',60000,sysdate);
--------------------------------------------------------
)



