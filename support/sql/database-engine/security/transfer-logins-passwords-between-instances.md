---
title: Transfer logins and passwords between instances
description: This article describes how to transfer the logins and the passwords between different instances of SQL Server running on Windows.
ms.date: 10/16/2023
ms.custom: sap:Security Issues
ms.reviewer: bartd
ms.topic: how-to
---

# Transfer logins and passwords between instances of SQL Server

 This article describes how to transfer the logins and the passwords between different instances of SQL Server running on Windows.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 918992, 246133

## Introduction

This article describes how to transfer the logins and passwords between different instances of Microsoft SQL Server.

> [!NOTE]
> The instances might be on the same server or on different servers, and their versions might differ.

## More information

In this article, server A and server B are different servers.

After you move a database from the instance of SQL Server on server A to the instance of SQL Server on server B, users might be unable to log in to the database on server B. Additionally, users might receive the following error message:

> Login failed for user '**MyUser**'. (Microsoft SQL Server, Error: 18456)

This problem occurs because you didn't transfer the logins and the passwords from the instance of SQL Server on server A to the instance of SQL Server on server B.

> [!NOTE]
> The 18456-error message also occurs due to other reasons. For additional information on these causes and potential resolutions, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

To transfer the logins, use one of the following methods, as appropriate for your situation.

- Method 1: Reset the password on the destination SQL Server computer (Server B).

  To resolve this issue, reset the password in SQL Server computer, and then script out the login.

  > [!NOTE]
  > The password hashing algorithm is used when you reset the password.

