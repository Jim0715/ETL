USE 中文北風
GO

/*
1. 複製 資料庫檔案，附加資料庫
2. 自行安裝 SSMS
3. 安裝 SQL Server CU(Cumulative Update)17  (選擇性安裝)
https://www.microsoft.com/en-us/download/details.aspx?id=100809

4. 
VS2019下載
https://docs.microsoft.com/en-us/visualstudio/releases/2019/release-notes

SSAS VS2019
https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftAnalysisServicesModelingProjects

SSIS VS2019
https://marketplace.visualstudio.com/items?itemName=SSIS.SqlServerIntegrationServicesProjects

SSRS VS2019
https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio

*/

--新增已有資料的資料庫和記錄檔
--https://reurl.cc/D34Wvm
EXEC sp_attach_db
'AdventureWorksDW2012','C:\資料庫檔\AdventureWorksDW2012_Data.mdf',
'C:\資料庫檔\AdventureWorksDW2012_log.ldf';
EXEC sp_attach_db
'中文北風','C:\資料庫檔\中文北風.mdf','C:\資料庫檔\中文北風_log.ldf';

SELECT * FROM sys.databases;

/*
手動封裝 對中文北風匯出精靈的dtsx執行
cmd → dtexec /FC:\AA\東風.dtsx


 自動封裝 排程
 將SSMS用管理員身分執行，連線至 IS
 新增資料夾， 匯入要執行的封裝檔案 [避免檔案移動，造成排程失效]

 接著在SQL Server Arent中的作業 新增作業 擁有者 [sa]
 新增名稱、步驟、選取services封裝 匯入封裝檔案 伺服器選擇localhost 
 
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

 如要再次匯入相同檔案，編輯對應 選項中 [須已存在檔案]
 可以選擇刪除資料整筆匯入 或 附加
*/

SELECT * FROM 練習.dbo.東風訂單;
TRUNCATE TABLE 練習.dbo.東風訂單; --清空資料表

/*
https://reurl.cc/V1Ny3Q
用 [匯入一般檔案] 匯入test檔
因用 [匯入匯出精靈] 即用"做分隔，Name欄位是無法有效的辨識。
*/

/*
利用cmd 匯出資料庫中的文字檔
bcp/?  用以查詢語法

bcp 中文北風.dbo.客戶 out C:\AA\北風客戶1.txt -T -w -t
-T Window驗證
-U帳號 -P密碼 SQL驗證
-t 欄位分隔符號
*/

--匯出
SELECT * INTO 練習.dbo.北風客戶 FROM 中文北風.dbo.客戶 WHERE 1=0;
SELECT * FROM 練習.dbo.北風客戶
--bcp 目的地 dbo 來源 in 位置
--bcp 練習.dbo.北風客戶 in C:\AA\北風客戶.txt -T -w -t 

--匯入
--bcp "SELECT 客戶編號,公司名稱,連絡人,連絡人職稱,電話,傳真電話,地址 FROM 中文北風.dbo.客戶 WHERE 地址 LIKE '台北%'"queryout C:\AA\北風台北客戶.csv -T -t, -w
SELECT 客戶編號,公司名稱,連絡人,連絡人職稱,電話,傳真電話,地址 FROM 中文北風.dbo.客戶 WHERE 地址 LIKE '台北%'


--
SELECT * INTO 練習.dbo.AW銷售資料 FROM [AdventureWorksDW2012].[dbo].[FactInternetSales] WHERE 1=0;

--備份現有資料庫
RESTORE HEADERONLY FROM DISK='C:\資料庫檔\ContosoRetailDW.bak' --查看主資料庫
RESTORE FILELISTONLY FROM DISK='C:\資料庫檔\ContosoRetailDW.bak'  --查看資料庫中的檔案

RESTORE DATABASE ContosoRetailDW FROM DISK='C:\資料庫檔\ContosoRetailDW.bak'
WITH MOVE 'ContosoRetailDW2.0' TO 'C:\資料庫檔\ContosoRetailDW_Data.mdf'
	,MOVE 'ContosoRetailDW2.0_log' TO 'C:\資料庫檔\ContosoRetailDW_Log.ldf',RECOVERY;

EXEC sp_helpdb

SELECT COUNT(*) FROM [ContosoRetailDW].[dbo].[FactSales] --計算資料筆數
SELECT TOP(1000) * FROM [ContosoRetailDW].[dbo].[FactSales] --查看前1000筆資料
--bcp [ContosoRetailDW].[dbo].[FactSales] out C:\AA\Cpntoso_sales.txt -T -t ,-w  
--bcp [ContosoRetailDW].[dbo].[FactSales] out C:\AA\Cpntoso_sales.nn -T -t -n  (-n 原生類型)

