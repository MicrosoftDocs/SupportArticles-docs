---
title: Error 2711 when install RBS client for SQL server
description: Discusses an issue in which you receive error 2711 when installing the RBS client for SQL server 2016 with SharePoint 2016. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CI 109532
  - CSSTroubleshoot
ms.reviewer: clake
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# Error 2711 when installing RBS client for SQL server 2016 with SharePoint Server 2016

## Symptoms

You receive error 2711 when installing the RBS client for SQL server 2016 with SharePoint Server 2016 by using the following command:

```powershell
msiexec /qn /lvx* rbs_install_log.txt /i RBS_amd64.msi DBNAME="WSS_Content" DBINSTANCE="DBInstanceName" ADDLOCAL=Client,Docs,Maintainer,ServerScript,FilestreamClient,FilestreamServer
```
**Error message:**

```adoc
Product: Microsoft SQL Server 2016 Remote BLOB Store -- Error 2711. The installer has encountered an unexpected error. The error code is 2711. The specified Feature name ('Docs') not found in Feature table.
```

## Cause

Recent SQL RBS client versions are not packaged with the "Documentation" or "Docs" feature, which is an option that allows the installation of supporting text help files for SQL Filestream.

## Resolution

This error can be ignored and the RBS client can be installed by removing the "Docs" feature from the "ADDLOCAL" parameter. For example: 

```powershell
msiexec /qn /lvx* rbs_install_log.txt /i RBS_amd64.msi DBNAME="WSS_Content" DBINSTANCE="DBInstanceName" ADDLOCAL=Client,Maintainer,ServerScript,FilestreamClient,FilestreamServer
```

## More information

[Install the RBS client library on all SharePoint Front-end and Application servers](/SharePoint/administration/install-and-configure-rbs#to-install-the-rbs-client-library-on-all-sharepoint-front-end-and-application-servers)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).