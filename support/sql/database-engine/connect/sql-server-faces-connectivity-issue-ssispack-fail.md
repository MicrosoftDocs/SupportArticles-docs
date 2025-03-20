---
title: Error 0x80004005 When an SSIS Package Fails to Run as a SQL Agent Job
description: This article helps you resolve the 0x80004005 error that might arise when you try to run SSIS packages by using the SQL Server Agent.
ms.date: 03/11/2025
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
---

# Connectivity error 0x80004005 occurs when you run an SSIS package as a SQL Agent job

This article provides a solution to a connectivity issue in which SQL Server Integration Services (SSIS) packages that use SQL Server Agent fail to run.

## Symptoms

When you try to run an SSIS package as a SQL Server Agent job, the package doesn't run, and you receive the following error messages:

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Protocol error in TDS stream".

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Communication link failure".

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "TCP Provider: An existing connection was forcibly closed by the remote host".

## Resolution

To resolve this issue, follow these steps:

1. Open **SQL Server Management Studio (SSMS)**, and then connect to your SQL Server instance.
1. In the **Object Explorer**, navigate to **SQL Server Agent**.
1. Locate your SSIS job that runs the package.
1. Right-click the job, and then select **Properties**.
1. In the **Steps** section, find the step that runs your SSIS package.
1. Select the **Edit** button to open the **Job Step Properties**.
1. In the **Job Step Properties** dialog box, navigate to **Configuration** > **Connection Managers**.
1. Select the connection that's experiencing the issue.
1. Change the value of the **RetainSameConnection** property from **False** to **True**.
1. Select **OK** to save your changes.

> [!NOTE]
> You can also adjust the **RetainSameConnection** property directly in the SSIS package connection manager properties.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
