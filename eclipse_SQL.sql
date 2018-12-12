
----------------JDBC模板
        Connection con = null; 
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}




----------------23--------------------------------------
--  for Table PRODUCT 商品  eclipse上需注意;號與,號
--------------------------------------------------------
--update
UPDATE PRODUCT SET 
    PRO_CLASSID = ?,
    PRO_NAME = ?,
    PRO_PIC = ?,
    PRO_PIC_EXT = ?,
    PRO_FORMAT = ?,
    PRO_BONUS = ?,
    PRO_STOCK = ?,
    PRO_SAFESTOCK = ?,
    PRO_DETAILS = ?,
    PRO_SHELVE = ?,
    PRO_ALL_ASSESS = ?,
    PRO_ALL_ASSESSMAN = ?
where PRO_NO = ?

UPDATE PRODUCT SET  PRO_CLASSID = ?, PRO_NAME = ?, PRO_PIC = ?, PRO_PIC_EXT = ?, PRO_FORMAT = ?, PRO_BONUS = ?, PRO_STOCK = ?, PRO_SAFESTOCK = ?, PRO_DETAILS = ?, PRO_SHELVE = ?, PRO_ALL_ASSESS = ?, PRO_ALL_ASSESSMAN = ? where PRO_NO = ?

--insert

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
    'PR'||LPAD(to_char(PRODUCT_SEQ.NEXTVAL), 3, '0'),
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?,
    ?
)

Insert into PRODUCT (PRO_NO,PRO_CLASSID,PRO_NAME,PRO_PIC,PRO_PIC_EXT,PRO_FORMAT,PRO_BONUS,PRO_STOCK,PRO_SAFESTOCK,PRO_DETAILS,PRO_SHELVE,PRO_ALL_ASSESS,PRO_ALL_ASSESSMAN) values ('PR'||LPAD(to_char(PRODUCT_SEQ.NEXTVAL), 3, '0'),?,?,?,?,?,?,?,?,?,?,?,?)

--Delete
--因為商品表格有兩個子表格  以下指令為(一個商品有訂單 & 商品促銷明細雙重關係)
Delete FROM ORDDETAILS WHERE ORD_NO = ?
Delete FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?
Delete FROM PRODUCT WHERE PRO_NO = ?


------------------22------------------------------------
--  for Table PRODUCTCLASS 商品類別
--------------------------------------------------------

--insert
Insert into PRODUCTCLASS(PRO_CLASSID,PRO_CLASSNAME) values (?,?)


--updata
UPDATE PRODUCTCLASS SET PRO_CLASSNAME = ? WHERE PRO_CLASSID = ?


--Delete
Delete FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?
Delete FROM ORDDETAILS WHERE ORD_NO = ?
Delete From PRODUCT where PRO_NO = ?
Delete FROM PRODUCTCLASS WHERE PRO_CLASSID = ?


--SELETE 
SELECT * FROM PRODUCTCLASS WHERE PRO_CLASSID = ?


------------------27------------------------------------
--  for Table PROMOTION 促銷專案
--------------------------------------------------------

--insert  日期直接用? 就好不然會出錯
Insert into PROMOTION (PROM_PROJECT_ID,PROM_PROJECT_NAME,PROM_PROJECT_SDATE,PROM_PROJECT_EDATE) values ('PR'||LPAD(to_char(PROMOTION_SEQ.NEXTVAL), 3, '0'),?,?,?)


--updata
update PROMOTION SET 
 PROM_PROJECT_NAME = ? , 
 PROM_PROJECT_SDATE = ? ,
 PROM_PROJECT_EDATE = ? 
WHERE PROM_PROJECT_ID = ?

--test
update PROMOTION SET PROM_PROJECT_NAME = '中元節'  WHERE PROM_PROJECT_ID = 'PR001';

update PROMOTION SET 
PROM_PROJECT_NAME = '中元節',
PROM_PROJECT_SDATE = '2019-01-21', 
PROM_PROJECT_EDATE = '2019-02-05'
WHERE PROM_PROJECT_ID = 'PR001'
--

