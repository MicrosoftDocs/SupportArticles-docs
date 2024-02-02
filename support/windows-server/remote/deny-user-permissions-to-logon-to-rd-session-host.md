---
title: Deny user or group logon via RDP
description: Helps solve an issue where the Deny this user permissions to logon to a Remote Desktop Session Host Server feature behaves differently in different versions of Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:administration, csstroubleshoot
ms.subservice: rds
---
# You notice that the check box "Deny this user permissions to logon to a Remote Desktop Session Host Server" behaves differently in Windows Server 2003 and Windows Server 2008

This article provides help to solve an issue where the **Deny this user permissions to logon to a Remote Desktop Session Host Server** feature behaves differently in different versions of Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2258492

## Symptoms

You may notice that the behavior of the *Deny this user permissions to logon to a Remote Desktop Session Host Server* is different between Windows Server 2003 and Windows Server 2008. In Windows Server 2003, this setting is called *Deny this user permission to logon to any Terminal Server*.

Consider the following setup:

1. Windows 2008 Server member server.

2. Windows Server 2003 member server.

3. Within Active Directory Users and Computers snap-in, choose a user and access the Remote Desktop Services Profile tab. If the domain controller is running Windows Server 2003, this will be called Terminal Services Profile. Here set the '*Deny this user permission to logon to a Remote Desktop Session Host server'* setting. Again, in Windows Server 2003 this is called '*Deny this user permission to logon to any Terminal Server'*.

4. Set this user as a member of either the "Remote Desktop Users" group or the local "Administrators" group under both the Windows Server 2003 and Windows Server 2008 servers.

Now, use this user's credentials to logon to the Windows 2003 member server via RDP, you'll notice that this user will be blocked. However, this user will be able to logon to the Windows Server 2008 server.

## Cause

This behavior is by design. In Windows Server 2003, this setting is checked no matter whether the server is in Remote Administration Terminal Server mode or Application Terminal Server mode. However, in Windows Server 2008 this setting is checked on a machine that has Remote Desktop Services in Application Mode only. Remote Administration mode won't check this parameter. If you change the Windows Server 2008 server to Remote Desktop Services Application Mode by installing the role, this user won't be denied logon via RDP.

## Resolution

To deny a user or a group logon via RDP, explicitly set the "Deny logon through Remote Desktop Services" privilege. To do this, access a group policy editor (either local to the server or from a OU) and set this privilege:

1. Start | Run | Gpedit.msc if editing the local policy or chose the appropriate policy and edit it.

2. Computer Configuration | Windows Settings | Security Settings | Local Policies | User Rights Assignment.

3. Find and double-click "Deny logon through Remote Desktop Services".

4. Add the user and / or the group that you would like to deny access.

5. Select ok.

6. Either run `gpupdate /force /target:computer` or wait for the next policy refresh for this setting to take effect.
