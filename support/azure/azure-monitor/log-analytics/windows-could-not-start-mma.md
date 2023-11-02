---
title: Resolve Microsoft Monitoring Agent startup failure
description: Troubleshoot the error message "The Microsoft Monitoring Agent service terminated with service-specific error Access is denied."
ms.date: 01/31/2022
ms.reviewer: irfanr, v-leedennis
editor: v-jsitser
ms.service: azure-monitor
ms.subservice: logs-troubleshoot
keywords:
#Customer intent: As an Azure Log Analytics user, I want to make sure that the Microsoft Monitoring Agent can start on my Windows-based computer so that I can monitor computers, services, or applications at scale.
---
# Windows can't start Microsoft Monitoring Agent

This article helps you troubleshoot a scenario in which Windows doesn't start Microsoft Monitoring Agent (the Log Analytics agent for Windows) on your local computer. When this problem occurs, you receive a "The Microsoft Monitoring Agent service terminated with service-specific error Access is denied" error message.

## Prerequisites

- The [Process Monitor](/sysinternals/downloads/procmon) tool

## Symptoms

When you open the Services snap-in (*services.msc*) to try to start the **Microsoft Monitoring Agent** service, a dialog box appears and displays the following error message:

> Windows could not start the Microsoft Monitoring Agent on Local Computer. For more information, review the System Event Log. If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code&nbsp;5.

In the Event Viewer snap-in (*eventvwr.msc*), the corresponding system event log shows an "Access is denied" error entry:

```output
Log Name:      System
Source:        Service Control Manager
Date:          8/19/2021 3:03:27 PM
Event ID:      7024
Task Category: None
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      ContosoServer2k8R2
Description:
The Microsoft Monitoring Agent service terminated with service-specific error Access is denied.
```

## Cause

The registry is denying read/write access from the Microsoft Monitoring Agent to the **SecureStorageManager** parameter. To verify this scenario, follow these steps after the "Access is denied" error message appears:

1. Open Process Monitor.
1. Look for an entry that has the following values:

    | Column | Value |
    | ------ | ----- |
    | Process Name | *HealthService.exe* |
    | Operation | RegOpenKey |
    | Path | **HKLM\SYSTEM\CurrentControlSet\Services\HealthService\Parameters\SecureStorageManager** |
    | Result | ACCESS DENIED |
    | Detail | Desired Access: Read/Write |

1. Select **Start**, enter *regedit*, and then select **Registry Editor**.
1. In Registry Editor, select the **View** menu. If there is no check mark next to **Address Bar**, select that menu item.
1. On the address bar (below the menu and above the navigation pane), delete the existing text, enter **HKLM\SYSTEM\CurrentControlSet\Services\HealthService\Parameters\SecureStorageManager**, and then press Enter.
1. On the menu, select **Edit** > **Permissions**.
1. In the **Permissions for SecureStorageManager** dialog box, make sure that the **Group or user names** box has entries for **SYSTEM** and **Administrators (*\<ComputerName>*)**. For each of those entries, examine the **Full Control** row in the **Permissions for *\<GroupOrUserName>*** box to see whether the **Allow** column is selected.

Is full control not explicitly allowed for the system user or the administrator group? If it is, then someone changed the default permissions. Because of this change, Microsoft Monitoring Agent no longer has permission to access the **SecureStorageManager** parameter.

The default permissions can be changed if the following conditions are true:

- The server is hardened.

- A user, application, or script modifies the default permissions to less than the Read/Write level within the registry.

## Solution

Restore full control to the **SecureStorageManager** parameter for the system user and the administrators. To do this, follow these steps:

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

1. (Recommended) [Back up the registry](../../../windows-server/performance/windows-registry-advanced-users.md#back-up-the-registry).

1. Return to or reopen the Registry Editor.

1. In the address bar, reenter the registry path for the **SecureStorageManager** parameter (**HKLM\SYSTEM\CurrentControlSet\Services\HealthService\Parameters\SecureStorageManager**), and then press Enter.

1. Select **Edit** > **Permissions**, and then reapply the default permission in **Full Control** (**Allow**) for the **SYSTEM** user and the **Administrators (*\<ComputerName>*)** group.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
