---
title: Error when you run CLR object or create assembly
description: This article helps you resolve two different problems that occur when working with CLR objects on a database that has been moved from a different instance of SQL Server.
ms.date: 09/19/2022
ms.custom: sap:Administration and Management  
ms.reviewer: jackli
---

# Error when you run an existing CLR object or create an assembly

This article helps you resolve two different problems that can occur when working with CLR objects on a database that has been moved from a different instance of SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 918040

## Symptoms

Consider the following scenario. You detach or back up a database that is in an instance of SQL Server. The instance of SQL Server is running on Server A. Later, you attach or restore that database to an instance of SQL Server that is running on Server B. In this scenario, you may experience the following symptoms:

- When you try to run an existing common language runtime (CLR) object that has the `external_access` or unsafe permission set from the database that is on Server B, you receive the following error message:

  > Msg 10314, Level 16, State 11, Line 2  
An error occurred in the Microsoft .NET Framework while trying to load assembly id 65536. The server may be running out of resources, or the assembly may not be trusted with PERMISSION_SET = EXTERNAL_ACCESS or UNSAFE. Run the query again, or check documentation to see how to solve the assembly trust issues. For more information about this error:  
System.IO.FileLoadException: Could not load file or assembly 'AssemblyName, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null' or one of its dependencies. An error relating to security occurred. (Exception from HRESULT: 0x8013150A) System.IO.FileLoadException:  
at System.Reflection.Assembly.nLoad(AssemblyName fileName, String codeBase, Evidence assemblySecurity, Assembly locationHint, StackCrawlMark& stackMark, Boolean throwOnFileNotFound, Boolean forIntrospection)
at System.Reflection.Assembly.InternalLoad(AssemblyName assemblyRef, Evidence assemblySecurity, StackCrawlMark& stackMark, Boolean forIntrospection)
at System.Reflection.Assembly.InternalLoad(String assemblyString, Evidence assemblySecurity, StackCrawlMark& stackMark, Boolean forIntrospection)
at System.Reflection.Assembly.Load(String assemblyString)

- When you try to create a new assembly that has the `external_access` or unsafe permission set in the same database, you receive the following error message:

  > Server: Msg 10327, Level 14, State 1, Line 1  
CREATE ASSEMBLY for assembly 'AssemblyName' failed because assembly 'AssemblyName' is not authorized for PERMISSION_SET = EXTERNAL_ACCESS. The assembly is authorized when either of the following is true: the database owner (DBO) has EXTERNAL ACCESS ASSEMBLY permission and the database has the TRUSTWORTHY database property on; or the assembly is signed with a certificate or an asymmetric key that has a corresponding login with EXTERNAL ACCESS ASSEMBLY permission.

The issues occur even if you have already set the `Trustworthy` database property to **ON**.

## Cause

This problem occurs because the login that you use to create the database on Server A isn't in the instance of SQL Server on Server B. This login could be either the Microsoft Windows login or the SQL Server login.

## Workaround

To work around this problem, use one of the following methods.

> [!NOTE]
> Before you use the following methods, make sure that you enable the `Trustworthy` database property.

- Use the `sp_changedbowner` stored procedure to change the database owner to **sa** or to an available login on Server B. For example, you may use the following statement to change the database owner to **sa**:

    ```sql
    USE <DatabaseName>
    GO

    EXEC sp_changedbowner 'sa'
    ```

    > [!NOTE]
    > In this statement, `<DatabaseName>` is a placeholder of the name of the database that you are working on. The changed database owner should have the corresponding permissions to perform a certain task. For example, the database owner should have the CREATE ASSEMBLY permission to create an assembly.

- Add the login on the instance of SQL Server on Server A that is used to create the database to the instance of SQL Server on Server B.

If the login is a domain account, you can create the same login on Server B. Then grant the required permissions to the login on the instance of SQL Server on Server B.

If the login is a SQL Server login, make sure that the SID of this login matches the new SQL Server login that you create on the instance of SQL Server on Server B. To do this, specify the SID argument of the `CREATE LOGIN` statement.

## More information

If you access the CLR object from a different database, and that database has a mismatching DBO SID, the same problem can occur.

For more information, visit the following blog: [CSS SQL Server Engineers](/archive/blogs/psssql/).

## References

- [CREATE LOGIN (Transact-SQL)](/sql/t-sql/statements/create-login-transact-sql)

- [sp_changedbowner (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-changedbowner-transact-sql)

- [CREATE ASSEMBLY (Transact-SQL)](/sql/t-sql/statements/create-assembly-transact-sql)
