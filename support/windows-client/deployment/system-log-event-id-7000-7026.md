---
title: Event ID 7000 or 7026 in System log
description: Describes a problem in which event ID 7000 or event ID 7026 may be logged after you start a computer that's running Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Devices and Drivers
ms.technology: windows-client-deployment
---
# Event ID 7000 or 7026 is logged in the System log on a computer that's running Windows

This article describes a problem in which event ID 7000 or event ID 7026 is logged after you start a computer that's running Windows.

_Original product version:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 933757

## Symptoms

Event ID 7000 or event ID 7026 is logged in the System log on a computer that's running one of the following operating systems:

- Windows 7 Service Pack 1
- Windows Server 2012 R2

This problem may occur if a device isn't connected to the computer but the driver service of the device is enabled.

## Workaround

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around the problem that's described in the example in the [Symptoms](#symptoms) section, disable the Cdrom or Parport service in the registry to stop the errors from being logged.

To do this, change the value of the following registry subkeys to 3 (Manual) or 4 (Disabled)：

- Registry key 1
  - Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cdrom`
  - Name: Start
  - Type: REG_DWORD
  - Data: 3 or 4

- Registry key 2
  - Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\parport`
  - Name: Start
  - Type: REG_DWORD
  - Data: 3 or 4

> [!NOTE]
> If the above registry is changed to 4 (Disabled), the related device isn't usable because a driver used in the device isn't loaded. So if the device will be used in the future, the above registry should be set as 3 (Manual).