- Method 2: Transfer logins and passwords to destination server (Server B) using scripts generated on source server (Server A).

  1. Create stored procedures that will help generate necessary scripts to transfer logins and their passwords. To do so, connect to Server A using SQL Server Management Studio (SSMS) or any other client tool and run the following script:

      ```sql
        USE [master]
        GO
        IF OBJECT_ID ('sp_hexadecimal') IS NOT NULL
        DROP PROCEDURE sp_hexadecimal
        GO
        CREATE PROCEDURE [dbo].[sp_hexadecimal]
        (
            @binvalue varbinary(256),
            @hexvalue varchar (514) OUTPUT
        )
        AS
        BEGIN
            DECLARE @charvalue varchar (514)
            DECLARE @i int
            DECLARE @length int
            DECLARE @hexstring char(16)
            SELECT @charvalue = '0x'
            SELECT @i = 1
            SELECT @length = DATALENGTH (@binvalue)
            SELECT @hexstring = '0123456789ABCDEF'
        
            WHILE (@i <= @length)
            BEGIN
                  DECLARE @tempint int
                  DECLARE @firstint int
                  DECLARE @secondint int
        
                  SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
                  SELECT @firstint = FLOOR(@tempint/16)
                  SELECT @secondint = @tempint - (@firstint*16)
                  SELECT @charvalue = @charvalue + SUBSTRING(@hexstring, @firstint+1, 1) + SUBSTRING(@hexstring, @secondint+1, 1)
        
                  SELECT @i = @i + 1
            END 
            SELECT @hexvalue = @charvalue
        END
        go
        IF OBJECT_ID ('sp_help_revlogin') IS NOT NULL
        DROP PROCEDURE sp_help_revlogin
        GO
        CREATE PROCEDURE [dbo].[sp_help_revlogin]   
        (
            @login_name sysname = NULL 
        )
        AS
        BEGIN
            DECLARE @name                     SYSNAME
            DECLARE @type                     VARCHAR (1)
            DECLARE @hasaccess                INT
            DECLARE @denylogin                INT
            DECLARE @is_disabled              INT
            DECLARE @PWD_varbinary            VARBINARY (256)
            DECLARE @PWD_string               VARCHAR (514)
            DECLARE @SID_varbinary            VARBINARY (85)
            DECLARE @SID_string               VARCHAR (514)
            DECLARE @tmpstr                   VARCHAR (1024)
            DECLARE @is_policy_checked        VARCHAR (3)
            DECLARE @is_expiration_checked    VARCHAR (3)
            Declare @Prefix                   VARCHAR(255)
            DECLARE @defaultdb                SYSNAME
            DECLARE @defaultlanguage          SYSNAME     
            DECLARE @tmpstrRole               VARCHAR (1024)
         
        IF (@login_name IS NULL)
        BEGIN
            DECLARE login_curs CURSOR 
            FOR 
                SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin, p.default_language_name  
                FROM  sys.server_principals p 
                LEFT JOIN sys.syslogins     l ON ( l.name = p.name ) 
                WHERE p.type IN ( 'S', 'G', 'U' ) 
                AND p.name <> 'sa'
                AND p.name not like '##%'
                ORDER BY p.name
        END
        ELSE
                DECLARE login_curs CURSOR 
                FOR 
                    SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin, p.default_language_name  
                    FROM  sys.server_principals p 
                    LEFT JOIN sys.syslogins        l ON ( l.name = p.name ) 
                    WHERE p.type IN ( 'S', 'G', 'U' ) 
                      AND p.name = @login_name
                    ORDER BY p.name
                
                OPEN login_curs 
                FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin, @defaultlanguage 
                IF (@@fetch_status = -1)
                BEGIN
                      PRINT 'No login(s) found.'
                      CLOSE login_curs
                      DEALLOCATE login_curs
                      RETURN -1
                END
        
                SET @tmpstr = '/* sp_help_revlogin script '
                PRINT @tmpstr
        
                SET @tmpstr = '** Generated ' + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
        
                PRINT @tmpstr
                PRINT ''
        
                WHILE (@@fetch_status <> -1)
                BEGIN
                  IF (@@fetch_status <> -2)
                  BEGIN
                        PRINT ''
        
                        SET @tmpstr = '-- Login: ' + @name
        
                        PRINT @tmpstr
        
                        SET @tmpstr='IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'''+@name+''')
                        BEGIN'
                        Print @tmpstr 
        
                        IF (@type IN ( 'G', 'U'))
                        BEGIN -- NT authenticated account/group 
                          SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH DEFAULT_DATABASE = [' + @defaultdb + ']' + ', DEFAULT_LANGUAGE = [' + @defaultlanguage + ']'
                        END
                        ELSE 
                        BEGIN -- SQL Server authentication
                                -- obtain password and sid
                                SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) )
        
                                EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT
                                EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT
         
                                -- obtain password policy state
                                SELECT @is_policy_checked     = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END 
                                FROM sys.sql_logins 
                                WHERE name = @name
        
                                SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END 
                                FROM sys.sql_logins 
                                WHERE name = @name
         
                                SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string + ' HASHED, SID = ' 
                                                + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']' + ', DEFAULT_LANGUAGE = [' + @defaultlanguage + ']'
                                 
                                IF ( @is_policy_checked IS NOT NULL )
                                BEGIN
                                  SET @tmpstr = @tmpstr + ', CHECK_POLICY = ' + @is_policy_checked
                                END
        
                                IF ( @is_expiration_checked IS NOT NULL )
                                BEGIN
                                  SET @tmpstr = @tmpstr + ', CHECK_EXPIRATION = ' + @is_expiration_checked
                                END
                END
        
                IF (@denylogin = 1)
                BEGIN -- login is denied access
                    SET @tmpstr = @tmpstr + '; DENY CONNECT SQL TO ' + QUOTENAME( @name )
                END
                ELSE IF (@hasaccess = 0)
                BEGIN -- login exists but does not have access
                    SET @tmpstr = @tmpstr + '; REVOKE CONNECT SQL TO ' + QUOTENAME( @name )
                END
                IF (@is_disabled = 1)
                BEGIN -- login is disabled
                    SET @tmpstr = @tmpstr + '; ALTER LOGIN ' + QUOTENAME( @name ) + ' DISABLE'
                END 
        
                SET @Prefix = '
                EXEC master.dbo.sp_addsrvrolemember @loginame='''
        
                SET @tmpstrRole=''
        
                SELECT @tmpstrRole = @tmpstrRole
                    + CASE WHEN sysadmin        = 1 THEN @Prefix + [LoginName] + ''', @rolename=''sysadmin'''        ELSE '' END
                    + CASE WHEN securityadmin   = 1 THEN @Prefix + [LoginName] + ''', @rolename=''securityadmin'''   ELSE '' END
                    + CASE WHEN serveradmin     = 1 THEN @Prefix + [LoginName] + ''', @rolename=''serveradmin'''     ELSE '' END
                    + CASE WHEN setupadmin      = 1 THEN @Prefix + [LoginName] + ''', @rolename=''setupadmin'''      ELSE '' END
                    + CASE WHEN processadmin    = 1 THEN @Prefix + [LoginName] + ''', @rolename=''processadmin'''    ELSE '' END
                    + CASE WHEN diskadmin       = 1 THEN @Prefix + [LoginName] + ''', @rolename=''diskadmin'''       ELSE '' END
                    + CASE WHEN dbcreator       = 1 THEN @Prefix + [LoginName] + ''', @rolename=''dbcreator'''       ELSE '' END
                    + CASE WHEN bulkadmin       = 1 THEN @Prefix + [LoginName] + ''', @rolename=''bulkadmin'''       ELSE '' END
                  FROM (
                            SELECT CONVERT(VARCHAR(100),SUSER_SNAME(sid)) AS [LoginName],
                                    sysadmin,
                                    securityadmin,
                                    serveradmin,
                                    setupadmin,
                                    processadmin,
                                    diskadmin,
                                    dbcreator,
                                    bulkadmin
                            FROM sys.syslogins
                            WHERE (       sysadmin<>0
                                    OR    securityadmin<>0
                                    OR    serveradmin<>0
                                    OR    setupadmin <>0
                                    OR    processadmin <>0
                                    OR    diskadmin<>0
                                    OR    dbcreator<>0
                                    OR    bulkadmin<>0
                                ) 
                                AND name=@name 
                      ) L 
        
                    PRINT @tmpstr
                    PRINT @tmpstrRole
                    PRINT 'END'
                END 
                FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin, @defaultlanguage 
            END
            CLOSE login_curs
            DEALLOCATE login_curs
            RETURN 0
        END
      ```

     > [!NOTE]
     > This script creates two stored procedures in the master database. The procedures are named **sp_hexadecimal** and **sp_help_revlogin**.

  1. In the SSMS query editor, select the **[Results to Text](/sql/ssms/f1-help/database-engine-query-editor-sql-server-management-studio)** option.

  1. Run the following statement in the same or a new query window:

        ```sql
        EXEC sp_help_revlogin
        ```

  1. The output script that the `sp_help_revlogin` stored procedure generates is the login script. This login script creates the logins that have the original Security Identifier (SID) and the original password.

