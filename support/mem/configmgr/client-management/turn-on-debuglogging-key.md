---
title: Turn on the DebugLogging key
description: Describes how to turn on the DebugLogging key on Configuration Manager clients and management points.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Client Operations\Other
---
# Turn on the DebugLogging key on Configuration Manager clients and management points

This article describes how to turn on the `DebugLogging` key on Configuration Manager clients and management points.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 833417

## Summary

When you troubleshoot issues on Configuration Manager clients or management points, you can turn on the `DebugLogging` key on the computer where the issue occurs. As a result, the actions of Ccmexec are logged. A log of these actions can help to troubleshoot the issue. `DebugLogging` works the same on the Configuration Manager clients and management points because they use the same Ccmexec framework and process name.

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Description of the Microsoft Windows Registry](https://support.microsoft.com/help/256986).

## Turn on the DebugLogging key

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

To turn on the `DebugLogging` key on the client or management point, follow these steps:

1. Stop the **SMS Agent Host** service.
1. Open Registry Editor, create the following subkey:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CCM\Logging\DebugLogging`

1. Add a new value under this key:
   - Value name: **Enabled**
   - Value: **True**
   - DataType: **REG_SZ**

1. Restart the **SMS Agent Host** service.

> [!NOTE]
> Turn on the `DebugLogging` key only for debugging purposes. Turn it off again when the issue is resolved by changing the value of **Enabled** to **False**.
