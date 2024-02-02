---
title: Run SQL Server stored procedures from an ASP Page
description: This article describes how to run SQL Server stored procedures and use parameters from an ASP page.
ms.date: 09/24/2020
ms.custom: sap:Active Server Pages
ms.reviewer: JAYAPST
---
# Run SQL Server stored procedures from an ASP Page

This article shows how to run SQL Server stored procedures and use parameters from an Active Server Pages (ASP) page.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 300488

## Summary

This article assumes that you are familiar with the procedure to use ActiveX Data Objects (ADO) in an ASP page.

## Step-by-Step Example

1. Run the following query in SQL Server Query Analyzer or SQL Server Management Studio against the Pubs database:

    ```sql
    CREATE proc MyProc
    (
        @price smallint,
        @out smallint OUTPUT
    )
    AS
    Select @out = count(*) from titles where price < @price
    GO
    ```

    The stored procedure (`MyProc`) takes one input parameter (`@price`) and returns one output parameter (`@out`).
  
    > [!NOTE]
    > By default, the `Northwind` sample database and the pubs sample databases are not installed in SQL Server 2005. These databases can be downloaded from the Microsoft Download Center. For more information about how to download the Northwind sample database and the pubs sample database, visit the following Microsoft Web site: [Downloading Northwind and pubs Sample Databases](/previous-versions/sql/sql-server-2008-r2/ms143221(v=sql.105))

2. The following ASP sample code calls the newly created stored procedure. You can use this ASP code to set up the input parameter and run the query.

    1. Use the `CreateParameter` method to create parameters in ADO as follows:
  
        ```vbnet
        Set myParameter = Command.CreateParameter (Name, [Type], [Direction], [Size], [Value])
        ```
  
    2. Appended the parameter to the Parameters collection as follows:
  
        ```vbnet
        Command.Parameters.Append myParameter
        ```
  
        > [!NOTE]
        > The parameters in the Parameters collection must match the order of the parameters in the stored procedure.
    3. Run the command to pass parameter values in and out of the stored procedure as follows:
  
        ```aspx-vb
        <%
        Dim cmd
        Dim ln
        Dim retCount
  
        Set cmd = Server.CreateObject("ADODB.Command")
  
        With cmd
         .ActiveConnection = "Paste your connection string here"
         .Commandtext = "MyProc"
         .CommandType = adCmdStoredProc
         .Parameters.Append .CreateParameter("@price", adSmallInt, adParamInput, 10).Parameters("@price") = 22
         .Parameters.Append .CreateParameter("@retValue", adSmallInt, adParamOutput, 10).Execute ln, , adExecuteNoRecords
         retCount = .Parameters("@retValue")
        End with
  
        Response.Write retcount
  
        Set cmd = Nothing
        %>
        ```
  
        > [!NOTE]
        > The constants that are used in this sample can be found in the *Adovbs.inc* file. This file is installed during Active Server Pages setup and placed in the `\Aspsamp\Samples` folder, which is normally located in your `\Inetpub` folder. It is recommended programming practice to use the constants rather than the numerical values when you call your stored procedure so that your code is easier to read and maintain.
  
       ```vbscript
        <%@ LANGUAGE = VBScript %>
        <!-- #INCLUDE VIRTUAL="/ASPSAMP/SAMPLES/ADOVBS.INC" -->
        ```

3. Modify the ADO connection string as appropriate for your environment.
4. Save the ASP page, and view it in the browser.

    > [!NOTE]
    > It can be difficult to determine how to properly call a stored procedure if you are unaware of the stored procedure's parameter information. Without the correct information, you cannot properly create the ADO parameters. You can use the Refresh method of the Parameter object to populate the Parameters collection automatically, based on the stored procedure's definition on the server. For example:
  
    ```vbnet
    Command.Parameters.Refresh
    ```

## References

For more information, see [Create a simple data application by using ADO.NET](/visualstudio/data-tools/create-a-simple-data-application-by-using-adonet).
