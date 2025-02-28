---
title: Creating a linked server to DB2
description: This article describes a sample SQL script for creating a linked server to DB2 using sp_addlinkedserver, and issues a few queries to illustrate the Distributed Query Processing.
ms.date: 05/07/2024
ms.custom: sap:Data Integration (DB2, Host Files)
ms.reviewer: syedw, jeremyr
---
# Creating a linked server to DB2 using Microsoft OLE DB provider for DB2

This article describes a sample SQL script for creating a linked server to DB2 using `sp_addlinkedserver`, and issues a few queries to illustrate the Distributed Query Processing (DQP).

_Original product version:_ &nbsp; Host Integration Server  
_Original KB number:_ &nbsp; 222937

## Summary

This article provides a sample SQL script for creating a linked server to DB2 using `sp_addlinkedserver`, and issues a few queries to illustrate the DQP using `DB2OLEDB`, the OLE DB provider for DB2.

[INF: Configuring Data Sources for the Microsoft OLE DB Provider for DB2](https://support.microsoft.com/help/218590)

## Creating Linked Server

```sql
EXEC sp_addlinkedserver
@server = 'WNW3XX',
@srvproduct = 'Microsoft OLE DB Provider for DB2',
@catalog = 'OLYMPIA',
@provider = 'DB2OLEDB',
@provstr='NetLib=SNA;NetAddr=;NetPort=;RemoteLU=OLYMPIA;LocalLU=LOCAL;ModeName=QPCSUPP;User ID=WNW3XX;Password=WNW3XX;InitCat=OLYMPIA;Default Schema=WNW3XX;PkgCol=WNW3XX;TPName=;Commit=YES;IsoLvl=NC;AccMode=;CCSID=37;PCCodePage=1252;BinAsChar=NO;Data Source=Olympia_WNW3XX'

EXEC sp_addlinkedsrvlogin 'WNW3XX', false, NULL, 'WNW3XX', 'WNW3XX'
```

> [!NOTE]
>
> - `DB2OLEDB` provider needs to run in-proc. To enable this setting:
>
>   1. Start the SQL Server Enterprise Manager.
>
>   2. In the Console tree, find the Linked Servers node (under the Security folder). Right-click on the linked server created above, and in the **Properties** dialog box, click the **General** tab, then click on Options, and click to enable the **Allow InProcess** setting. This is the only way to enable this setting, and after it has been enabled for a given provider, the setting is used for every subsequent linked server created using that provider, including the ones created with T-SQL script.
>
> - The total length of the linked server initstring must be no more than 278 characters, so it is advantageous to use the `DB2OLEDB` short connection string arguments as documented above.
>
> - Linked Servers using `DB2OLEDB` can also be configured to connect over TCP/IP, though the above script illustrates this using an SNA APPC connection.

## Sample Distributed Queries

- Example of `SELECT` using 4-part name: `LinkedServer.Catalog.Schema.Table`

    ```sql
    SELECT * FROM WNW3XX.OLYMPIA.WNW3XX.DEPARTMENT
    ```

- Example of Pass Through `SELECT` using `OPENQUERY` with 3-part name:

    ```sql
    SELECT * FROM OPENQUERY(WNW3XX,"SELECT * FROM OLYMPIA.WNW3XX.EMP_ACT")
    ```

- Example of Pass Through `SELECT` using `OPENROWSET` with 2-part name:

    ```sql
    SELECT * FROM OPENROWSET
    ('DB2OLEDB',Netlib=SNA;NetAddr=;NetPort=;RemoteLU=OLYMPIA;LocalLU=LOCAL;ModeName=QPCSUPP;User ID=WNW3XX;Password=WNW3XX;InitCat=OLYMPIA;Default Schema=WNW3XX;PkgCol=WNW3XX;TPName=;Commit=YES;IsoLvl=NC;AccMode=;CCSID=37;PCCodePage=1252;BinAsChar=NO;Data Source=Sample',
    'SELECT * FROM WNW3XX.EMPLOYEE')
    ```

- Example of an `INSERT` using 4-part name:

    ```sql
    INSERT INTO WNW3XX.OLYMPIA.WNW3XX.DEPARTMENT VALUES
    ('E21','DUMMY',NULL,'E01')
    ```

  > [!NOTE]
  > `UPDATE` and `DELETE` using DQP are not possible with the `DB2OLEDB` provider that shipped with SNA version 4.0 Service Pack 2 and Service Pack 3 due to lack of bookmark support, but these do work with the SNA 4.0 Service Pack 4 provider and the provider that shipped with Host Integration Server.

- Example of JOIN between a SQLServer and DB2 table:

    ```sql
    SELECT A.EMPLOYEE_NUMBER,B.ACTNO FROM CORPDATA..EMPLOYEE_ACCOUNT A, WNW3XX.OLYMPIA.WNW3XX.EMP_ACT B WHERE A.EMPLOYEE_NUMBER = B.EMPNO ORDER BY A.EMPLOYEE_NUMBER
    ```
