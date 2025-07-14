---
title: Database requires a newer version of Access
description: Describes an error that occurs when you try to open a Microsoft Access database. The error message prompts you to use a newer version of Access. This issue concerns to use of the BigInt data type. A resolution is provided.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
ms.date: 05/26/2025
---

# "Database you are trying to open requires a newer version of Microsoft Access" error in Access

## Symptoms

When you try to open a Microsoft Access database, you receive the following error message:

"The database you are trying to open requires a newer version of Microsoft Access" when opening an Access database."

## Cause

This issue occurs if you try to open a database that contains a table that uses the BigInt data type. BigInt support was added to Access 2016. BigInt appears within the table's data type as **Large Number**.

## Resolution

To resolve this issue, determine whether the use of BigInt is required. If so, update users to Access 2016 version 16.0.**7xxx.xxxx** or later. Alternatively, change the data type from **Large Number** to just **Number**.

> [!NOTE]
> Create a backup of your database before you change the data type. If there is **Large Number** data in a column when you change the data type to **Number**, you receive a "Microsoft Access encountered errors while converting the data" dialog box. If you click **Yes** to proceed, the records that contain large numbers are deleted. 

:::image type="content" source="media/database-requires-newer-access/error-message-dialog.png" alt-text="Screenshot shows Microsoft Access encountered errors while converting the data.":::

## More Information

The use of a **Large Number** data type sets the file format to version 16.7. You can determine a database's file format version by pressing Ctrl-G to open the Immediate window. Type ?Application.CurrentDB.Version in the window, and then press Enter.
