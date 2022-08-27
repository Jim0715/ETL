--新增已有資料的資料庫和記錄檔
EXEC sp_attach_db
'AdventureWorksDW2012','C:\資料庫檔\AdventureWorksDW2012_Data.mdf',
'C:\資料庫檔\AdventureWorksDW2012_log.ldf';
EXEC sp_attach_db
'中文北風','C:\資料庫檔\中文北風.mdf','C:\資料庫檔\中文北風_log.ldf';

SELECT * FROM sys.databases;

/*
手動封裝 對中文北風匯出精靈的dtsx執行
dtexec /FC:\AA\東風.dtsx
*/

CREATE DATABASE 練習
ON PRIMARY
(NAME=練習資料,FILENAME='C:\練習\練習資料.mdf')
LOG ON
(NAME=練習紀錄,FILENAME='C:\練習\練習紀錄.ldf')
GO

/*
 利用匯入匯出精靈,會自動建表
 將 中文北風 客戶和訂單主檔匯出成 excel檔 [東風.excle]
 匯入選SQL  目的地選excle

 將 中文北風 客戶和訂單主檔 [東風.excle] 匯入 練習 資料庫中
 匯入選 excel 目的地選SQL

 從中文北風匯出 文字檔 [東風訂單.txt]
 再將文字檔 [東風訂單.txt] 匯入至 練習 資料庫中

 如要再次匯入相同檔案，編輯對應 選項中
 可以選擇刪除資料整筆匯入 或 附加

 設定封裝排程
 將SSMS用管理員身分執行，連線至 IS
 新增資料夾， 匯入要執行的封裝檔案，避免檔案移動，造成排程失效

 接著在SQL Server Arent中的作業 新增作業 擁有者 [sa]
 新增名稱、步驟、選取services封裝 匯入封裝檔案 伺服器選擇localhost 
 
*/

SELECT * FROM 練習.dbo.東風訂單;
TRUNCATE TABLE 練習.dbo.東風訂單; --清空資料表