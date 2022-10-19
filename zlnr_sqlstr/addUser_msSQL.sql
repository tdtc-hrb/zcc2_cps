use pubs
exec sp_addlogin @loginame='xb',@passwd='xb'
exec sp_adduser 'xb'
--exec sp_addsrvrolemember @loginame='xb',@rolename='sysadmin'
--exec sp_grantdbaccess @loginame='xb',@name_in_db='xb'
--exec sp_addrolemember @rolename='db_owner',@membername='xb'
grant select,insert,update,delete on jobs to xb