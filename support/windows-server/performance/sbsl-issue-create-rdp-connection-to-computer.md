---
title: SBSL issue when you create an RDP connection to Windows Server 2012 R2
description: Describes an issue in which computer freezes when you create an RDP connection to Windows Server 2012 R2.
ms.date: 01/17/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, pranayav, amanjain, vineelko
ms.custom: sap:boot-is-slow, csstroubleshoot
ms.subservice: performance
---
# Server freezes or user logon is slow when connecting to Windows Server 2012 R2 by using RDP

This article provides a solution to an issue where a computer freezes or user logon is slow when you connect to the computer by using Remote Desktop Protocol (RDP).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4021856

## Symptoms

When you create a RDP connection to a computer that is running Windows Server 2012 R2, the computer freezes.

In other cases, you may see the new user logons are slowed down to a degree they appear hung. The delay may also occur before the user enters the credentials.

## Cause

This issue occurs because of a deadlock condition that involves Remote Desktop Services (RDS) (termsrv.dll), lsass (kerberos), and redirector. The deadlock occurs when RDS services try to load the user configuration data by issuing remote registry calls to the domain controller.

When you experience slow or hung logons, RDS service makes calls to API to a domain controller, and the round trips for these induce significant delays. This may occur for the following reasons:

- The network link to the Domain Controller is slow, congested and sees frame loss, and significant time is spent with retries to transfer data.
- The Domain Controller experiences local performance issues and responds to the requests slowly.

## Resolution

There now is an option to turn off the Domain Controller requests during user logon. This avoids the window for the dead-lock, and fixes the performance issues.

In Windows Server 2012 R2, create the **fQueryUserConfigFromLocalMachine** registry entry according to the following steps.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To make the registry change, follow these steps:

1. Start Registry Editor. (Press Windows logo key + R, type *regedit.exe* in the **Open** box, and then click **OK**.)
2. In Registry Editor, locate and then click one of the following registry subkeys:

    - `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Terminal Services`
    - `HKEY _LOCAL_MACHINE\System\CurrentControlSet\Control\Terminal Server\WinStations\<Connection Name>`

    > [!NOTE]
    > By default, the value for \<Connection Name> is RDP-Tcp. This value RDP-Tcp can be renamed or configured to something else.

    :::image type="content" source="media/sbsl-issue-create-rdp-connection-to-computer/configure-rdp-tcp-connection.png" alt-text="Screenshot shows how to configure RDP-Tcp." lightbox="media/sbsl-issue-create-rdp-connection-to-computer/configure-rdp-tcp-connection.png" border="false":::

3. On the **Edit** menu, select **New**, and then select **DWORD Value**.
4. Type *fQueryUserConfigFromLocalMachine*.
5. Press and hold (or right-click **fQueryUserConfigFromLocalMachine**, and then select **Modify**.
6. In the **Value data** box, type *1*, and then select **OK**.
7. Exit Registry Editor.

You can also upgrade to Windows Server 2016 to fix this issue.

> [!NOTE]
> You don't have to update registry keys in Windows Server 2016, the updated behavior is the default.
