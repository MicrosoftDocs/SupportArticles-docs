---
title: Error message when you select Roles in Server Manager on Windows Server
description: Resolves the Windows Server problem in which selecting Roles in Server Manager generates an error message and Event 1601.
ms.date: 04/28/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, adrianlutai
ms.custom:
- sap:system management components\server manager
- pcy:WinComm User Experience
---
# Error message when you select Roles in Server Manager on Windows Server

This article provides a resolution to the Windows Server problem in which selecting Roles in Server Manager generates an error message.

_Original KB number:_ &nbsp; 971509

## Symptoms

When you install roles in **Server Manager** on a Windows Server computer, your profile doesn't load correctly and you receive an error message. If you select **Error Details**, you see the following message:

> **Server Manager:**  
Unexpected error refreshing Server Manager; cannot open an anonymous level security token. (Exception from HRESULT: 0x80070543)
For more information, see the event log: Diagnostics, Event Viewer, Applications and Services Logs, Microsoft, Windows, Server Manager, Operational.

To see the event details, open Event Viewer and navigate to **Applications and Services Logs\\Microsoft\\Windows\\ServerManager-DeploymentProvider\\Operational** and **Applications and Services Logs\\Microsoft\\Windows\\ServerManager-MultiMachine\\Operational**. You might see the following errors:

```output
Log Name: Microsoft-Windows-ServerManager-DeploymentProvider/Operational
Source: Microsoft-Windows-ServerManager-DeploymentProvider
Date: MM/DD/YYYY hr:min:sec PM
Event ID: 403
Task Category: GetAlterationState method call.
Level: Error
Keywords:
User: XXXXXXXXXXXX
Computer: XXXXXX.XXXXX
Description: GetAlterationState method returned Failed. Error: The request to add or remove features on the specified server failed. Installation of one or more roles, role services, or features failed. Cannot open an anonymous level security token. Error: 0x80070543
```

```output
Log Name: Microsoft-Windows-ServerManager-DeploymentProvider/Operational
Source: Microsoft-Windows-ServerManager-DeploymentProvider
Date: MM/DD/YYYY hr:min:sec PM
Event ID: 1315
Task Category: GetServerComponent request on a separate thread.
Level: Error
Keywords:
User: XXXXXXXXXXXX
Computer: XXXXXX.XXXXX
Description: Exception Detected: Installation of one or more roles, role services, or features failed. Cannot open an anonymous level security token. Error: 0x80070543 ErrorID: DISMAPI_Error__Failed_To_Enable_Updates
```

```output
Log Name: Microsoft-Windows-ServerManager-MultiMachine/Operational
Source: Microsoft-Windows-ServerManager-MultiMachine
Date: MM/DD/YYYY hr:min:sec PM
Event ID: 4002
Task Category: Add-_InternalWindowsRole task.
Level: Error
Keywords:
User: XXXXXXXXXXXX
Computer: XXXXXX.XXXXX
Description: Add-_InternalWindowsRole workflow reported an error installing or removing the requested component(s), TargetComputer:, RequestState:2, RebootRequired: false, ErrorMessage: The request to add or remove features on the specified server failed. Installation of one or more roles, role services, or features failed. Cannot open an anonymous level security token. Error: 0x80070543 , ErrorId: DISMAPI_Error__Failed_To_Enable_Updates, ErrorCategory: 7, Warning:
```

## Cause

This problem may occur if the Component-Based Servicing subsystem is corrupted in the Windows operating system. This corruption may result from incorrect permissions that are set by users or the administrator.

## Resolution

To resolve this problem, follow these steps:

1. Click **Start**, click **Run**, type *dcomcnfg.exe*, and then click **OK**.
2. If you receive the **User Account Control** prompt, click **OK**.
3. In the console tree, expand **Component Services**, and then expand **Computers**.
4. Right-click **My Computer**, and then click **Properties**.
5. Click **Default Properties**, and then in the **Default Authentication Level** list, click **Connect**.

    > [!Note]
    > If the **Default Authentication Level** item is not set to **None**, do not change it. It may have been set by an administrator.

6. In the **Default Impersonation Level** list, click **Identify**.
7. Click **OK**, and then click **Yes** to confirm the selection.
8. Close the Component Services console.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.
