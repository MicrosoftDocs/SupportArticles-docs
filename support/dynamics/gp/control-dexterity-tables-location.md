---
title: Control the location of the Dexterity tables in SQL Server by using Dexterity path names in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains
description: Contains manual and programmatic methods to specify path names for Dexterity tables.
ms.reviewer: 
ms.topic: how-to
ms.date: 03/13/2024
---
# How to control the location of the Dexterity tables in SQL Server by using Dexterity path names in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains

This article describes how to control the location of the Dexterity tables in Microsoft SQL Server by using Dexterity path names in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 919347

A Microsoft Dynamics GP 9.0 table or a Microsoft Great Plains table is stored in one of the following locations in SQL Server:

- The DYNAMICS database
- The company database

The location of the paths to these tables is stored in the SY_Pathnames table (SY02100). The location depends on the series in which a table is stored. Most of the series have default values that are defined in the SY_Pathnames table. Therefore, if you use these series, the tables are stored in the specified database. The following table shows the default series together with the corresponding paths.

| Series number| Series name| Path name |
|---|---|---|
|1|Financial|Company (**DatabaseName** /dbo/)|
|2|Sales|Company (**DatabaseName** /dbo/)|
|3|Purchasing|Company (**DatabaseName** /dbo/)|
|4|Inventory|Company (**DatabaseName** /dbo/)|
|5|Payroll|Company (**DatabaseName** /dbo/)|
|6|Project|Company (**DatabaseName** /dbo/)|
|7|System|System (DYNAMICS/dbo/)</br>|
|8|Company|Company (**DatabaseName** /dbo/)|
|9|Online Documentation|System (DYNAMICS/dbo/)</br>|
|10|3rd Party|Not defined|
|11|Payroll Tax|System (DYNAMICS/dbo/)</br>|
|12|Pathname|System (DYNAMICS/dbo/)</br>|
|13|Design Document|System (DYNAMICS/dbo/)</br>|
|14|Dexterity|System (DYNAMICS/dbo/)</br>|
|15|Dexterity System|System (DYNAMICS/dbo/)</br>|
|16|Report Writer|Not defined|

Series 10 (3rd Party) and Series 16 (Report Writer) aren't defined. Generally, developers don't use Series 16 (Report Writer). However, developers frequently use Series 10 (3rd Party).

If you use Series 10 (3rd Party) without defining a path name, the tables are created in one of the following locations:

- If a default database is set in the ODBC configuration, the tables are created in the default database.
- If a default database isn't set in the ODBC configuration, the tables are created in the SQL Server master database.

You may find both of these locations to be inconvenient when you use Series 10. For you to control the location of the Dexterity tables, the tables must belong to a Dexterity table group. Table groups are displayed under the base node of the Dexterity Resource Explorer. Create a new table group of the same series as your tables, and then associate your tables to that group. After the table belongs to a table group, you can create an entry for the table in the SY_Pathnames table.

## How to manually create entries in the SY_Pathnames table

To manually create entries in the SY_Pathnames table, follow these steps:

1. In the **Shortcuts** pane, click **Add** > **Other Window**.
2. In the Add Window Shortcut window, expand **Microsoft Dynamics GP** in the **Available Windows** list, expand **Company**, click **Pathnames** > **Add** > **Done**.
3. In the **Shortcuts** pane, click **Pathnames** to open the Pathnames window.
4. In the **Product** list, click the appropriate product. For example, click **Microsoft Dynamics GP**.
5. In the **Table Series** list, click the series that you want to modify. For example, click **3rd Party**.
6. In the **Pathname** box, type the path that you want to specify by using the following format:

    **DatabaseName** /dbo/
7. Click **Apply**.

For system-based series, you have to follow these steps only one time. However, for company-based series, you must follow these steps for each company.

## How to programmatically create entries in the SY_Pathnames table

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. It includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements.

To programmatically create entries in the SY_Pathnames table, use code that resembles the following sample code.

### For system tables

```console
local string l_path;

set 'Company ID' of table SY_Pathnames to 0;
set DictID of table SY_Pathnames to DYNAMICS;
set 'File Series' of table SY_Pathnames to 7; { System }
set 'Logical File ID' of table SY_Pathnames to 0;
get table SY_Pathnames;
if err() = OKAY then
set l_path to 'Data Pathname' of table SY_Pathnames;

set 'Company ID' of table SY_Pathnames to 0;
set DictID of table SY_Pathnames to Runtime_GetCurrentProductID(); { Current Product ID }
set 'File Series' of table SY_Pathnames to 7; { System }
set 'Logical File ID' of table SY_Pathnames to 0;
change table SY_Pathnames;
set 'Data Pathname' of table SY_Pathnames to l_path;
save table SY_Pathnames;
check error;
end if;
```

### For company tables

```console
local string l_path;

set 'Company ID' of table SY_Pathnames to 'Company ID' of globals;
set DictID of table SY_Pathnames to DYNAMICS;
set 'File Series' of table SY_Pathnames to 8; { Company }
set 'Logical File ID' of table SY_Pathnames to 0;
get table SY_Pathnames;
if err() = OKAY then
set l_path to 'Data Pathname' of table SY_Pathnames;

set 'Company ID' of table SY_Pathnames to 'Company ID' of globals;
set DictID of table SY_Pathnames to Runtime_GetCurrentProductID(); { Current Product ID }
set 'File Series' of table SY_Pathnames to 10; { 3rd Party }
set 'Logical File ID' of table SY_Pathnames to 0;
change table SY_Pathnames;
set 'Data Pathname' of table SY_Pathnames to l_path;
save table SY_Pathnames;
check error;
end if;
```

> [!IMPORTANT]
> You must set the Pathnames entry before you reference one or more of the tables that are affected by the path name change.
