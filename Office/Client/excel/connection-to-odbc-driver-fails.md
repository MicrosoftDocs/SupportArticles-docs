---
title: Connection to ODBC driver fails in PowerPivot for Excel
description: Resolve an issue in which you receive Login failed for user and Invalid connection string attribute error messages when you create a connection an ODBC driver in PowerPivot for Excel 2010 or Excel 2013.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: haidongh, lauraho
search.appverid: 
  - MET150
appliesto: 
  - Excel 2010
  - Excel 2013
ms.date: 03/31/2022
---

# Connection to ODBC driver fails in PowerPivot for Excel 2010 or PowerPivot for Excel 2013

## Symptoms

Assume that you try to connect to a database by using Microsoft OLE DB Provider for ODBC Drivers in the PowerPivot for Microsoft Excel 2010 or PowerPivot for Microsoft Excel 2013 add-in. You create the connection string by using the Table Import Wizard. The connection test is successful. However, when you click **Next**, you receive the following error message:

```adoc
Failed to connect to the server. Reason: ERROR [28000] [Microsoft][ODBC SQL Server Driver][SQL Server]Login failed for user ''.
ERROR [01S00] [Microsoft][ODBC SQL Server Driver]Invalid connection string attribute
ERROR [28000] [Microsoft][ODBC SQL Server Driver][SQL Server]Login failed for user ''.
ERROR [01S00] [Microsoft][ODBC SQL Server Driver]Invalid connection string attribute
```

The following is a sample of the connection string that you created:

```adoc
Provider=MSDASQL.1;Persist Security Info=True;User ID=sa;Initial Catalog=test;DSN=MSSQL 2012;Password=**********
```

## Cause

This issue occurs because the Extended Properties information is not contained in the ODBC connection string. The following is a sample of the correct connection string:

```adoc
Provider=MSDASQL;Persist Security Info=True;User ID=sa;Extended Properties="DSN=MSSQL 2012;UID=sa;APP=Microsoft Office 2013;WSID=GENLI-T430;DATABASE=test;Pwd=**********";Initial Catalog=test;Password=**********
```

## Resolution

To create a correct connection string, select the **Use connection string** option when you create the connection string:

1. In the **Table Import Wizard**, click **Build**.   
2. In the **Provider** tab, make sure that you select Microsoft OLE DB Provider for ODBC Drivers.   
3. In the **Connection** tab, select the **Use connection string** option, and then click **Build**.

   :::image type="content" source="media/connection-to-odbc-driver-fails/type-connection-string.png" alt-text="Screenshot to select the Build option after selecting the Use connection string option." border="false":::
4. Click the **Machine Data Source** tab, select your database resource, and then click **OK**.   
5. When you receive the Database logon prompt, type the logon ID and password, and then click **OK**.    
6. In the **Enter information to log on to the server** box, type in the logon ID and password again, and then select the **Allow saving password** option.   
7. Click **OK**. A correct connection string is generated.    
