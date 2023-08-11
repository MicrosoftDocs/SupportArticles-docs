---
title: Password change processing and conflict resolution functionality in Windows
description: Describes a registry value that can be used by the administrator to control when the PDC is contacted, which can help reduce communication costs between sites and reduce load on the PDC.
ms.date: 04/24/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, herbertm
ms.custom: sap:active-directory-fsmo, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Password change processing and conflict resolution functionality in Windows

This article describes a registry value that administrators can use to control when the primary domain controller (PDC) is contacted, which can help reduce communication costs between sites and reduce the load on the PDC.

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, see [Windows registry information for advanced users](../performance/windows-registry-advanced-users.md).

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 225511

## Summary

By default, when a user password is reset or changed, or when a domain controller receives a client authentication request using an incorrect password, the Windows domain controller acting as the PDC Flexible Single Master Operation (FSMO) role owner for the Windows domain is contacted. This article describes a registry value that administrators can use to control when the PDC is contacted, which can help reduce communication costs between sites and reduce the load on the PDC.

This communication to the PDC isn't done for computer accounts. Computers will retry the authentication with the most recent previous password when the authentication fails. Along the same line, the computers would try the most recent previous password when decrypting a Kerberos service ticket they receive.

## More information

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

The following registry value can be modified to control Password Change Notification and Password Conflict Resolution as described below:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters`  

- Registry value: AvoidPdcOnWan
- Registry type: REG_DWORD
- Registry value data: 0 (or value not present) or 1
  - 0 or value not present = FALSE (to disable)
  - 1 = TRUE (to enable)
- Default: (value isn't present)

### Password change notification

A Windows writable domain controller receives the user password change or reset request. The password change is made locally, and then sent immediately to the PDC FSMO role owner using the Netlogon service as a Remote Procedure Call (RPC). The password change is then replicated to partners using the Active Directory replication process by both the PDC and the domain controller (DC) servicing the password change. If a Windows Read-Only domain controller (RODC) receives the password change request, it works like an authentication proxy forwarding the request to its hub DC, which acts as if it's the first DC to receive the request.

If the AvoidPdcOnWan value is set to TRUE and the PDC FSMO is located at another site, the password change isn't sent immediately to the PDC. However, it's updated with the change through normal Active Directory replication. If the PDC FSMO is at the same site, the AvoidPdcOnWan value isn't used, and the password change is immediately communicated to the PDC.

An updated password may not be sent to the PDC emulator even if AvoidPdcOnWan is FALSE or not set, if there are problems sending the request to the PDC, for example a Network outage. There's no error logged in this case. The update is then distributed using normal AD replication.

### Password conflict resolution

By default, Windows domain controllers query the PDC FSMO role owner if a user is attempting to authenticate using a password that is incorrect according to its local database. If the password sent from the client by the user is correct on the PDC, the client is allowed access, and the domain controller replicates the password change.

The AvoidPdcOnWan value can be used by administrators to control when Active Directory domain controllers attempt to use the PDC FSMO role owner to resolve password conflicts. The PDC completes the logon, and the authentication is successful for the authenticating user.

If the AvoidPdcOnWan value is set to TRUE and the PDC FSMO role owner is located at another site, the domain controller doesn't try to authenticate a client against password information stored on the PDC FSMO. Note, however, that this results in denying access to the user. This may cause a productivity impact, as many users aren't going to try the previous password to authenticate. In some scenarios, they may not know the previous password.

An incorrect password may not be tried at the PDC emulator even if AvoidPdcOnWan is FALSE or not set, if there are problems sending the request to the PDC, for example a Network outage. There's no error logged in this case. The logon attempt is denied in this case.

The scenario is different when an RODC is involved. If an authentication request on the RODC fails with a bad password, the RODC sends the request to the hub DC, and in turn, the hub DC sends it to the PDC. If it succeeds on the PDC, the user authentication succeeds. If the RODC is allowed to cache the user password, it will request the user password to be replicated from its hub DC. But the hub DC also still has the old password only. The RODC only gets the new password through the normal replication cycle. It will continue to need the hub or the PDC until the new password is replicated.

### Password replication handling

When the writable DC forwards the password change to the PDC, the user password is set on both DCs. Both DCs will include this new password in their outbound replication.

If these two changes arrive at a DC, the normal AD conflict resolution is performed. The AD version of attributes will be the same, but the time-stamp of the PDC will be a bit older, and the password of the initial DC will be used.

It makes no difference as the data payload is identical because both DCs have written the same new password value.

### Logging in the Directory Services event log

Windows Server 2022 has added events to track the activity of interactions with the PDC emulator regarding password update notifications.

#### Event ID 3035

Event ID 3035 is logged on the PDC at logging level four of the category "27 PDC Password Update Notifications" in the following registry entry:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`

```output
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      3035
Task Category: PDC Password Updates
Level:         Informational
Description:
Active Directory Domain Services successfully processed a password update notification sent from a Backup Domain Controller (BDC).
The user may experience temporary authentication failures until the updated credentials are successfully replicated to the PDC via normal replication schedules.
 BDC:      <Computer Name>
 User:      <User Name>
 User RID:  <RID>
```

#### Event ID 3036

Event ID 3036 is logged if there's an error when updating the PDC with the updates in a call from a Backup Domain Controller (BDC):

```output
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      3036
Task Category: PDC Password Updates
Level:         Warning
Description:
Active Directory Domain Services failed to process a password update notification sent from a Backup Domain Controller (BDC).
The user may experience temporary authentication failures until the updated credentials are successfully replicated to the PDC via normal replication schedules.
 BDC:      <Computer Name>
 User:      <User Name>
 User RID:  <RID>
 Error:     <Error Code>
```

#### Event ID 3037

Event ID 3037 is logged on the BDC at logging level four of the category "27 PDC Password Update Notifications" in the following registry entry:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`

```output
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      3037
Task Category: PDC Password Updates
Level:         Informational
Description:
Active Directory Domain Services successfully sent a password update notification to the Primary Domain Controller (PDC).
 User:      <User Name>
 User RID:  <RID>
```

#### Event ID 3038

Event ID 3038 is logged if there's an error when updating the PDC with the updates in a call from a BDC:

```output
Log Name:      Directory Service
Source:        Microsoft-Windows-ActiveDirectory_DomainService
Event ID:      3038
Task Category: PDC Password Updates
Level:         Warning
Description:
Active Directory Domain Services failed to send a password update notification to the Primary Domain Controller (PDC).
The user may experience temporary authentication failures until the updated credentials are successfully replicated to the PDC via normal replication schedules.
 User:      <User Name>
 User RID:  <RID>
 Error:     <Error Code>
```

For exmaple, error code c0000225 maps to STATUS_NOT_FOUND. This error is expected when the user is newly created on the local domain controller, and the user's password is set within the replication latency of the PDC.

You may also see network or RPC related errors in Event ID 3038. For example, when a firewall blocks the communication between the BDC and PDC, you may receive this event.

#### References

[How to configure Active Directory and LDS diagnostic event logging](configure-ad-and-lds-event-logging.md)
