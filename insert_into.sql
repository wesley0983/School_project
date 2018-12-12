--------------------------------------------------------
--  測試會員表格<<正翰要注意
--------------------------------------------------------
Insert into MEMBERLIST (MEM_NO) values ('M001');
Insert into MEMBERLIST (MEM_NO) values ('M002');
Insert into MEMBERLIST (MEM_NO) values ('M003');
Insert into MEMBERLIST (MEM_NO) values ('M004');

------------------22------------------------------------
--  for Table PRODUCTCLASS 商品類別
--------------------------------------------------------
Insert into PRODUCTCLASS (PRO_CLASSID,PRO_CLASSNAME) values ('PT'||LPAD(to_char(PRODUCTCLASS_SEQ.NEXTVAL), 3, '0'),'CLOTHING');
Insert into PRODUCTCLASS (PRO_CLASSID,PRO_CLASSNAME) values ('PT'||LPAD(to_char(PRODUCTCLASS_SEQ.NEXTVAL), 3, '0'),'SHOES');

------------------27------------------------------------
--  for Table PROMOTION 促銷專案
--------------------------------------------------------
Insert into PROMOTION (PROM_PROJECT_ID,
PROM_PROJECT_NAME,
PROM_PROJECT_SDATE,
PROM_PROJECT_EDATE) values 
    ('PR'||LPAD(to_char(PROMOTION_SEQ.NEXTVAL), 3, '0'),
    '母親節優惠',
    to_timestamp('2019-05-2','YYYY-MM-DD'),
    to_timestamp('2019-05-12','YYYY-MM-DD')
);

Insert into PROMOTION (PROM_PROJECT_ID,
PROM_PROJECT_NAME,
PROM_PROJECT_SDATE,
PROM_PROJECT_EDATE) values 
    ('PR'||LPAD(to_char(PROMOTION_SEQ.NEXTVAL), 3, '0'),
    '聖誕節優惠',
    to_timestamp('2019-12-15','YYYY-MM-DD'),
    to_timestamp('2019-12-25','YYYY-MM-DD')
);

----------------23--------------------------------------
--  for Table PRODUCT 商品
--------------------------------------------------------
Insert into PRODUCT (
PRO_NO,
PRO_CLASSID,
PRO_NAME,
PRO_PIC,
PRO_PIC_EXT,
PRO_FORMAT,
PRO_BONUS,
PRO_STOCK,
PRO_SAFESTOCK,
PRO_DETAILS,
PRO_SHELVE,
PRO_ALL_ASSESS,
PRO_ALL_ASSESSMAN
) values (
'P'||LPAD(to_char(PRODUCT_SEQ.NEXTVAL), 3, '0'),
'PT001',
'Nikex',
NULL,
'PIC_EXT',
'9.5',
2000,
20,
5,
'DETAILS..........',
'上架中',
5,
10
);

--------------21----------------------------------------
--  for Table ORD 訂單
--------------------------------------------------------
Insert into ORD (
ORD_NO,
MEM_NO,
ORD_DATE,
ORD_DELDATE,
ORD_STATUS,
ORD_BACKDELDATE,
ORD_AMOUNT,
ORD_BACKAMOUNT
) values (
to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ORD_SEQ.NEXTVAL),6, '0'),
'M001',
CURRENT_TIMESTAMP,
CURRENT_TIMESTAMP,
'待出貨',
CURRENT_TIMESTAMP,
0000001,
0000001
);


-------------------24-----------------------------------
--  for Table ORDDETAILS 訂單明細
--------------------------------------------------------
Insert into ORDDETAILS(
ORD_NO,
PRO_NO,
ORD_PROBONUNS,
PRO_COUNT    
) values (
to_char(sysdate,'yyyymmdd')||'-000001',
'P001',
3400,
5
);


--------------------28----------------------------------
--  for Table PRO_DETAIL_PROM 商品促銷明細
--------------------------------------------------------
Insert into PRO_DETAIL_PROM(
    PROM_PROJECT_ID,
    PRO_NO,
    PRO_SALE
) values (
    'PR001',
    'P001',
    7000
);


COMMIT;
