---
title: Troubleshooting SSIS packages
description: This article helps you to resolve issues that might occur when you execute SSIS packages using SQL Server Agent.
ms.date: 02/09/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# SQL Server faces connectivity issue when SSIS packages run by SQL agent fail to execute

This article provides a resolution to an authentication issue where SQL Server Integration Services (SSIS) packages run by an SQL agent fails to execute.

## Symptoms

The following error messages are generated:

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Protocol error in TDS stream".

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Communication link failure".

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "TCP Provider: An existing connection was forcibly closed by the remote host".

## Cause

When you run an SSIS package through SQL Server Agent, the package might fail to execute. This might lead to connectivity issues.

## Resolution

To resolve this issue, follow these steps:

1. Go to your SQL Server Agent job that runs the SSIS package.
1. In the **Job Step Properties**, navigate to **Configuration** > **Connection Managers**.
1. Change the **RetainSameConnection** property from **False** to **True**. You can do this in the SSIS package under connection manager properties as well.
