USE ����_��
GO

/*
1. �ƻs ��Ʈw�ɮסA���[��Ʈw
2. �ۦ�w�� SSMS
3. �w�� SQL Server CU(Cumulative Update)17  (��ܩʦw��)
https://www.microsoft.com/en-us/download/details.aspx?id=100809

4. 
VS2019�U��
https://docs.microsoft.com/en-us/visualstudio/releases/2019/release-notes

SSAS VS2019
https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftAnalysisServicesModelingProjects

SSIS VS2019
https://marketplace.visualstudio.com/items?itemName=SSIS.SqlServerIntegrationServicesProjects

SSRS VS2019
https://marketplace.visualstudio.com/items?itemName=ProBITools.MicrosoftReportProjectsforVisualStudio

*/

--�s�W�w����ƪ���Ʈw�M�O����
--https://reurl.cc/D34Wvm
EXEC sp_attach_db
'AdventureWorksDW2012','C:\��Ʈw��\AdventureWorksDW2012_Data.mdf',
'C:\��Ʈw��\AdventureWorksDW2012_log.ldf';
EXEC sp_attach_db
'����_��','C:\��Ʈw��\����_��.mdf','C:\��Ʈw��\����_��_log.ldf';

SELECT * FROM sys.databases;

/*
��ʫʸ� �襤��_���ץX���F��dtsx����
cmd �� dtexec /FC:\AA\�F��.dtsx


 �۰ʫʸ� �Ƶ{
 �NSSMS�κ޲z����������A�s�u�� IS
 �s�W��Ƨ��A �פJ�n���檺�ʸ��ɮ� [�קK�ɮײ��ʡA�y���Ƶ{����]

 ���ۦbSQL Server Arent�����@�~ �s�W�@�~ �֦��� [sa]
 �s�W�W�١B�B�J�B���services�ʸ� �פJ�ʸ��ɮ� ���A�����localhost 
 
*/

CREATE DATABASE �m��
ON PRIMARY
(NAME=�m�߸��,FILENAME='C:\�m��\�m�߸��.mdf')
LOG ON
(NAME=�m�߬���,FILENAME='C:\�m��\�m�߬���.ldf')
GO

/*
 �Q�ζפJ�ץX���F,�|�۰ʫت�
 �N ����_�� �Ȥ�M�q��D�ɶץX�� excel�� [�F��.excle]
 �פJ��SQL  �ت��a��excle

 �N ����_�� �Ȥ�M�q��D�� [�F��.excle] �פJ �m�� ��Ʈw��
 �פJ�� excel �ت��a��SQL

 �q����_���ץX ��r�� [�F���q��.txt]
 �A�N��r�� [�F���q��.txt] �פJ�� �m�� ��Ʈw��

 �p�n�A���פJ�ۦP�ɮסA�s����� �ﶵ�� [���w�s�b�ɮ�]
 �i�H��ܧR����ƾ㵧�פJ �� ���[
*/

SELECT * FROM �m��.dbo.�F���q��;
TRUNCATE TABLE �m��.dbo.�F���q��; --�M�Ÿ�ƪ�

/*
https://reurl.cc/V1Ny3Q
�� [�פJ�@���ɮ�] �פJtest��
�]�� [�פJ�ץX���F] �Y��"�����j�AName���O�L�k���Ī����ѡC
*/

/*
�Q��cmd �ץX��Ʈw������r��
bcp/?  �ΥH�d�߻y�k

bcp ����_��.dbo.�Ȥ� out C:\AA\�_���Ȥ�1.txt -T -w -t
-T Window����
-U�b�� -P�K�X SQL����
-t �����j�Ÿ�
*/

--�ץX
SELECT * INTO �m��.dbo.�_���Ȥ� FROM ����_��.dbo.�Ȥ� WHERE 1=0;
SELECT * FROM �m��.dbo.�_���Ȥ�
--bcp �ت��a dbo �ӷ� in ��m
--bcp �m��.dbo.�_���Ȥ� in C:\AA\�_���Ȥ�.txt -T -w -t 

--�פJ
--bcp "SELECT �Ȥ�s��,���q�W��,�s���H,�s���H¾��,�q��,�ǯu�q��,�a�} FROM ����_��.dbo.�Ȥ� WHERE �a�} LIKE '�x�_%'"queryout C:\AA\�_���x�_�Ȥ�.csv -T -t, -w
SELECT �Ȥ�s��,���q�W��,�s���H,�s���H¾��,�q��,�ǯu�q��,�a�} FROM ����_��.dbo.�Ȥ� WHERE �a�} LIKE '�x�_%'


--
SELECT * INTO �m��.dbo.AW�P���� FROM [AdventureWorksDW2012].[dbo].[FactInternetSales] WHERE 1=0;

--�ƥ��{����Ʈw
RESTORE HEADERONLY FROM DISK='C:\��Ʈw��\ContosoRetailDW.bak' --�d�ݥD��Ʈw
RESTORE FILELISTONLY FROM DISK='C:\��Ʈw��\ContosoRetailDW.bak'  --�d�ݸ�Ʈw�����ɮ�

RESTORE DATABASE ContosoRetailDW FROM DISK='C:\��Ʈw��\ContosoRetailDW.bak'
WITH MOVE 'ContosoRetailDW2.0' TO 'C:\��Ʈw��\ContosoRetailDW_Data.mdf'
	,MOVE 'ContosoRetailDW2.0_log' TO 'C:\��Ʈw��\ContosoRetailDW_Log.ldf',RECOVERY;

EXEC sp_helpdb

SELECT COUNT(*) FROM [ContosoRetailDW].[dbo].[FactSales] --�p���Ƶ���
SELECT TOP(1000) * FROM [ContosoRetailDW].[dbo].[FactSales] --�d�ݫe1000�����
--bcp [ContosoRetailDW].[dbo].[FactSales] out C:\AA\Cpntoso_sales.txt -T -t ,-w  
--bcp [ContosoRetailDW].[dbo].[FactSales] out C:\AA\Cpntoso_sales.nn -T -t -n  (-n �������)

SELECT * INTO �m��.dbo.Contoso�P���� FROM [ContosoRetailDW].[dbo].[FactSales] WHERE 1=0;  --�ЫتŪ���ƪ�
--bcp �m��.dbo.Contoso�P���� in c:\AA\Cpntoso_sales.txt -T -t -w -b  (-b �W�[�妸�g�J�q,�u��Φb�פJ)
--bcp �m��.dbo.Contoso�P���� in c:\AA\Cpntoso_sales.nn -T -n -b10000

SELECT TOP(1000) * FROM �m��.dbo.Contoso�P����
TRUNCATE TABLE �m��.dbo.Contoso�P����; --�M�Ÿ�ƪ�

--SQL�y�kBULK INSERT �u��Φb�פJ
BULK INSERT �m��.dbo.Contoso�P���� FROM 'C:\AA\Cpntoso_sales.nn'
WITH (DATAFILETYPE='native',BATCHSIZE=10000);

BULK INSERT �m��.dbo.�_���Ȥ� FROM 'C:\AA\�_���Ȥ�1.txt'
WITH (DATAFILETYPE='widechar');

SELECT * FROM �m��.dbo.�_���Ȥ�;
TRUNCATE TABLE �m��.dbo.�_���Ȥ�;


-- �פJTestData
-- https://reurl.cc/vW0yeA
USE �m��

CREATE TABLE �m�߭��u
(
    ���u�s�� INT,
	�m�W NVARCHAR(10),
	�ͤ� DATE,
	�~�� INT
)

--bcp �m��.dbo.�m�߭��u in C:\AA\TestData.txt -T -t, -w  Ū�@��r �L�kŪ���

BULK INSERT �m��.dbo.�m�߭��u FROM 'c:\AA\TestData.txt'
WITH (DATAFILETYPE='widechar',FIELDTERMINATOR=',');

SELECT * FROM �m��.dbo.�m�߭��u;


--�h���ø�s�����
--bcp "SELECT �Ȥ�s��,���q�W��,�s���H,�s���H¾��,�q��,�ǯu�q��,�a�} FROM ����_��.dbo.�Ȥ�" queryout C:\AA\�_���Ȥ��.csv -T -t, -w
SELECT �Ȥ�s��,���q�W��,�s���H,�s���H¾��,�q��,�ǯu�q��,�a�} INTO �_���Ȥ�� FROM ����_��.dbo.�Ȥ� WHERE 1=0;

TRUNCATE TABLE [dbo].[�_���Ȥ�];
TRUNCATE TABLE [dbo].[�_���Ȥ��];
SELECT * FROM [dbo].[�_���Ȥ�];
SELECT * FROM [dbo].[�_���Ȥ��];

--bcp [�m��].[dbo].[�_���Ȥ��] format nul -T -w -t, -fC:\AA\�_����.fmt --�Ыخ榡��
--���ͮ榡�� nul�i�H����NULL -T�H���s��-w�e�r������ -t, CSV�ɥH,������ -f�榡�ɮ�
--bcp [�m��].[dbo].[�_���Ȥ��] in C:\AA\�_���Ȥ�1.txt -T -fC:\AA\�_����.fmt

BULK INSERT [�m��].[dbo].[�_���Ȥ��] FROM 'C:\AA\�_���Ȥ�1.txt'
WITH(FORMATFILE='C:\AA\�_����.fmt');


--�����ø�s�h���
--bcp "SELECT �Ȥ�s��,���q�W��,�s���H,�s���H¾��,�q��,�ǯu�q��,�a�} FROM ����_��.dbo.�Ȥ�" queryout C:\AA\�_���Ȥ��.csv -T -t, -w
SELECT �Ȥ�s��,���q�W��,�s���H,�s���H¾��,�q��,�ǯu�q��,�a�} INTO �_���Ȥ�� FROM ����_��.dbo.�Ȥ� WHERE 1=0;

TRUNCATE TABLE [dbo].[�_���Ȥ�];
TRUNCATE TABLE [dbo].[�_���Ȥ��];
SELECT * FROM [dbo].[�_���Ȥ�];
SELECT * FROM [dbo].[�_���Ȥ��];

--bcp [�m��].[dbo].[�_���Ȥ��] format nul -T -w -t, -fC:\AA\�_����.fmt --�Ыخ榡��
--���ͮ榡�� nul�i�H����NULL -T�H���s��-w�e�r������ -t, CSV�ɥH,������ -f�榡�ɮ�
--bcp [�m��].[dbo].[�_���Ȥ��] in C:\AA\�_���Ȥ�1.txt -T -fC:\AA\�_����.fmt

BULK INSERT [�m��].[dbo].[�_���Ȥ��] FROM 'C:\AA\�_���Ȥ�1.txt'
WITH(FORMATFILE='C:\AA\�_����.fmt');
