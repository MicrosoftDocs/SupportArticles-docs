---
title: Welcome screen is displayed for 30 seconds
description: Describes an issue that occurs because the logon process runs in session 0. However, the logon script process runs in a different session. Provides a resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-profiles, csstroubleshoot
---
# The Welcome screen may be displayed for 30 seconds, and the logon script interacts with me when I try to log on to a computer that is running Windows Vista or Windows Server 2008

This article provides a solution to an issue where the Welcome screen may be displayed for 30 seconds when you log on.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 940452

## Problem description

On a computer that is running Windows Vista or Windows Server 2008, you enabled the "Run logon scripts synchronously" Group Policy. When you tried to log on, the Welcome screen was displayed for 30 seconds. Then, the logon script interacted with you before the logon script process was completed. For example, the script prompted you to confirm a dialog box.

This issue occurs because the logon process runs in session 0. However, the logon script process runs in a different session. A 30-second delay occurs before Windows Vista switches from session 0 to another session. When the logon script interacts with you before the logon script process is complete, you have to wait for the 30-second time-out interval of session 0. To fix this problem, change the time-out interval to less than 30 seconds.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
 [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this issue, configure the value of the DelayedDesktopSwitchTimeout registry entry. This value determines the time-out interval of a session before Windows Vista switches between sessions.

To configure the value of the DelayedDesktopSwitchTimeout registry entry, follow these steps  

1. Click **Start**, type regedit in the **Start Search** box, and then press ENTER.
2. Locate the following registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`.
3. Double-click the **DelayedDesktopSwitchTimeout** registry entry.
4. In the **Value data** box, type 5, and then click **OK**.
5. On the **File** menu, click **Exit**.

## Steps to reproduce the problem

> [!NOTE]
> The "Run logon scripts synchronously" Group Policy setting is in the following location in the Group Policy Management Console:Local Computer Policy\User Configuration\Administrative Templates\System\Script.

1. Enable the "Run logon scripts synchronously" Group Policy in the Group Policy Management Console. To do this, follow these steps:  

    1. Click **Start**, type gpedit.msc in the **Start Search** box, and then click **gpedit.msc** in the **Programs** list.

        If you are prompted for an administrator password or for confirmation, type the password, or click **Continue**.  
    2. In the **Group Policy Object Editor** window, expand **User Configuration**, expand **Administrative Templates**, expand **System**, and then click **Scripts**.
    3. In the details pane, double-click **Run logon scripts synchronously**.
    4. On the **Setting** tab, click **Enabled**, and then click **OK**.  
2. Create a logon script, and then assign the logon script to the local user.

    > [!NOTE]
    > The logon script must interact with the user.
3. Log on to the computer that is running Windows Vista or Windows Server 2008.
