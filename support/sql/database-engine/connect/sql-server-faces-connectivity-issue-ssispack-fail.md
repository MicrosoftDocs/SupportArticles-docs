---
title: Troubleshooting SSIS packages
description: This article helps you to resolve issues That might occur when you execute SSIS packages using SQL Server agent.
ms.date: 01/03/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# SSIS packages run by SQL agent fail to execute

When you run an SSIS package through SQL Server Agent, the package might fail to execute. This might lead to connectivity issues.

## Symptoms

The following error messages are generated:

> An OLE DB record is available. Source "Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Protocol error in TDS stream".

> An OLE DB record is available. Source “Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "Communication link failure".

> An OLE DB record is available. Source “Microsoft OLE DB Driver for SQL Server" Hresult. 0x80004005 Description "TCP Provider: An existing connection was forcibly closed by the remote host".

## Resolution

Change the **RetainSameConnection** property from **False** to **True**. You can do this both in the SSIS package under connection manager properties and in the job step properties (**Configuration > Connection Managers**).
