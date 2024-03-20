---
title: The connection to the Microsoft Dynamics GP database failed error when signing in to a company
description: Describes an error that you may receive when you try to sign in to your company in Microsoft Management Reporter. Provides a resolution.
ms.reviewer: theley, gbyer, kevogt
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Management Reporter
---
# "The connection to the Microsoft Dynamics GP database failed" error when you sign in to a company

This article provides a resolution for the issue that when you select and sign in to a company in Microsoft Management Reporter, you receive the **Unable to connect to the 'Company Name' company** error.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2737852

## Symptoms

When you select a company in Microsoft Management Reporter and try to sign in, you receive the following error message:

> Unable to connect to the 'Company Name' company. The connection to the Microsoft Dynamics GP database failed. Contact your system administrator.

If you use the sa user, you can successfully sign in to the company.

## Cause

The server name that is listed in the ODBC on the client computer that connects to Microsoft Dynamics GP has a different name for the SQL Server in it versus what is listed in the Company Settings in Management Reporter.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

There are two methods to resolve this error message. If the first method does not resolve the error, you must continue with the second method.

### Method 1

1. On the computer that was having the issue, open Control Panel and then select **Administrative Tools**. Select Data Sources (ODBC).
2. When the ODBC window is open, select the **System DSN** tab and highlight the GP ODBC, then select **Configure**.
3. Note the server name that is listed in the first window under the question for "Which SQL Server do you want to connect to?" Note the server name that is listed here.
4. After you note the server name in the ODBC, open Management Reporter 2012 Configuration Console.
5. Select **ERP Integrations**. The GP integration will be listed. Select the integration and verify that the server name is correct.

### Method 2

1. Start SQL Server Management Studio and sign in as the sa user.
2. Open a new query window and run this statement against the MR database:

    ```sql
    select * from ControlCompany
    ```

    CU13 or later

    ```sql
    select * from Reporting.ControlCompany
    ```

   You will see each of your companies listed in the Code and Name columns.

3. Find your company and then to the right of it examine the **GLEntityConnectionInformation** column. You may find it easiest to copy the cell out to Notepad and view it.
4. Find the value for the SQL Server. It can be found in this string:

   \<EntitySetting Name="SQL Server"> \<Value xsi:type="xsd:string"> server_name </Value>

   Note the server name.
5. Open Control Panel and then Administrative Tools. Open Data Sources. If you are using a 64-bit OS, you can go to C:\Windows\SysWow64\odbcad32.exe and then open the ODBC.
6. Configure the ODBC and note the Server field on the first page. This must match the server name from step 4.
7. In SQL Server Management Studio, expand the MR database and then expand Tables.
8. Right-click the ControlCompany table and then select Edit Top 200 Rows.
9. Update the server name in the **GLEntityConnectionInformation** column. Update the server name in the following string:

   \<EntitySetting Name="SQL Server"> \<Value xsi:type="xsd:string"> server_name </Value> </EntitySetting>
