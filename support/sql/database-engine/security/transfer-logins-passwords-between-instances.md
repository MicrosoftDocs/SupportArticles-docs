---
title: Transfer logins and passwords between instances
description: This article describes how to transfer the logins and the passwords between different instances of SQL Server running on Windows.
ms.date: 01/17/2025
ms.custom: sap:Security, Encryption, Auditing, Authorization
ms.reviewer: jopilov
ms.author: bartd
ms.topic: how-to
---

# Transfer logins and passwords between instances of SQL Server

 This article describes how to transfer the logins and the passwords between different instances of SQL Server running on Windows.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 918992, 246133

## Introduction

This article describes how to transfer the logins and passwords between different instances of Microsoft SQL Server. The instances might be on the same server or different servers, and their versions might differ.

## Why transfer logins between SQL Server instances?

In this article, server A and server B are servers.

After you move a database from a SQL Server instance on server A to a SQL Server instance on server B, users might be unable to log in to the database server on server B. Additionally, users might receive the following error message:

> Login failed for user '**MyUser**'. (Microsoft SQL Server, Error: 18456)

This problem occurs because the logins from the SQL Server instance on server A don't exist in the SQL Server instance on server B.

Keep in mind that error 18456 occurs for many other reasons. For more information on these causes and their resolutions, see [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).

## Steps to transfer the logins

To transfer the logins, use one of the following methods, as appropriate for your situation.

### Method 1: Generate scripts via SSMS on the source server and manually reset passwords for SQL Server logins on the destination server

You can generate login scripts in SQL Server Management Studio (SSMS) by using the [Generate Scripts option for a database](/sql/ssms/tutorials/scripting-ssms#script-a-database-by-using-the-generate-scripts-option). 

To generate scripts via SSMS on the source server and manually reset passwords for SQL Server logins on the destination server, follow these steps:

1. Connect to server A that's hosting the source SQL Server.
1. Expand the **Databases** node.
1. Right-click any user database and select **Tasks** > **Generate Scripts**.
1. The **Introduction** page opens. Select **Next** to open the **Choose Objects** page. Select **Script entire database and all database objects**.
1. Select **Next** to open the **Set Scripting Options** page. 
1. Select the **Advanced** button for Script Login options.
1. In the **Advanced** list, find **Script Logins**, set the option to **True** and select **OK**.
1. Back to **Set Scripting Options** under **Select how scripts should be saved** and select **Open in new query window**. 
1. Select **Next** twice, and then select **Finish**.
1. Find the section in the script that contains logins. Typically, the generated script contains text with the following comment at the beginning of this section:

   `/* For security reasons the login is created disabled and with a random password. */`

   > [!NOTE]
   > This indicates that the SQL Server Authentication logins are generated with a random password and are disabled by default. You need to reset the password and re-enable these logins on the destination server.

1. Apply the login script from the larger generated script to the destination SQL Server.
1. For any SQL Server Authentication logins, reset the password on the destination SQL Server and re-enable those logins.

### Method 2: Transfer logins and passwords to the destination server (Server B) using scripts generated on the source server (Server A)

1. Create stored procedures that will help generate necessary scripts to transfer logins and their passwords. To do so, connect to Server A using SQL Server Management Studio (SSMS) or any other client tool and run the following script:

    ```sql
    USE [master]
    GO
    IF OBJECT_ID('dbo.sp_hexadecimal') IS NOT NULL
        DROP PROCEDURE dbo.sp_hexadecimal
    GO
    CREATE PROCEDURE dbo.sp_hexadecimal
        @binvalue [varbinary](256)
        ,@hexvalue [nvarchar] (514) OUTPUT
    AS
    BEGIN
        DECLARE @i [smallint]
        DECLARE @length [smallint]
        DECLARE @hexstring [nchar](16)
        SELECT @hexvalue = N'0x'
        SELECT @i = 1
        SELECT @length = DATALENGTH(@binvalue)
        SELECT @hexstring = N'0123456789ABCDEF'
        WHILE (@i < =  @length)
        BEGIN
            DECLARE @tempint   [smallint]
            DECLARE @firstint  [smallint]
            DECLARE @secondint [smallint]
            SELECT @tempint = CONVERT([smallint], SUBSTRING(@binvalue, @i, 1))
            SELECT @firstint = FLOOR(@tempint / 16)
            SELECT @secondint = @tempint - (@firstint * 16)
            SELECT @hexvalue = @hexvalue
                + SUBSTRING(@hexstring, @firstint  + 1, 1)
                + SUBSTRING(@hexstring, @secondint + 1, 1)
            SELECT @i = @i + 1
        END
    END
    GO
    IF OBJECT_ID('dbo.sp_help_revlogin') IS NOT NULL
        DROP PROCEDURE dbo.sp_help_revlogin
    GO
    CREATE PROCEDURE dbo.sp_help_revlogin
        @login_name [sysname] = NULL
    AS
    BEGIN
        DECLARE @name                  [sysname]
        DECLARE @type                  [nvarchar](1)
        DECLARE @hasaccess             [int]
        DECLARE @denylogin             [int]
        DECLARE @is_disabled           [int]
        DECLARE @PWD_varbinary         [varbinary](256)
        DECLARE @PWD_string            [nvarchar](514)
        DECLARE @SID_varbinary         [varbinary](85)
        DECLARE @SID_string            [nvarchar](514)
        DECLARE @tmpstr                [nvarchar](4000)
        DECLARE @is_policy_checked     [nvarchar](3)
        DECLARE @is_expiration_checked [nvarchar](3)
        DECLARE @Prefix                [nvarchar](4000)
        DECLARE @defaultdb             [sysname]
        DECLARE @defaultlanguage       [sysname]
        DECLARE @tmpstrRole            [nvarchar](4000)
        IF @login_name IS NULL
        BEGIN
            DECLARE login_curs CURSOR
            FOR
            SELECT p.[sid],p.[name],p.[type],p.is_disabled,p.default_database_name,l.hasaccess,l.denylogin,default_language_name = ISNULL(p.default_language_name,@@LANGUAGE)
            FROM sys.server_principals p
            LEFT JOIN sys.syslogins l ON l.[name] = p.[name]
            WHERE p.[type] IN ('S' /* SQL_LOGIN */,'G' /* WINDOWS_GROUP */,'U' /* WINDOWS_LOGIN */)
                AND p.[name] <> 'sa'
                AND p.[name] not like '##%'
            ORDER BY p.[name]
        END
        ELSE
            DECLARE login_curs CURSOR
            FOR
            SELECT p.[sid],p.[name],p.[type],p.is_disabled,p.default_database_name,l.hasaccess,l.denylogin,default_language_name = ISNULL(p.default_language_name,@@LANGUAGE)
            FROM sys.server_principals p
            LEFT JOIN sys.syslogins l ON l.[name] = p.[name]
            WHERE p.[type] IN ('S' /* SQL_LOGIN */,'G' /* WINDOWS_GROUP */,'U' /* WINDOWS_LOGIN */)
                AND p.[name] <> 'sa'
                AND p.[name] NOT LIKE '##%'
                AND p.[name] = @login_name
            ORDER BY p.[name]
        OPEN login_curs
        FETCH NEXT FROM login_curs INTO @SID_varbinary,@name,@type,@is_disabled,@defaultdb,@hasaccess,@denylogin,@defaultlanguage
        IF (@@fetch_status = - 1)
        BEGIN
            PRINT '/* No login(s) found for ' + QUOTENAME(@login_name) + N'. */'
            CLOSE login_curs
            DEALLOCATE login_curs
            RETURN - 1
        END
        SET @tmpstr = N'/* sp_help_revlogin script
    ** Generated ' + CONVERT([nvarchar], GETDATE()) + N' on ' + @@SERVERNAME + N'
    */'
        PRINT @tmpstr
        WHILE (@@fetch_status <> - 1)
        BEGIN
            IF (@@fetch_status <> - 2)
            BEGIN
                PRINT ''
                SET @tmpstr = N'/* Login ' + QUOTENAME(@name) + N' */'
                PRINT @tmpstr
                SET @tmpstr = N'IF NOT EXISTS (
        SELECT 1
        FROM sys.server_principals
        WHERE [name] = N''' + @name + N'''
        )
    BEGIN'
                PRINT @tmpstr
                IF @type IN ('G','U') -- NT-authenticated Group/User
                BEGIN -- NT authenticated account/group 
                    SET @tmpstr = N'    CREATE LOGIN ' + QUOTENAME(@name) + N'
        FROM WINDOWS
        WITH DEFAULT_DATABASE = ' + QUOTENAME(@defaultdb) + N'
            ,DEFAULT_LANGUAGE = ' + QUOTENAME(@defaultlanguage)
                END
                ELSE
                BEGIN -- SQL Server authentication
                    -- obtain password and sid
                    SET @PWD_varbinary = CAST(LOGINPROPERTY(@name, 'PasswordHash') AS [varbinary](256))
                    EXEC dbo.sp_hexadecimal @PWD_varbinary, @PWD_string OUT
                    EXEC dbo.sp_hexadecimal @SID_varbinary, @SID_string OUT
                    -- obtain password policy state
                    SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END
                    FROM sys.sql_logins
                    WHERE [name] = @name
                    
                    SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END
                    FROM sys.sql_logins
                    WHERE [name] = @name
                    
                    SET @tmpstr = NCHAR(9) + N'CREATE LOGIN ' + QUOTENAME(@name) + N'
        WITH PASSWORD = ' + @PWD_string + N' HASHED
            ,SID = ' + @SID_string + N'
            ,DEFAULT_DATABASE = ' + QUOTENAME(@defaultdb) + N'
            ,DEFAULT_LANGUAGE = ' + QUOTENAME(@defaultlanguage)
                    
                    IF @is_policy_checked IS NOT NULL
                    BEGIN
                        SET @tmpstr = @tmpstr + N'
            ,CHECK_POLICY = ' + @is_policy_checked
                    END
                    
                    IF @is_expiration_checked IS NOT NULL
                    BEGIN
                        SET @tmpstr = @tmpstr + N'
            ,CHECK_EXPIRATION = ' + @is_expiration_checked
                    END
                END
                IF (@denylogin = 1)
                BEGIN -- login is denied access
                    SET @tmpstr = @tmpstr
                        + NCHAR(13) + NCHAR(10) + NCHAR(9) + N''
                        + NCHAR(13) + NCHAR(10) + NCHAR(9) + N'DENY CONNECT SQL TO ' + QUOTENAME(@name)
                END
                ELSE IF (@hasaccess = 0)
                BEGIN -- login exists but does not have access
                    SET @tmpstr = @tmpstr
                        + NCHAR(13) + NCHAR(10) + NCHAR(9) + N''
                        + NCHAR(13) + NCHAR(10) + NCHAR(9) + N'REVOKE CONNECT SQL TO ' + QUOTENAME(@name)
                END
                IF (@is_disabled = 1)
                BEGIN -- login is disabled
                    SET @tmpstr = @tmpstr
                        + NCHAR(13) + NCHAR(10) + NCHAR(9) + N''
                        + NCHAR(13) + NCHAR(10) + NCHAR(9) + N'ALTER LOGIN ' + QUOTENAME(@name) + N' DISABLE'
                END
                SET @Prefix =
                    NCHAR(13) + NCHAR(10) + NCHAR(9) + N''
                    + NCHAR(13) + NCHAR(10) + NCHAR(9) + N'EXEC [master].dbo.sp_addsrvrolemember @loginame = N'''
                SET @tmpstrRole = N''
                SELECT @tmpstrRole = @tmpstrRole
                    + CASE WHEN sysadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''sysadmin''' ELSE '' END
                    + CASE WHEN securityadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''securityadmin''' ELSE '' END
                    + CASE WHEN serveradmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''serveradmin''' ELSE '' END
                    + CASE WHEN setupadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''setupadmin''' ELSE '' END
                    + CASE WHEN processadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''processadmin''' ELSE '' END
                    + CASE WHEN diskadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''diskadmin''' ELSE '' END
                    + CASE WHEN dbcreator = 1 THEN @Prefix + LoginName + N''', @rolename = N''dbcreator''' ELSE '' END
                    + CASE WHEN bulkadmin = 1 THEN @Prefix + LoginName + N''', @rolename = N''bulkadmin''' ELSE '' END
                FROM (
                    SELECT
                        SUSER_SNAME([sid])AS LoginName
                        ,sysadmin
                        ,securityadmin
                        ,serveradmin
                        ,setupadmin
                        ,processadmin
                        ,diskadmin
                        ,dbcreator
                        ,bulkadmin
                    FROM sys.syslogins
                    WHERE (    sysadmin <> 0
                            OR securityadmin <> 0
                            OR serveradmin <> 0
                            OR setupadmin <> 0
                            OR processadmin <> 0
                            OR diskadmin <> 0
                            OR dbcreator <> 0
                            OR bulkadmin <> 0
                            )
                        AND [name] = @name
                    ) L
                IF @tmpstr <> '' PRINT @tmpstr
                IF @tmpstrRole <> '' PRINT @tmpstrRole
                PRINT 'END'
            END
            FETCH NEXT FROM login_curs INTO @SID_varbinary,@name,@type,@is_disabled,@defaultdb,@hasaccess,@denylogin,@defaultlanguage
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
1. Review and follow the information in the [Remarks](#remarks) section before you proceed with implementing steps on the destination server.
1. Once you implement any applicable steps from the [Remarks](#remarks) section, connect to the destination server B using any client tool (like SSMS).
1. Run the script generated as the output of `sp_helprevlogin` from server A.

## Remarks

Review the following information before you run the output script on the instance on server B:

### Password hashing information

- A password can be hashed in the following ways:

  - `VERSION_SHA1`: This hash is generated by using the SHA1 algorithm and is used in SQL Server 2000 through SQL Server 2008 R2.
  - `VERSION_SHA2`: This hash is generated by using the SHA2 512 algorithm and is used in SQL Server 2012 and later versions.
- In the output script, the logins are created by using the encrypted password. This is because of the `HASHED` argument in the `CREATE LOGIN` statement. This argument specifies that the password that is entered after the `PASSWORD` argument is already hashed.

### How to handle the change of domains

Are your source and destination servers in different domains? Review the output script carefully. If server A and server B are in different domains, you have to change the output script. Then, you have to replace the original domain name by using the new domain name in the `CREATE LOGIN` statements. The integrated logins that are granted access in the new domain don't have the same SID as the logins in the original domain. Therefore, users are orphaned from these logins. For more information about how to resolve these orphaned users, see [Troubleshoot orphaned users (SQL Server)](/sql/sql-server/failover-clusters/troubleshoot-orphaned-users-sql-server) and [ALTER USER](/sql/t-sql/statements/alter-user-transact-sql).  

If server A and server B are in the same domain, the same SID is used. Therefore, users are unlikely to be orphaned.

### Permissions to view and select all logins

By default, only a member of the sysadmin fixed server role can run a `SELECT` statement from the `sys.server_principals` view. Unless a member of the sysadmin fixed server role grants the necessary permissions to the users, the users can't create or run the output script.

### Default database setting isn't scripted and transferred

The steps in this article don't transfer the default database information for a particular login. This is because the default database might not always exist on server B. To define the default database for a login, use the `ALTER LOGIN` statement by passing in the login name and the default database as arguments.

### How to deal with different sort orders between the source and destination servers

There might be differences in sort orders between the source and destination servers, or they might be the same. Here's how each scenario can be addressed:

- **Case-insensitive server A and case-sensitive server B**: The sort order of server A might be case-insensitive, and the sort order of server B might be case-sensitive. In this case, users must type the passwords in all uppercase letters after you transfer the logins and the passwords to the instance on server B.
- **Case-sensitive server A and case-insensitive server B:** The sort order of server A might be case-sensitive, and the sort order of server B might be case-insensitive. In this case, users can't log in by using the logins and the passwords that you transfer to the instance on server B unless one of the following conditions is true:

  - The original passwords contain no letters.
  - All letters in the original passwords are uppercase letters.

- **Case-sensitive or case-insensitive on both servers**: The sort order of both server A and server B might be case-sensitive, or the sort order of both server A and server B might be case-insensitive. In these cases, the users don't experience a problem.

### How to deal with logins already existing on the destination server

The script is designed to check if the login exists on the destination server and create a login only if it doesn't. However, if you receive the following error message when you run the output script on the instance on server B, you have to manually resolve it by following the steps in this section.

> Msg 15025, Level 16, State 1, Line 1  
> The server principal '**MyLogin**' already exists.

Similarly, a login that's already in the instance on server B might have a SID that's the same as a SID in the output script. In this case, you receive the following error message when you run the output script on the instance on server B:

> Msg 15433, Level 16, State 1, Line 1
> Supplied parameter sid is in use.

To manually resolve the issue, follow these steps:

1. Review the output script carefully.
1. Examine the contents of the `sys.server_principals` view in the instance on server B.
1. Address these error messages as appropriate.

Starting with SQL Server 2005, the SID for a login is used to manage database-level access. Occasionally, a login might have different SIDs when mapped to users in different databases. This issue can occur if databases are manually combined from different servers. In such cases, the login can only access the database where the database principal's SID matches the SID in the `sys.server_principals` view. To resolve this issue, manually remove the database user with the mismatched SID using the [DROP USER](/sql/t-sql/statements/drop-user-transact-sql) statement. Then, add the user again with the `CREATE USER` statement and map it to the correct login (server principal).

For more information and to distinguish servers from database principals, see [CREATE USER](/sql/t-sql/statements/create-user-transact-sql) and [CREATE LOGIN](/sql/t-sql/statements/create-login-transact-sql).

## References

- [Troubleshoot Orphaned Users](/sql/sql-server/failover-clusters/troubleshoot-orphaned-users-sql-server)
- [CREATE LOGIN (Transact-SQL)](/sql/t-sql/statements/create-login-transact-sql)
- [ALTER LOGIN (Transact-SQL)](/sql/t-sql/statements/alter-login-transact-sql)
- [Script objects in SQL Server Management Studio](/sql/ssms/tutorials/scripting-ssms)