> [!IMPORTANT]
> Review the information in the following [Remarks](#remarks) section before you proceed with implementing steps on the destination server.

## Steps on the destination server (Server B)

Connect to Server B using any client tool (like SSMS) and then run the script generated in step 4 (output of `sp_helprevlogin`) from Server A.

## Remarks

Review the following information before you run the output script on the instance on server B:

- A password can be hashed in the following ways:

  - `VERSION_SHA1`: This hash is generated by using the SHA1 algorithm and is used in SQL Server 2000 through SQL Server 2008 R2.
  - `VERSION_SHA2`: This hash is generated by using the SHA2 512 algorithm and is used in SQL Server 2012 and later versions.

- Review the output script carefully. If server A and server B are in different domains, you have to change the output script. Then, you have to replace the original domain name by using the new domain name in the `CREATE LOGIN` statements. The integrated logins that are granted access in the new domain don't have the same SID as the logins in the original domain. Therefore, users are orphaned from these logins. For more information about how to resolve these orphaned users, see [Troubleshoot orphaned users (SQL Server)](/sql/sql-server/failover-clusters/troubleshoot-orphaned-users-sql-server) and [ALTER USER](/sql/t-sql/statements/alter-user-transact-sql).  
  If server A and server B are in the same domain, the same SID is used. Therefore, users are unlikely to be orphaned.

- In the output script, the logins are created by using the encrypted password. This is because of the HASHED argument in the `CREATE LOGIN` statement. This argument specifies that the password that is entered after the PASSWORD argument is already hashed.
- By default, only a member of the sysadmin fixed server role can run a `SELECT` statement from the `sys.server_principals` view. Unless a member of the sysadmin fixed server role grants the necessary permissions to the users, the users can't create or run the output script.
- The steps in this article don't transfer the default database information for a particular login. This is because the default database might not always exist on server B. To define the default database for a login, use the `ALTER LOGIN` statement by passing in the login name and the default database as arguments.
- Sort orders on source and destination servers:

  - **Case-insensitive server A and case-sensitive server B**: The sort order of server A might be case-insensitive, and the sort order of server B might be case-sensitive. In this case, users must type the passwords in all uppercase letters after you transfer the logins and the passwords to the instance on server B.
  - **Case-sensitive server A and case-insensitive server B:** The sort order of server A might be case-sensitive, and the sort order of server B might be case-insensitive. In this case, users can't log in by using the logins and the passwords that you transfer to the instance on server B unless one of the following conditions is true:

    - The original passwords contain no letters.
    - All letters in the original passwords are uppercase letters.

  - **Case-sensitive or case-insensitive on both servers**: The sort order of both server A and server B might be case-sensitive, or the sort order of both server A and server B might be case-insensitive. In these cases, the users don't experience a problem.

- A login that's already in the instance on server B might have a name that's the same as a name in the output script. In this case, you receive the following error message when you run the output script on the instance on server B:

  > Msg 15025, Level 16, State 1, Line 1  
The server principal '**MyLogin**' already exists.

  Similarly, a login that already is in the instance on server B might have a SID that's the same as a SID in the output script. In this case, you receive the following error message when you run the output script on the instance on server B:

  > Msg 15433, Level 16, State 1, Line 1
  Supplied parameter sid is in use.

  Therefore, you must do the following:

  1. Review the output script carefully.
  1. Examine the contents of the `sys.server_principals` view in the instance on server B.
  1. Address these error messages as appropriate.

     In SQL Server 2005, the SID for a login is used to implement database-level access. A login might have different SIDs in different databases on a server. In this case, the login can only access the database that has the SID that matches the SID in the `sys.server_principals` view. This problem might occur if the two databases are combined from different servers. To resolve this problem, manually remove the login from the database that has a SID mismatch by using the DROP USER statement. Then, add the login again by using the `CREATE USER` statement.

## References

- [Troubleshoot Orphaned Users](/sql/sql-server/failover-clusters/troubleshoot-orphaned-users-sql-server)

- [CREATE LOGIN (Transact-SQL)](/sql/t-sql/statements/create-login-transact-sql)

- [ALTER LOGIN (Transact-SQL)](/sql/t-sql/statements/alter-login-transact-sql)
