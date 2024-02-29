---
title: NTDS replication warning IDs 1083 and 1061
description: Describes an issue that occurs if a change that is made on the local domain controller is also made on the domain controller that holds the PDC operations master role. In this scenario, the domain controllers may replicate the changes at the same time.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, rolandw, herbertm
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Description of NTDS replication warning IDs 1083 and 1061, and SAM error ID 12294 because of an Active Directory collision

This article provides help to fix an issue that occurs if a change that is made on the local domain controller is also made on the domain controller that holds the PDC operations master role.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 306091

## Summary

Simultaneous changes against Active Directory object attributes on different domain controllers may cause an Active Directory collision for the update. When this occurs, NTDS replication warnings 1083 or 1061, or SAM error ID 12294 may be logged.

## More information

The following events may be logged if immediate replication is triggered (for example, by an urgent replication for a user lockout condition) and collides with the local Active Directory update:
> Event Type: Warning  
Event Source: NTDS Replication  
Event Category: Replication  
Event ID: 1083  
Description:  
Replication warning: The directory is busy. It couldn't update object CN=... with changes made by directory GUID._msdcs.domain. Will try again later.

This indicates that the unsuccessful attempt of the remotely triggered update that will be retried later:
> Event Type: Warning  
Event Source: NTDS Replication  
Event Category: Replication  
Event ID: 1061  
Description:  
Internal error: The directory replication agent (DRA) call returned error 8438.  
(decimal 8438 / hex 0x20f6: ERROR_DS_DRA_BUSY, winerror.h)

If advanced NTDS logging is enabled, the following error ID may also be logged:
> Event Type: Warning  
Event Source: NTDS General  
Event Category: Internal Processing  
Event ID: 1173  
Description:  
Internal event: Exception e0010004 has occurred with parameters -1102 and 0 (Internal ID 2030537).  
(JetDataBase ID -1102: JET_errWriteConflict -1102, Write lock failed due to outstanding write lock)  

If NTDS logging is set to 4 (Verbose) or higher in the Replication Events entry of the `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Diagnostics\` subkey, the following error ID may also be logged:
> Event Type: Warning  
Event Source: NTDS Replication Event  
Category: Replication  
Event ID: 1413  
Description:  
The following object changes were not applied to the local Active Directory database because the local metadata for the object indicates that the change is redundant.

If the remotely triggered update wins against the local update, the following system event may be logged for a user account lockout:
> Event Type: Error  
Event Source: SAM  
Event Category: None  
Event ID: 12294  
User: user-SID  
Description:  
The SAM database was unable to lock out the account of user due to a resource error, such as a hard disk write failure (the specific error code is in the error data). Accounts are locked after a certain number of bad passwords are provided so consider resetting the password of the account mentioned above.  
Data: 0000: c00002a5  

You must analyze the error data to receive the correct error condition. DWord data hexadecimal 0xc00002a5 = decimal -1073741147: STATUS_DS_BUSY, ntstatus.h).

After the warnings, an NTDS information event is logged that reports that the queued update has already been made (with the same version ID) and is be ignored as redundant:
> Event Type: Information  
Event Source: NTDS Replication  
Event Category: Replication  
Event ID: 1413  
Description:  
Property 90296 (lockoutTime) of object CN=username,OU=... is not being applied to the local database because its local metadata implies the change is redundant. The local version is (version-ID).  

When this condition exists, no replication error has occurred. Active Directory is consistent and you can safely ignore the resulting event logs.

On a computer that is running Microsoft Windows Server, you can also determine whether a replication error has occurred by exporting the replication meta-data of the object. To do this, run the following command at a command prompt:

```console
repadmin /showobjmeta <domainController> <objectDN>  
```

> [!NOTE]
> In this command, make the following replacements for the placeholders:
>
> - Replace the **domainController** placeholder with the host name of a domain controller.
> - Replace the **objectDN** placeholder with the distinguished name of the affected object.

In the output that this command generates, match the last update times of the attribute to the times that the events were logged. From this information, you can determine which attribute caused the replication error.

Generally, you experience this problem with the lockoutTime attribute or with one of the password attributes. In these cases, you can safely ignore the events. The events occur because the change that occurs on the primary domain controller (PDC) is also written to the local domain controller. At the same time, the change is replicated among the domain controllers. For lockoutTime, the change is replicated urgently in the site of the PDC.

Because of the short replication notification intervals that you can have in Microsoft Windows Server, you may experience a replication collision in the same site of the PDC. Password changes are one example of a scenario in which you may experience a replication collision. This behavior occurs because a domain controller forwards new passwords to the PDC. Both the PDC and the local domain controller then replicate the changed password information. Therefore, a replication collision may occur on another domain controller in the same site. For more information about replication notification, click the following article number to view the article in the Microsoft Knowledge Base:  
[214678](https://support.microsoft.com/help/214678) How to modify the default intra-site domain controller replication interval

To help reduce the generation of replication collision events, configure the PDC in a site that does not have other domain controllers or client computers. In this scenario, the PDC does not urgently replicate updates that it receives. Therefore, you may reduce the risk of replication collisions. In a large domain, you can use this method to help reduce the load on the PDC.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
