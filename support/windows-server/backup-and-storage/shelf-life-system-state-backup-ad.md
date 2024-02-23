---
title: Shelf life of a system-state backup of AD
description: Describes the useful shelf life of a system-state backup of Active Directory (AD).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:active-directory-backup-and-restore-or-disaster-recovery, csstroubleshoot
---
# Useful shelf life of a system-state backup of Active Directory

This article describes the useful shelf life of a system-state backup of Active Directory (AD).

_Applies to:_ &nbsp; Windows Server 2003, Windows 2000, Windows XP  
_Original KB number:_ &nbsp; 216993

## Summary

Windows Backup, the backup tool that is included with Windows Server 2003 and with Windows 2000, can back up and restore Active Directory on Windows Server 2003 or Windows 2000 domain controllers. These backups can be performed while the domain controller is online. You can restore these backups only when the domain controller is booted into Directory Services Restore mode by using the F8 key when the server is starting.

If a nonauthoritative restore is performed by using Backup, the domain controller will contain the settings and entries that existed in the Domain, Schema, Configuration, and optionally the Global Catalog Naming Contexts when the backup was performed. Partial synchronization (replication) from other replicas within the enterprise then update all naming contexts hosted on the domain controller, overwriting the restored data.

Windows Server 2003 and Windows 2000 don't allow the restoring of old backup images into a replicated enterprise. Specifically, the useful life of a backup is the same as the "tombstone lifetime" setting for the enterprise. The default value for the tombstone lifetime entry is 60 days. This value can be set on the Directory Service (NTDS) config object.

## More information

If your only backup of Active Directory is older than the tombstone lifetime setting, reinstall the server after confirming there is at least one surviving domain controller in the domain from which new replicas can be synchronized. You can lose all but one server in the domain and still recover without a loss of data, assuming that the remaining survivor holds current information.

If every server in the domain is destroyed when you use the server in a single domain controller forest or in a single domain that contains multiple domain controllers, restore one server from an arbitrarily outdated backup. Then, replicate all other servers from the restored one. However, you cannot restore the server when you use the server in a multi-domain forest. In this scenario, information that was written to Active Directory after the outdated backup was performed is not available.

The tombstone lifetime attribute is located on the enterprise-wide DS config object. The path for this attribute is:CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=COMPANY,DC=COM

Use the Active Directory editing tool of your choice so that the "tombstoneLifetime" attribute is set to be older than the backup used to restore Active Directory. Supported tools include Adsiedit.msc, Ldp.exe, and Active Directory Service Interfaces (ADSI) scripts.

> [!NOTE]
> This information assumes that the backup is not older than the default "tombstoneLifetime" setting. Otherwise, the objects have already been deleted from the database. In this case, an authoritative restore may be the better alternative if there are multiple domain controllers.

The "tombstoneLifetime" attribute represents the number of days a backup of Active Directory can be used in addition to the frequency with which Garbage Collection routines (removing items previously marked for deletion) are run. For more information about Garbage Collection, see [The Active Directory database Garbage Collection process and calculation of allowed intervals](../identity/database-garbage-collection-caculation-of-allowed-intervals.md).

## Changes to the tombstone lifetime attribute in Windows Server 2003 Service Pack 1

The default tombstone lifetime value has sometimes proven to be too short. For example, pre-staged domain controllers are sometimes in transit to their final destination for longer than 60 days. Administrators regularly do not bring offline domain controllers into operation or resolve replication failures for longer than the number of days that is specified by the default tombstone lifetime attribute. Windows Server 2003 Service Pack 1 (SP1) increases the attribute value from 60 to 180 days in the following scenarios:

- You use Windows Server 2003 SP1 slipstreamed media to upgrade a Windows NT 4.0 domain to a Windows Server 2003 domain. When you perform the upgrade, you create a new forest.
- You promote a computer that is running Windows Server 2003 SP1 to a domain controller. When you promote the domain controller, you create a new forest.

The original release version of Windows Server 2003 SP1 does not modify the value of the tombstone lifetime attribute when the following conditions are true:

- You upgrade a Windows 2000 domain to a Windows Server 2003 domain by using Windows Server 2003 SP1 slipstreamed media.
- You install Windows Server 2003 SP1 on domain controllers that are running the original release version of Windows Server 2003.

Increasing the tombstone lifetime attribute for a domain to 180 days increases the following items:

- The useful life of backups that are used for data recovery scenarios.
- The useful life of system state backups that are used for promotions using the Install from Media feature.
- The time that domain controllers can be offline. (Computers that are built in a staging site and shipped to destination sites frequently approach tombstone lifetime expiration.)
- The time that a domain controller may be offline and still return to the domain successfully.
- The time that a domain controller may experience a replication failure and still return to the domain successfully.
- The number of days that the originating domain controller retains knowledge of deleted objects.

## Technical support for Windows x64 editions

Your hardware manufacturer provides technical support and assistance for Windows x64 editions. Your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.
