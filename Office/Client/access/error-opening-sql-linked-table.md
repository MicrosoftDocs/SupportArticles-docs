---
title: Error (ODBC--call failed) when you open a table that is linked to a SQL Database instance
description: Describes an issue in which you receive an error message while linking a SQL Database instance table by using ODBC. The issue occurs when you open the linked table in Access.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 120588
  - CSSTroubleshoot
ms.reviewer: kayokon, daleche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
  - Microsoft Office Access 2000
search.appverid: MET150
ms.date: 05/26/2025
---

# Error (ODBC--call failed) when you open a table that is linked to a SQL Database instance in Access

_Original KB number:_ &nbsp; 2730109

## Symptoms

Consider the following scenario:

- A table has lots of records in a Microsoft Azure SQL Database instance.
- The table is added as a linked table in Microsoft Access.
- You try to open the linked table in Access.

In this scenario, you receive an error message that resembles the following:

> ODBC--call failed: [Microsoft][SQL Server Native Client 11.0]TCP Provider: An existing connection was forcibly closed by the remote host (#10054) [Microsoft][SQL Server Native Client 11.0]Communication link failure (#10054)

> [!NOTE]
> This issue may also occur when you try to open the linked table from other applications that are connected to the SQL Database instance table by using Microsoft Open Database Connectivity (ODBC).

## Workaround

To work around this issue, use one of the following methods:

- Click **Last record** as soon as the table is opened in order to display all records in the linked table in the Datasheet View of Access.
- Do not select all records in the linked table to be displayed. Instead, select only a limited number of records.
