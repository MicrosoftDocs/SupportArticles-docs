---
title: Troubleshooting SSIS packages run by SQL agent fails to execute
description: Troubleshoots connectivity issue when SSIS packages run by SQL agent fail to execute.
ms.date: 12/13/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# SSIS packages run by SQL agent fail to execute

When you run an SSIS package through SQL Server Agent, the package might fail to execute. This might lead to connectivity issues.

## Symptoms

The following error messages are generated:

> "An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Protocol error in TDS stream"."

> "An OLE DB record is available. Source “Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Communication link failure"."

> "An OLE DB record is available. Source “Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "TCP Provider: An existing connection was forcibly closed by the remote host"."

## Resolution

Change the **RetainSameConnection** property from **False** to **True**. You can do this both in the SSIS package under connection manager properties and in the job step properties (Configuration > Connection Managers).
