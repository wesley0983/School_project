
----------------JDBC模板
----------------*注意在JAVA傳遞SQL語法時。語句最後面不能用;
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "test";
	private static final String PASSWORD = "123456";
	//新增
	private static final String INSERT = "";
	//修改
	private static final String UPDATE = "";
	//刪除
	private static final String DELETE = "";
	//單筆查詢
	private static final String SELECT_FINDBYPK = "";
	//全部查詢
	private static final String SELECT_ALL = "";
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

----
		int count = 0;
		return count;

----
        Connection con = null; 
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
       
----沒有rs
finally { 
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

----有rs
ResultSet rs = null;
--
finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
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
    'P'||LPAD(to_char(PRODUCT_SEQ.NEXTVAL), 3, '0'),
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
update PROMOTION SET  PROM_PROJECT_NAME = ? ,PROM_PROJECT_SDATE = ? ,PROM_PROJECT_EDATE = ? WHERE PROM_PROJECT_ID = ?

update PROMOTION SET  
    PROM_PROJECT_NAME = ? ,
    PROM_PROJECT_SDATE = ? ,
    PROM_PROJECT_EDATE = ? 
WHERE PROM_PROJECT_ID = ?


--delete
Delete FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?
Delete FROM PROMOTION WHERE PROM_PROJECT_ID = ?

--SELECT
SELECT * FROM PROMOTION WHERE PROM_PROJECT_ID = *


--------------21----------------------------------------
--  for Table ORD 訂單
--------------------------------------------------------

--insert
Insert into ORD (ORD_NO,MEM_NO,ORD_DATE,ORD_DELDATE,ORD_STATUS,ORD_BACKDELDATE,ORD_AMOUNT,ORD_BACKAMOUNT) values (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ORD_SEQ.NEXTVAL),6, '0'),'M001',CURRENT_TIMESTAMP,?,?,?,?,?);


--updata
--******test********----
-- UPDATE ORD SET 
-- ORD_DELDATE = CURRENT_TIMESTAMP,
-- ORD_STATUS = '退貨',
-- ORD_BACKDELDATE = CURRENT_TIMESTAMP,
-- ORD_AMOUNT = 2000,
-- ORD_BACKAMOUNT = 2000
--  WHERE ORD_NO = '20181212-000001' ;
--******test********----

UPDATE ORD SET 
-- MEM_NO,會員編號不改
-- ORD_DATE,下單日期不改
ORD_DELDATE = ?,
ORD_STATUS = ?,
ORD_BACKDELDATE = ?,
ORD_AMOUNT = ?,
ORD_BACKAMOUNT =? 
 WHERE ORD_NO = ? ;

 UPDATE ORD SET  ORD_DELDATE = ?, ORD_STATUS = ?, ORD_BACKDELDATE = ?, ORD_AMOUNT = ?, ORD_BACKAMOUNT =?   WHERE ORD_NO = ? 

--------------------28----------------------------------
--  for Table PRO_DETAIL_PROM 商品促銷明細
--------------------------------------------------------

--insert
Insert into PRO_DETAIL_PROM(PROM_PROJECT_ID,PRO_NO,PRO_SALE) values ('PR003','P002',1000)

--updata
UPDATE PRO_DETAIL_PROM SET PROM_PROJECT_ID = ? ,PRO_NO = ? ,PRO_SALE = ? WHERE PROM_PROJECT_ID = ?

--delete


--Select
Select * From PRO_DETAIL_PROM where PROM_PROJECT_ID = ?


