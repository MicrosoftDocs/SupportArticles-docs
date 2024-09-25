---
title: Unable to protect a SharePoint farm
description: Trying to protect a SharePoint farm with DPM may result in errors if SQL Server aliasing is used incorrectly.
ms.date: 04/08/2024
ms.reviewer: Mjacquet, wawhit, cbutch
---
# Unable to protect a SharePoint farm with System Center Data Protection Manager

This article helps you resolve an issue where Data Protection Manager (DPM) can't protect a SharePoint farm because of an improperly configured SQL Server alias.

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager, System Center 2012 R2 Data Protection Manager, System Center 2012 Data Protection Manager, System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 2543859

## Summary

When you try to create a protection group in System Center Data Protection Manager, you may receive the following error:

> DPM cannot protect your Windows SharePoint services farm until you install agents on the following server ServerHostName.FQDN.COM ID 956

This error message can be caused by an improperly configured SQL Server alias.

## Configure 64-bit SQL Server alias

1. Start cliconfg.exe from each WFE server in the farm.
2. Navigate to the **Alias** tab.
3. Select **Add...**
4. Enter the name of the alias in the **Server Alias:** window.
5. Enter the fully qualified domain name of the SQL Server in **Server Name:** under **Connection parameters**.
6. Check the radio button for TCP/IP in the **Network Libraries** section.
7. Click **OK**.

## Configure 32-bit SQL Server alias

1. On all WFE servers, open SQL Server Configuration Manager (installation of SQL Server Configuration Manager is required unless it already exists. For SharePoint 2010, install SQL Server 2008 Client Tools Connectivity).
2. From the SQL Server Configuration Manager, expand the **SQL Native Client 10.0 Configuration (32-bit)** and click the **Aliases**.
3. In the right panel, right-click and select **New Alias...**
4. For the **Alias Name**, enter the name of the alias being used.
5. For the **Server**, enter the Fully Qualified Domain Name of the server to which the alias will resolve.

## More information

SQL Server Aliasing allows SharePoint administrators to move SharePoint databases between SQL Servers if the need arises. The administrator can do this by creating a new SQL Server alias on all servers in the farm using cliconfg.exe or SQL Server Configuration Manager.
