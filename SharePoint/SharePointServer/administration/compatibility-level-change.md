---
title: Change the compatibility level of content databases for migration
description: When you migrate a content database from a SharePoint farm to another one, the compatibility level of the content database may be lower than the level of the destination SQL Server instance.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Setup, Upgrade, Migration and Patching
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Change the compatibility level of content databases for migration

When you migrate a content database from a SharePoint farm to another one, the compatibility level of the content database may be lower than the level of the destination SQL Server instance, because different SharePoint farms may use different versions of SQL Server. When you restore or attach the content database to the destination SQL Server instance, the SQL Server version may be higher than the original SQL Server instance.

In this case, you can change the compatibility level of the database if the SQL Server version is supported in the SharePoint farm. However, you can't change the compatibility level of the User Profile Application (UPA) databases because it isn't supported.

## Issue you may experience

If there's a large difference between the original SQL Server instance and the destination one, it may take a long time to execute the Mount-SPContentDatabase cmdlet to attach the database.

For example, if the compatibility level of the original content database is 90 (corresponds to SQL Server 2005) while the destination database is 130 (corresponds to SQL Server 2016), the Mount-SPContentDatabase process may take hours to complete. The process may be faster if you change the compatibility level of the original content database to 130.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
