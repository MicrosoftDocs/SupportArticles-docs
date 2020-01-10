---
title: Access data connections are slow to refresh in Excel
description: How to resolve an issue when Access data connections are slow to refresh in Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel
- Access
---

# Access data connections are slow to refresh in Excel

## Symptoms

When you open an Excel file from a file server and that Excel file contains data connections to an Access database which are also stored on a file server, you experience a slow Access data refresh rate. 

## Cause

When the Office Document Cache is utilized for an Excel file, a specialized Access data connection is opened. If the Excel process creates a second Access data connection, such as one that is part of a pivot table refresh, specific properties used with the Office Document Cache connection are also used by the pivot table data connection. The inclusion of these properties results in slower data refresh times for Access databases. 

## Status

Microsoft is researching this problem and will post more information in this article when the information becomes available. 

## More information

The following workarounds might alleviate the refresh time: 

- Move the Excel file to a local hard drive so that the Office Document Cache is not utilized.
- Open the Excel file using a Uniform Naming Convention (UNC) path to the server. For example: \\\Servername\foldername\filename.xlsx.
