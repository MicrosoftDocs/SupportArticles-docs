---
title: SQL Server isn't supported on a Windows operating system on which case sensitivity is enabled
description: This article describes the issue on Windows OS where case sensitivity is enabled.
ms.date: 05/06/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall
ms.reviewer: v-jayaramanp 
ms.topic: troubleshooting 
---


# SQL Server isn't supported on a Windows operating system on which case sensitivity is enabled

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 2860895

You can disable or enable Windows kernel case insensitivity by using the following registry key:

Path: `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel`  
Value name: `obcaseinsensitive`  
Value type: `DWORD`

SQL Server relies on the Windows default value of 1 (one) for this key.

> [!NOTE]
> As soon as this key is set to 0 (zero) on a system on which SQL Server is installed, the operation of setting the key back to 1 (one) isn't a tested scenario for SQL Server. Additionally, this behavior isn't supported. Therefore, we recommend a clean reinstallation of SQL Server on a server on which this key has never been changed.

For more information, see [How to configure case sensitivity for file and folder names](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc725747(v=ws.11)).
