---
title: Troubleshooting SSIS packages that fail to execute
description: This article helps you to resolve failures that might occur when you execute SSIS packages using SQL Server Agent.
ms.date: 02/26/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# SQL Server faces connectivity issue when SSIS packages run by SQL agent fail to execute

This article provides a resolution to a connectivity issue where SQL Server Integration Services (SSIS) packages fail to execute using an SQL agent.

## Symptoms

The following error messages are generated:

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Protocol error in TDS stream".

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Communication link failure".

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "TCP Provider: An existing connection was forcibly closed by the remote host".

## Cause

When you run an SSIS package through SQL Server Agent, the package might fail to execute. This might lead to connectivity issues.

## Resolution

To resolve this issue, follow these steps:

1. Open **SQL Server Management Studio (SSMS)** and connect to your SQL Server instance.
1. Navigate to SQL Server Agent in the **Object Explorer**.
1. Locate your SSIS job that runs the package.
1. Right-click on the job and select **Properties**.
1. In the **Steps** section, find the step that executes your SSIS package.
1. Click on the **Edit** button to open the **Job Step Properties**.
1. In the **Job Step Properties**, navigate to **Configuration** > **Connection Managers**.
1. Select the connection that has the issue.
1. Change the **RetainSameConnection** property from **False** to **True**.
1. Click **OK** to save your changes.

    You can adjust the **RetainSameConnection** property directly in the SSIS package connection manager properties as well.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
