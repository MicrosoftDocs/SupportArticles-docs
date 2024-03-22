---
title: Error message when you select Roles in Server Manager on Windows Server
description: Resolves the Windows Server problem in which selecting Roles in Server Manager generates an error message and Event 1601.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:server-manager, csstroubleshoot
---
# Error message when you select Roles in Server Manager on Windows Server

This article provides a resolution to the Windows Server problem in which selecting Roles in Server Manager generates an error message and event 1601.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 971509

## Symptoms

When you click **Roles** in **Server Manager** on a Windows Server computer, your profile doesn't load correctly and you receive an error message. If you select **Error Details**, you see the following message:

> **Server Manager:**  
Unexpected error refreshing Server Manager; cannot open an anonymous level security token. (Exception from HRESULT: 0x00070543)
For more information, see the event log: Diagnostics, Event Viewer, Applications and Services Logs, Microsoft, Windows, Server Manager, Operational.

To see the event details, open Event Viewer and navigate to **Applications and Services Logs\\Microsoft\\Windows\\Server Manager\\Operational**. Look for Event 1601. This entry provides the following information:

> Log Name: Microsoft-Windows-Server Manager/Operational  
Source: Microsoft-Windows-ServerManager  
Date: MM/DD/YYYY hr:min:sec PM  
Event ID: 1601  
Task Category: None  
Level: Error  
Keywords:  
User: XXXXXXXXXXXX  
Computer: XXXXXX.XXXXX  
Description:  
Could not discover the state of the system. An unexpected exception was found: System.Runtime.InteropServices.COMException (0x80070543): Cannot open an anonymous level security token. (Exception from HRESULT: 0x80070543) at System.Runtime.InteropServices.Marshal.ThrowExceptionForHRInternal(Int32 errorCode, IntPtr errorInfo) at Microsoft.Windows.ServerManager.ComponentInstaller.CreateSessionAndPackage(IntPtr& session, IntPtr& package) at Microsoft.Windows.ServerManager.ComponentInstaller.InitializeUpdateInfo() at Microsoft.Windows.ServerManager.ComponentInstaller.Initialize() at Microsoft.Windows.ServerManager.Common.Provider.Initialize(DocumentCollection documents) at Microsoft.Windows.ServerManager.ServerManagerModel.InternalRefreshModelResult(Object state)

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
