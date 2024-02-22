---
title: Error 2250 (NERR_UseNotFound) when LanmanWorkstation service fails to start
description: Describes how to resolve an issue where the LanManWorkstation service doesn't start and Windows generates error 2250.
ms.date: 02/27/2024
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
ms.subservice: networking
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:access to file shares (SMB), csstroubleshoot
keywords: error 2250, service can't start, LanmanWorkstation service
---

# Error 2250 (NERR_UseNotFound) when LanmanWorkstation service fails to start

This article describes how to resolve an issue where the LanManWorkstation service doesn't start and Windows generates error 2250.

_Applies to:_ &nbsp; 

## Symptoms

The LanmanWorkstation service fails to start, and Windows generates the following message:

> Windows could not start the Workstation on Local Computer. For more information, review the System Event Log. If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 2250.

> [!NOTE]  
> This behavior might affect other services in addition to the LanmanWorkstation service.

## Cause

This error typically indicates that the following volatile registry entry is missing:

> Registry subkey: `HKLM\System\CurrentControlSet\Control\ComputerName\ActiveComputerName`
> - Registry type: REG_SZ
> - Registry key: `ComputerName`
> - Value: <*Computer_Name*>

This value should be the same vale as the value of the following non-volatile entry:

> Registry subkey: `HKLM\System\CurrentControlSet\Control\ComputerName\ComputerName`
> - Registry type: REG_SZ
> - Registry key: ComputerName
> - Value: <*Computer_Name*>

> [!NOTE]  
> In both registry entries, <*Computer_Name*> represents the name of the local computer.

## Resolution

[!INCLUDE [registry](../../includes/registry-important-alert.md)]

You can resolve this issue by creating the  registry entry on the affected computer. You can use Registry Editor to manually create the registry entry. or you can open an administrative Command Prompt window and then run the following command:

```console
reg add HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /t REG_SZ /v ComputerName /d <Computer_Name> /f
```

> [!NOTE]  
> In this command, <Computer_Name> represents the name of the local computer.

After you edit the registry, restart the computer.
