---
title: Password change and conflict resolution functionality in Windows
description: Describes a new registry value that can be used by the administrator to control when the PDC is contacted, which can help reduce communication costs between sites.
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory FSMO
ms.technology: windows-server-active-directory
---
# Password change and conflict resolution functionality in Windows

This article describes a new registry value that can be used by the administrator to control when the PDC is contacted, which can help reduce communication costs between sites.

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](/troubleshoot/windows-server/performance/windows-registry-advanced-users).

_Original product version:_ &nbsp;Windows Server 2012 R2  
_Original KB number:_ &nbsp;225511

## Summary

By default, when a machine account password or user password is changed, or a domain controller receives a client authentication request using an incorrect password, the Windows domain controller acting as the primary domain controller (PDC) Flexible Single Master Operation (FSMO) role owner for the Windows domain is contacted. This article describes a new registry value that can be used by the administrator to control when the PDC is contacted, which can help reduce communication costs between sites.

## More information

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

The following registry value can be modified to control Password Notification and Password Conflict Resolution as described below:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters`  

- Registry value: AvoidPdcOnWan
- Registry type: REG_DWORD
- Registry value data: 0 (or value not present) or 1
  - 0 or value not present = FALSE (to disable)
  - 1 = TRUE (to enable)
- Default: (value isn't present)
- Platform: Only Windows 2000 domain controllers

### Password change notification

By default, machine account password and user password changes are sent immediately to the PDC FSMO. In a mixed-mode domain, if a Windows NT 4.0 domain controller receives the request, the client is sent to the PDC FSMO role owner (which must be a Windows 2000-based computer) to make the password change. This change is then replicated to other Windows 2000 domain controllers using Active Directory replication, and to down-level domain controllers through the down-level replication process. If a Windows 2000 domain controller receives the request (either in mixed or native mode), the password change is made locally, sent immediately to the PDC FSMO role owner using the Netlogon service in the form of a Remote Procedure Call (RPC), and the password change is then replicated to its partners using the Active Directory replication process. Down-level domain controllers replicate the change directly from the PDC FSMO role owner.

If the AvoidPdcOnWan value is set to TRUE and the PDC FSMO is located at another site, the password change isn't sent immediately to the PDC. However, it's notified of the change through normal Active Directory replication, which in turn replicates it to down-level domain controllers (if the domain is in mixed mode). If the PDC FSMO is at the same site, the AvoidPdcOnWan value is disregarded and the password change is immediately communicated to the PDC.

An updated password may not be sent to the PDC emulator even if AvoidPdcOnWan is FALSE or not set, if there are Problems sending the request to the PDC, for example a Network outage. There is no error logged in this Case. The update is then distributed using normal AD replication.

### Password conflict resolution

By default, Windows domain controllers query the PDC FSMO role owner if a client is attempting to authenticate using a password that is incorrect according to its local database. If the password sent by the client is found to be correct on the PDC, the client is allowed access and the domain controller replicates the password change.

The AvoidPdcOnWan value can be used by administrators to control when Active Directory domain controllers attempt to use the PDC FSMO role owner to resolve password conflicts.

If the AvoidPdcOnWan value is set to TRUE and the PDC FSMO role owner is located at another site, the domain controller doesn't try to authenticate a client against password information stored on the PDC FSMO. Note, however, that this results in denying access to the client.

An incorrect password may not be tried at the PDC emulator even if AvoidPdcOnWan is FALSE or not set, if there are Problems sending the request to the PDC, for example a Network outage. There's no error logged in this Case. The logon attempt is denied in this case.
