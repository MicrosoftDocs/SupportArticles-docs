---
title: Memory leak when Access connects to database files
description: Describes a memory leak that affects the Access database engine when an application connects to Access database files. A workaround is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: a-kyoy
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
ms.date: 03/31/2022
---

# Memory leak when Access continually connects to database files

## Symptom

When Microsoft Access (MsAccess.exe) or a custom solution continually connects to Access database files (.mdb or .accdb) through the Access ODBC driver and the OLE DB provider (Microsoft.ACE.OLEDB.12.0), the memory usage of the Access database engine keeps increasing until the process is completed.

## Cause

This issue occurs because the Access database engine continuously allocates memory to run insert, update, and delete records in the Access database files. The Access database engine isn't intended for use with high-stress, high-concurrency, 24-hour-a-day, or seven-day-a-week server applications.

## Workaround

To work around this issue, regularly restart the applications or the computer.
