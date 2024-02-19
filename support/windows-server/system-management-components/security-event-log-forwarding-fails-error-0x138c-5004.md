---
title: Security event log forwarding fails with Error 0x138C and 5004 in Windows Server
description: Fixes a problem in which security event logs can't be forwarded in Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nitkum, v-jesits
ms.custom: sap:event-viewer, csstroubleshoot
---
# Security event log forwarding fails with Error 0x138C and 5004 in Windows Server

This article provides a solution to an issue where security event log forwarding fails with Error 0x138C and 5004 in Windows Server.

_Applies to:_ &nbsp; All supported versions of Windows Server  
_Original KB number:_ &nbsp; 4047777

## Symptoms

When you try to forward security event logs in Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008, you receive the following error message on the event collector computer:
> Error "**0x138C**" Windows Event Forward plugin can't read any event from the query since the query returns no active channel.

Also, you receive the following error message on the event source computer:
> The subscriptionSubscriptionNamecannot be created. The error code is **5004**.

## Cause

This problem may occur when the following conditions are true:

- The Network Service account does not have the correct permission when Windows Remote Management (WinRM) tries to query the security logs from the source computer.
- Permissions to manage the security event log are modified by registry or by configuring the [Manage auditing and Security log](/previous-versions/windows/it-pro/windows-2000-server/cc957161(v=technet.10)) that sets the following registry entry on the source computer:

  - Registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Security`
  - Registry entry: CustomSD
  - Value: `O:BAG:SYD:(D;; 0xf0007;;;AN)(D;; 0xf0007;;;BG)(A;; 0xf0007;;;SY)(A;; 0x7;;;BA)(A;; 0x7;;;SO)(A;; 0x3;;;IU)(A;; 0x2;;;BA)(A;; 0x2;;;LS)(A;; 0x2;;;NS)(A;; 0x7;;;DA)(A;; 0x1;;;S-1-5-21-xxx-xxx-xxx-xxx)`

## Resolution

To fix this problem, you need to add the Network Service account to the **Manage auditing and security log** group policy. To do this, follow these steps:

1. Select **Start** > **Administrative Tools** > **Local Security Policy**.
2. On the navigation menu, select **Local Policies** > **User Rights Assignment**.
3. Right-click **Manage auditing and security log**, and then select **Properties**.
4. On the **Local Security Setting** tab, click **Add User or Group** to add the Network Service account.

The previous procedure adds the SID **S-1-5-20** (well-known SID of the Network Service account) to the **CustomSD** registry value that's mentioned above. You could also manually add the value to the registry key. After the modification, the value resembles the following:

`O:BAG:SYD:(D;; 0xf0007;;;AN)(D;; 0xf0007;;;BG)(A;; 0xf0007;;;SY)(A;; 0x7;;;BA)(A;; 0x7;;;SO)(A;; 0x3;;;IU)(A;; 0x2;;;BA)(A;; 0x2;;;LS)(A;; 0x2;;;NS)(A;; 0x7;;;DA)(A;; 0x1;;;S-1-5-21-xxx-xxx-xxx-xxx);;; S-1-5-20`
