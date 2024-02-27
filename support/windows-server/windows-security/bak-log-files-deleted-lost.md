---
title: How to retain .bak files for AD logs
description: Introduces a PowerShell script to retain .bak files. This script monitors .bak files at regular time intervals and renames them with a current timestamp.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom: sap:permissions-access-control-and-auditing, csstroubleshoot
---
# .bak log files are deleted and lost

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

Assume that you're using the options of the following components to get text-based log files (`.log` files).

- Security Account Manager component (*sam.log*)
- Netlogon service (*netlogon.log*)
- Group Policy Client service (*gpsvc.log*)
- SID-Name mapping (*lsp.log*)

When log files reach a certain size, they're renamed as `.bak` files and old `.bak` files are deleted and replaced. In this case, the log entries of the old `.bak` files are lost. You may need to retain the log entries for a longer interval.

## PowerShell script to retain .bak files

To retain the old `.bak` files, use a PowerShell [script](https://cesdiagtools.blob.core.windows.net/windows/AD_save-LSP-GPSVC-Netlogon-logs.zip), which is signed with a Microsoft end-user license agreement. This script monitors `.bak` files at regular time intervals (30 seconds) and renames them with a current timestamp in the same folder as the active logs.

> [!NOTE]
> If you run this script on a regular basis, archive the logs to prevent an overuse of hard disk space.
