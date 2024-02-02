---
title: Outdated cached credentials are used when you run an elevated task
description: Helps to resolve the issue in which the outdated cached credentials are used when you run an elevated task.
ms.date: 12/19/2022
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, v-lianna
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Outdated cached credentials are used when you run an elevated task

This article helps to resolve the issue in which outdated cached credentials are used when you run an elevated task.

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

You log on to a Windows computer using a non-administrator account and run an elevated task by selecting the **Run as Administrator** option. Then, you are prompted for an administrator credential, and you enter an administrator account credential to continue the operation.

> [!NOTE]
> When you use an administrator account for the first time on the computer, the administrator group membership and password are cached locally on the computer.

When you run an elevated task by selecting the **Run as Administrator** option again, you're still prompted for an administrator credential.

## The cached credentials aren't updated

The cached credentials aren't updated when you run an elevated task. The cached credentials aren't updated on the computer even when the group membership for the administrator account is changed in the domain environment. Therefore, the cached group membership is used on the computer.

## Create a registry entry for authenticating the user credentials at a domain controller first

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To resolve this issue, you can create a registry entry for authenticating the user credentials at a domain controller first by using the following steps:

1. Select the Windows logo key+<kbd>R</kbd> and type *regedit* in the **Run** dialog box, and then press Enter.

    > [!NOTE]
    > If you're prompted for an administrator password, provide the password. If you're prompted for a confirmation, provide the confirmation.

2. Locate and select the registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`
3. On the **Edit** menu, point to **New**, and then select **DWORD (32-bit) Value**.
4. Type *InteractiveLogonFirst* and press Enter.
5. Right-click **InteractiveLogonFirst** and select **Modify**.
6. Type *1* in the **Value data** box and select **OK**.
7. Exit Registry Editor.

> [!NOTE]
> When the value of the **InteractiveLogonFirst** registry entry is set to **1**, the domain controller verification is required when you run an elevated task. If the domain controller isn't available, the system uses the cached credentials internally.
