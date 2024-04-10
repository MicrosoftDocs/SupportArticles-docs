---
title: Automatically Detect Settings is enabled
description: The Automatically Detect Settings option is unexpectedly enabled as soon as the user launches Internet Explorer 9 for the first time.
ms.date: 04/21/2020
ms.reviewer: joelba
---
# Automatically Detect Settings is unexpectedly enabled at first login in Internet Explorer 9

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides information about resolving the issue that the **Automatically detect settings** option is enabled unexpectedly when a user signs in to Internet Explorer 9 for the first time.

_Original product version:_ &nbsp; Internet Explorer 9  
_Original KB number:_ &nbsp; 2587595

## Symptoms

The **Automatically detect settings** option found on the **Internet Explorer** > **Internet options** > **Connections** > **LAN Settings** is enabled even though the Internet Explorer Maintenance group policy is configured to disable the feature.

This behavior occurs typically for users who sign in to the target computer for the first time, and can also occur for users who are creating a new user profile on the target computer.

## Cause

This behavior is by design. By default, the **Automatically detect settings** option is enabled for Internet Explorer.

When the user profile is first created, the Internet Explorer connection settings will not be considered to be fully configured until the browser is first opened by the user. Before that interactive process can occur, the Windows Group Policy subsystem will apply the appropriate policy and customization settings before the user is permitted to interact with the desktop environment.

Once the user has the ability to interact with the desktop, the default Internet Explorer customizations will have occurred as well as any customizations implemented by the Internet Explorer Administration Kit (IEAK). As soon as the user launches Internet Explorer for the first time, a connection setting migration procedure takes place.

As part of this setting migration, connection customizations such as the state of the **Automatically detect settings**, **Use an automatic configuration script**, **Use a proxy server**, and applicable Dial-Up values will be reconciled with any available connections defined on the **Internet Explorer Connections** tab. One step in this migration process involves the explicit enabling of the **Automatically detect settings** option for the default connection so that the value will be copied to any additional dial-up connection entries that may be present.

This migration procedure is controlled by the state of the `MigrateProxy` DWORD value found under:  
`HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings`

By default, the value is **0**, which indicates that the procedure has not yet been executed. The value will be changed to **1** when the procedure completes.

> [!NOTE]
> The application of an Internet Explorer Maintenance connection settings group policy will not affect the state of this procedure.

## Resolution

The recommended solution is to reapply the policy settings by either performing a `GPUPDATE` or `FORCE` command as the user or by logging off and logging back on to the target computer.

If the user profile is configured for deletion upon signing out, it may be necessary to deploy a custom group policy or user login script to redefine the `MigrateProxy` value from **0** to **1** and bypass the migration process entirely.

> [!NOTE]
> If this migration process is prevented, the default LAN connection settings may not be replicated as expected to the existing dial-up or VPN entries listed on the **Internet Explorer Connections** tab.
