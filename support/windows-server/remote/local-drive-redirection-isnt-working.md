---
title: Local drive redirection isn't working
description: Provides a solution to an issue where local drive redirection isn't working in RDP Session.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Local drive redirection isn't working in RDP Session

This article provides a solution to an issue where local drive redirection isn't working in RDP Session.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 2436104

## Symptoms

You may notice the following symptoms when connecting via Remote Desktop Protocol (RDP) to a Windows Server 2003 or Windows Server 2003 R2 Terminal Server:

1. Local drives aren't redirected in the RDP Session.
2. Other devices and resources may be properly redirected.
3. There are no events in the Event Viewer pertaining to the failure to redirect drives.

Things to Check:

1. On the Server: **Terminal Services Configuration** - **Connections** - **RDP-Tcp** - **Properties** - **Client Settings**: Make sure **Drive Mapping** option is unchecked under **Disable the Following**.

2. On the Server: **Terminal Services Configuration** - **Connections** - **RDP-Tcp** - **Properties** - **Client Settings**: Under Connections - Connect Client Drives at logon  is selected.

3. On the client Machine: **Start** - **Run** - **MSTSC** - **Options** - **Local Resource** - Make sure **Disk Drives** is selected.

4. Check Resultant Set of Policy on the machine: Terminal Services Group Policies, under `Computer Configuration\Administrative Templates\Windows Components\Terminal Services\Client/Server` data redirection - Don't allow drive redirection: shouldn't be enabled.

## Cause

Network Providers value for RDP might be missing in the registry.

## Resolution

Make sure the Network Providers entry has at least the default entries:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\NetworkProvider\Order - ProviderOrder -`

Default entries: RDPNP, LanmanWorkstation, web client

## More information

No reboot is required after making these changes.
