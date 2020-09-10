---
title: Pass parameters to a SQL Server stored procedure
description: This article describes an example of passing parameters to a SQL Server stored procedure from Visual FoxPro.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# Pass parameters to a SQL Server stored procedure

This article introduces an example of passing parameters to a SQL Server stored procedure from Visual FoxPro.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 247370

## Summary

There are two ways to pass parameters to a stored procedure using SQLExec. One way, which works across all versions of Visual FoxPro, is to build the SQL command as a string variable. The advantage of this method is that you can check the string and see exactly which SQL command you are passing to the back end.

The other way is to pass the Foxpro variables preceded with question marks, as in a parameterized view. In Visual FoxPro version 5.0 and later versions, this allows you to obtain values from the stored procedure that are being returned as output parameters.

## More information

Follow these steps:

1. Create two stored procedures in SQL Server (see Books Online for the exact steps). Mysp_ObjectList merely takes the SysObjects table and returns the value you pass it once for every record in the table. In mysp_GetVersion, we elaborate a bit on the normal procedure for finding the version of the server. SELECT @@VERSION normally returns the SQL Server version as a record in a cursor. Here, we assign that result to an output parameter of the stored procedure.

    ```sql
    CREATE PROCEDURE mysp_GetVersion @tcVersion Char(200) Output AS 
    SELECT @tcVersion = @@VERSION
    ```

    ```sql
    CREATE PROCEDURE mysp_ObjectList @tcParm1 CHAR(10) AS
    SELECT @tcParm1, name FROM sysobjects
    ```

2. Create a DSN called SPParmTest in the ODBC Administrator, which links to the database where you created the above procedures.
3. Run the following code in Visual FoxPro:

    ```sql
    *!* Error-checking is omitted for the purposes of this sample:
    *!* you should always check the return values from SQL Passthrough calls.
    lnConn = SQLCONNECT("SPParmTest")
    lcParm1 = "ReturnThis"
    lcParm2 = "Then This"*!* This is the first way, involving building a string 
    *!* containing the parameters.
    lcCommand = "exec mysp_ObjectList '" + lcParm1 + "'"
    =SQLEXEC(lnConn, lcCommand)
    BROWSE
    USE

    *!* This is the second way, passing the FoxPro variables directly to 
    *!* the SQL command. This will work in 3.0.
    lcCommand = "exec mysp_ObjectList ?lcParm2"
    =SQLEXEC(lnConn, lcCommand)
    BROWSE
    USE

    *!* To get a value back from a stored procedure, initialize the
    *!* output variable first. This won't work under 3.0.
    lcVersion = SPACE(200)
    lcCommand = "exec mysp_GetVersion ?@lcVersion" && Note the pass by reference.
    =SQLEXEC(lnConn, lcCommand)?lcVersion 

    =SQLDISCONNECT(lnConn) && clean up.
    ```
