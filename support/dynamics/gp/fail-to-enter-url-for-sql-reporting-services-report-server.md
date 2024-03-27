---
title: Error when you enter URL for SQL Reporting Services report server or report manager server
description: Discusses an issue that occurs when you try to enter the URL for the report server or for the report manager server in SQL Reporting Services. You receive an error message.
ms.topic: troubleshooting
ms.reviewer: theley, jayneb, kyouells
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Error in Microsoft Dynamics GP when you try to enter the URL for the SQL Reporting Services report server or report manager server: "The target server location entered is not valid"

This article provides a solution to an error that occurs when you enter the URL for the SQL Reporting Services report server or report manager server.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 913340

## Symptoms

In Microsoft Dynamics GP, when you try to enter the URL for the SQL Reporting Services report server or report manager server, you receive the following error message:

> The Target server location entered is not valid

## Cause

This issue occurs because you did not enter the correct path.

## Resolution

To resolve this issue, follow these steps:

1. Start Microsoft Dynamics GP as a user who has access to the **System** menu.

2. If you are using Microsoft Dynamics GP 9.0, click the **Tools** menu, click **Setup**, click
 **System**, and then click **SQL Reporting Services**. If you are using Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, click **Microsoft Dynamics GP**, click **Tools**, click **Setup**, click **System** and then click **Reporting Tools Setup**.

3. In the **Report Server URL** box, type the following URL for your version of SQL Server. Replace
 **ServerName** with the name of the server that is running Microsoft SQL Server. Replace **PortNumber** with the port number for the Web site that houses SQL Server Reporting Services.

    - For SQL Server 2005

        `http://ServerName:PortNumber/reportserver/reportservice.asmx`

    - For SQL Server 2008

        `http://ServerName:PortNumber/reportserver/reportservice2005.asmx`

4. In the **Report Manager URL** box, type the following URL. Replace **ServerName** with the name of the server that is running Microsoft SQL Server. Replace **ReportsFolder** with the name of the folder where the reports are located. Replace **PortNumber** with the port number for the Web site that houses SQL Server Reporting Services.

    `http://ServerName:PortNumber/Reports/Pages/Folder.aspx`

> [!NOTE]
> You can test the URL addresses that you entered in steps 3 and 4 in Microsoft Internet Explorer.