SELECT * INTO 練習.dbo.Contoso銷售資料 FROM [ContosoRetailDW].[dbo].[FactSales] WHERE 1=0;  --創建空的資料表
--bcp 練習.dbo.Contoso銷售資料 in c:\AA\Cpntoso_sales.txt -T -t -w -b  (-b 增加批次寫入量,只能用在匯入)
--bcp 練習.dbo.Contoso銷售資料 in c:\AA\Cpntoso_sales.nn -T -n -b10000

SELECT TOP(1000) * FROM 練習.dbo.Contoso銷售資料
TRUNCATE TABLE 練習.dbo.Contoso銷售資料; --清空資料表

--SQL語法BULK INSERT 只能用在匯入
BULK INSERT 練習.dbo.Contoso銷售資料 FROM 'C:\AA\Cpntoso_sales.nn'
WITH (DATAFILETYPE='native',BATCHSIZE=10000);

BULK INSERT 練習.dbo.北風客戶 FROM 'C:\AA\北風客戶1.txt'
WITH (DATAFILETYPE='widechar');

SELECT * FROM 練習.dbo.北風客戶;
TRUNCATE TABLE 練習.dbo.北風客戶;


-- 匯入TestData
-- https://reurl.cc/vW0yeA
USE 練習

CREATE TABLE 練習員工
(
    員工編號 INT,
	姓名 NVARCHAR(10),
	生日 DATE,
	薪資 INT
)

--bcp 練習.dbo.練習員工 in C:\AA\TestData.txt -T -t, -w  讀一串字 無法讀日期

BULK INSERT 練習.dbo.練習員工 FROM 'c:\AA\TestData.txt'
WITH (DATAFILETYPE='widechar',FIELDTERMINATOR=',');

SELECT * FROM 練習.dbo.練習員工;


--多欄位繪製少欄位
--bcp "SELECT 客戶編號,公司名稱,連絡人,連絡人職稱,電話,傳真電話,地址 FROM 中文北風.dbo.客戶" queryout C:\AA\北風客戶少.csv -T -t, -w
SELECT 客戶編號,公司名稱,連絡人,連絡人職稱,電話,傳真電話,地址 INTO 北風客戶少 FROM 中文北風.dbo.客戶 WHERE 1=0;

TRUNCATE TABLE [dbo].[北風客戶];
TRUNCATE TABLE [dbo].[北風客戶少];
SELECT * FROM [dbo].[北風客戶];
SELECT * FROM [dbo].[北風客戶少];

--bcp [練習].[dbo].[北風客戶少] format nul -T -w -t, -fC:\AA\北風少.fmt --創建格式檔
--產生格式檔 nul可以接受NULL -T信任連結-w寬字元類型 -t, CSV檔以,做分格 -f格式檔案
--bcp [練習].[dbo].[北風客戶少] in C:\AA\北風客戶1.txt -T -fC:\AA\北風少.fmt

BULK INSERT [練習].[dbo].[北風客戶少] FROM 'C:\AA\北風客戶1.txt'
WITH(FORMATFILE='C:\AA\北風少.fmt');


--少欄位繪製多欄位
--bcp "SELECT 客戶編號,公司名稱,連絡人,連絡人職稱,電話,傳真電話,地址 FROM 中文北風.dbo.客戶" queryout C:\AA\北風客戶少.csv -T -t, -w
SELECT 客戶編號,公司名稱,連絡人,連絡人職稱,電話,傳真電話,地址 INTO 北風客戶少 FROM 中文北風.dbo.客戶 WHERE 1=0;

TRUNCATE TABLE [dbo].[北風客戶];
TRUNCATE TABLE [dbo].[北風客戶少];
SELECT * FROM [dbo].[北風客戶];
SELECT * FROM [dbo].[北風客戶少];

--bcp [練習].[dbo].[北風客戶少] format nul -T -w -t, -fC:\AA\北風少.fmt --創建格式檔
--產生格式檔 nul可以接受NULL -T信任連結-w寬字元類型 -t, CSV檔以,做分格 -f格式檔案
--bcp [練習].[dbo].[北風客戶少] in C:\AA\北風客戶1.txt -T -fC:\AA\北風少.fmt

BULK INSERT [練習].[dbo].[北風客戶少] FROM 'C:\AA\北風客戶1.txt'
WITH(FORMATFILE='C:\AA\北風少.fmt');
