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