---
title: Troubleshooting SSIS packages that don't run
description: This article helps you resolve errors that occur when you try to run SSIS packages by using SQL Server Agent.
ms.date: 03/01/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Connectivity issues occur when SQL agent SSIS packages don't run

This article provides a resolution to a connectivity issue in which SQL Server Integration Services (SSIS) packages that use an SQL agent don't run.

## Symptoms

When you try to run SSIS packages that use an SQL agent, the packages don't run, and you receive the following error messages:

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
1. Select the connection that is experiencing the issue.
1. Change the value of the **RetainSameConnection** property from **False** to **True**.
1. Select **OK** to save your changes.

> [!NOTE]
> You can also adjust the **RetainSameConnection** property directly in the SSIS package connection manager properties.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
