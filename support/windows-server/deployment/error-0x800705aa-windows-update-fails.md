---
title: Windows Update fails with error 0x800705aa
description: Helps resolve an issue in which Windows Update fails with error 0x800705aa.
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.date: 11/23/2023
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, maeltedebay, v-lianna
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot, ikb2lmc
---
# Error 0x800705aa when Windows Update fails

This article helps resolve an issue in which Windows Update fails with error 0x800705aa.

Windows Cumulative Updates (CUs) can't be installed, or the system shows a notification that updates are missing. 
 
You can also find the following error by searching "Failed to load the COMPONENTS hive" in *CBS.log* (*C:\\Windows\\Logs\\CBS*): 
 
> Info CBS Failed to load the COMPONENTS hive from 'C:\Windows\System32\config\COMPONENTS' into registry key 'HKLM\COMPONENTS'. [HRESULT = 0x800705aa - ERROR_NO_SYSTEM_RESOURCES]

When you check the `RegistrySizeLimit` registry value in `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`, you find that the value is set to a value other than **0**.

## Insufficient resource prevents the system from extending the COMPONENTS hive
 
The value of the `RegistrySizeLimit` registry key specifies the maximum size of the registry in megabytes. When the registry reaches this size, Windows stops adding new keys and values to the registry. That means the system won't perform Windows servicing activities such as CU installation. 
 
## Delete the RegistrySizeLimit setting 
 
Open the Registry Editor as an administrator, and go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`. Then, delete the `RegistrySizeLimit` registry key or set it to **0**, and restart the system.

> [!NOTE]
> This allows the operating system to automatically set the registry size as needed. We recommend deleting the registry key unless it's specifically required.
