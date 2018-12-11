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





