---
title: Agent job may fail with error 65535, 782, or 7437
description: This article provides a workaround for the problem where the SQL Agent job that executes a distributed query might fail with 65535, 782, or 7437 error messages.
ms.date: 09/19/2022
ms.custom: sap:Administration and Management
ms.reviewer: vencher, vasilp
---
# SQL Agent job that executes a distributed query may fail with 65535, 782, or 7437 error messages

This article helps you resolve the problem where the SQL Agent job that executes a distributed query might fail with 65535, 782, or 7437 error messages.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2492477

## Symptoms

A SQL Agent job that executes a distributed (linked server) query might fail with one of the error messages similar to the following, when the owner of the job isn't a member of the *sysadmin* server role:

- > OLE DB provider "\<provider name>" for linked server "\<Linkedserver Name>" returned message "Login timeout expired".  
OLE DB provider "\<provider name>" for linked server ""\<Linkedserver Name>" returned message "An error has occurred while establishing a connection to the server. When connecting to SQL Server 2005, this failure may be caused by the fact that under the default settings SQL Server does not allow remote connections.".  
Msg 65535, Level 16, State 1, Line 0  
SQL Network Interfaces: Error Locating Server/Instance Specified [xFFFFFFFF].

- > Msg 782, Level 16, State 1, Line 0  
SSL Provider: No credentials are available in the security package  
*OLE DB provider "* \<provider name> *" for linked server "\<Linkedserver Name>" returned message "Client unable to establish connection".*  

For example, in a SQL Server 2008 environment, the error messages may be similar to the following:

- > OLE DB provider "SQLNCLI" for linked server "\<Linkedserver Name>" returned message "Login timeout expired".  
OLE DB provider "SQLNCLI" for linked server ""\<Linkedserver Name>" returned message "An error has occurred while establishing a connection to the server. When connecting to SQL Server 2005, this failure may be caused by the fact that under the default settings SQL Server does not allow remote connections.".  
Msg 65535, Level 16, State 1, Line 0  
SQL Network Interfaces: Error Locating Server/Instance Specified [xFFFFFFFF].

- > Msg 782, Level 16, State 1, Line 0  
SSL Provider: No credentials are available in the security package
*OLE DB provider "SQLNCLI10" for linked server "\<Linkedserver Name>" returned message "Client unable to establish connection".*  

- > Msg 7437, Level 16, State 1, Line 3  
Linked servers cannot be used under impersonation without a mapping for the impersonated login.

You might also see the same behavior when using `Openquery` or when executing a distributed query using impersonation through the `Execute as Login` T-SQL statement.

## Cause

Transact-SQL job step runs as the owner of the job step if the owner of the job step isn't a member of the *sysadmin* fixed server role. SQL Agent uses `Execute as Login` to execute the job step under the context of the owner of the job step. You can't use the `EXECUTE AS` statement across server boundaries. This behavior is by design. For more information, see the following topics in SQL Server Books Online:

- [EXECUTE AS (Transact-SQL)](/sql/t-sql/statements/execute-as-transact-sql)
- [Extending Database Impersonation by Using EXECUTE AS](/previous-versions/sql/sql-server-2008-r2/ms188304(v=sql.105))

> [!NOTE]
> The same cause applies to the scenario wherein you manually try to change the execution context of a distributed query in management studio using the `EXECUTE AS` statement.

## Workaround

> [!IMPORTANT]
> The following workaround requires you to define an explicit local server login to remote server login mappings using the Security page under Properties of the linked server object. Because the Remote User column must be a SQL Server Authentication login on the remote server, the remote server's authentication mode should either already be set to Mixed mode or should be changed to Mixed mode before using the workaround.

If a T-SQL job step is owned by a user that isn't part of the *sysadmin* server role and if the step contains a distributed query, perform the following steps to ensure the jobs or queries don't fail:

1. Create a mapping for each of the job-step owner on the local server to an existing or new login on the remote server.
2. Ensure that the login has sufficient privileges to execute various modules on the remote server that are accessed in the distributed query. For more information, see [Linked Server Properties (Security Page)](/sql/relational-databases/linked-servers/create-linked-servers-sql-server-database-engine?view=sql-server-ver16&preserve-view=true).

## More information

Sometimes you might notice that queries discussed in either of the scenarios in [Symptoms](#symptoms) section might run successfully. This usually occurs when the impersonated user had previously logged on to the remote system and the system still has kept open a connection established by the remote user. You shouldn't expect that the query will work all the time.

Steps to reproduce the behavior

1. On your SQL instance, create a linked server to another SQL instance either using SQL Server Management Studio (SSMS) or the following script.

    ```sql
    EXEC master.dbo.sp_addlinkedserver @server = <server name>, @srvproduct=N'SQL Server'
    /* For security reasons the linked server remote logins password is changed with ######## */
    EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=<servername> ,
    @useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
    ```

2. Execute the following query in SSMS using a login that's a member of *sysadmin* server role and ensure it works fine.

    ```sql
    SELECT * FROM <servername>.master.sys.sysobjects
    ```

3. Now change the context of the query to a non-sysadmin account and execute the same query.

    ```sql
    EXECUTE AS login='Domain\Login1'
    GO
    SELECT suser_sname()
    GO
    SELECT * FROM <servername>.master.sys.sysobjects
    GO
    ```

This step fails with the error mentioned in the [Symptoms](#symptoms) section.

> [!NOTE]
> `OPENROWSET` and `OPENDATASOURCE` functions aren't affected by this issue as these functions include the credentials as parameters.  
> `BEGIN DISTRIBUTED TRANSACTION` is a separate statement that doesn't get its own credentials and isn't affected by this issue. However, if linked server security isn't properly configured, these statements can still fail.

