--�s�W�w����ƪ���Ʈw�M�O����
EXEC sp_attach_db
'AdventureWorksDW2012','C:\��Ʈw��\AdventureWorksDW2012_Data.mdf',
'C:\��Ʈw��\AdventureWorksDW2012_log.ldf';
EXEC sp_attach_db
'����_��','C:\��Ʈw��\����_��.mdf','C:\��Ʈw��\����_��_log.ldf';

SELECT * FROM sys.databases;

/*
��ʫʸ� �襤��_���ץX���F��dtsx����
dtexec /FC:\AA\�F��.dtsx
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

 �p�n�A���פJ�ۦP�ɮסA�s����� �ﶵ��
 �i�H��ܧR����ƾ㵧�פJ �� ���[

 �]�w�ʸ˱Ƶ{
 �NSSMS�κ޲z����������A�s�u�� IS
 �s�W��Ƨ��A �פJ�n���檺�ʸ��ɮסA�קK�ɮײ��ʡA�y���Ƶ{����

 ���ۦbSQL Server Arent�����@�~ �s�W�@�~ �֦��� [sa]
 �s�W�W�١B�B�J�B���services�ʸ� �פJ�ʸ��ɮ� ���A�����localhost 
 
*/

SELECT * FROM �m��.dbo.�F���q��;
TRUNCATE TABLE �m��.dbo.�F���q��; --�M�Ÿ�ƪ