---
title: Supportability about SQL collation for SharePoint databases
description: Describes the Supportability regarding SQL Server collation for SharePoint databases and TempDB.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Other
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Services 3.0
search.appverid: MET150
ms.date: 12/17/2023
---
# Supportability regarding SQL Server collation for SharePoint databases and TempDB

_Original KB number:_ &nbsp; 2008668

## Supportability regarding SQL Server collation

The following article talks about the SQL Server collation for the SharePoint databases

[Prepare the database servers (Windows SharePoint Services)](/previous-versions/office/sharepoint-2007-products-and-technologies/cc288970(v=office.12))

*The SQL Server collation must be configured for case-insensitive. The SQL Server database collation must be configured for case-insensitive, accent-sensitive, Kana-sensitive, and width-sensitive. This is to ensure file name uniqueness consistent with the Windows operating system.*

However, we do **not support** changing the default collation (`Latin1_General_CI_AS_KS_WS`) for SharePoint databases to any other collations (CI, AS, KS, WS).

We **support** any CI collation for the SQL Server instance (for master and tempdb databases). However we recommend using `Latin1_General_CI_AS_KS_WS` as the instance default collation (master and tempdb databases).
