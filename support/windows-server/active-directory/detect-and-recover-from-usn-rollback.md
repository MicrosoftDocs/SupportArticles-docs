---
title: How to detect and recover from a USN rollback in a Windows Server-based domain controller
description: Explains how to recover if a domain controller is incorrectly rolled back by using an image-based installation of the operating system.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
---
# A Windows Server domain controller logs Directory Services event 2095 when it encounters a USN rollback

This article describes how to detect and recover if a Windows Server domain controller is incorrectly rolled back by using an image-based installation of the operating system.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 875495

> [!NOTE]
> This article is intended for only technical support agents and IT professionals. If you're looking for help with a problem, please [ask the Microsoft Community](https://answers.microsoft.com/).

## Summary

This article describes a silent Active Directory replication failure that is caused by an update sequence number (USN) rollback. A USN rollback occurs when an older version of an Active Directory database is incorrectly restored or pasted into place.

When a USN rollback occurs, modifications to objects and attributes that occur on one domain controller do not replicate to other domain controllers in the forest. Because replication partners believe that they have an up-to-date copy of the Active Directory database, monitoring and troubleshooting tools such as Repadmin.exe don't report any replication errors.

Domain Controllers log Directory Services Event 2095 in the Directory Services event log when they detect a USN rollback. The text of the event message directs administrators to this article to learn about recovery options.

### Example of Event 2095 log entry

```output
Log Name:      <Service name> Service  
Source:        Microsoft-Windows-ActiveDirectory_DomainService  
Date:          <DateTime>
Event ID:      2095  
Task Category: Replication  
Level:         Error  
Keywords:      Classic  
User:          <USER NAME>  
Computer:      SERVER.contoso.com  
Description:

During an Active Directory Domain Services replication request, the local domain controller (DC) identified a remote DC which has received replication data from the local DC using already-acknowledged USN tracking numbers.

Because the remote DC believes it is has a more up-to-date Active Directory Domain Services database than the local DC, the remote DC will not apply future changes to its copy of the Active Directory Domain Services database or replicate them to its direct and transitive replication partners that originate from this local DC.

If not resolved immediately, this scenario will result in inconsistencies in the Active Directory Domain Services databases of this source DC and one or more direct and transitive replication partners. Specifically the consistency of users, computers and trust relationships, their passwords, security groups, security group memberships and other Active Directory Domain Services configuration data may vary, affecting the ability to log on, find objects of interest and perform other critical operations.

To determine if this misconfiguration exists, query this event ID using http://support.microsoft.com or contact your Microsoft product support.

The most probable cause of this situation is the improper restore of Active Directory Domain Services on the local domain controller.

User Actions:

If this situation occurred because of an improper or unintended restore, forcibly demote the DC.
```

The following topics discuss how to detect and recover from a USN rollback in a Windows Server-based domain controller.

## Supported methods to back up Active Directory on domain controllers that are running Windows Server 2012 and later versions

Windows Server 2012 adds support for Hyper-Visor Generation ID (GenID). This allows the virtual guest to detect the disk volumes that have a new ID, and respond to the new GenID. In Active Directory, Directory Services reacts as if the domain controller was restored from a backup. It then generates a new Invocation ID. By using the new Invocation ID, the database instance can safely re-enter replication in the forest.

This is one of the scenarios that is covered in [Virtualized Domain Controller Deployment and Configuration](/windows-server/identity/ad-ds/get-started/virtual-dc/virtualized-domain-controller-deployment-and-configuration).

## Supported methods to back up Active Directory on domain controllers that are running Windows Server 2003 or later versions of Windows Server

Over a domain controller's life cycle, you may have to restore, or "roll back," the contents of the Active Directory database to a known good point in time. Or, you may have to roll back elements of a domain controller's host operating system, including Active Directory, to a known good point.

The following are supported methods that you can use to roll back the contents of Active Directory:

- Use an Active Directory-aware backup and restoration utility that uses Microsoft-provided and Microsoft-tested APIs. These APIs non-authoritatively or authoritatively restore a system state backup. The backup that is restored should originate from the same operating system installation and from the same physical or virtual computer that is being restored.

- Use an Active Directory-aware backup and restoration utility that uses Microsoft Volume Shadow Copy Service APIs. These APIs back up and restore the domain controller system state. The Volume Shadow Copy Service supports creating single point-in-time shadow copies of single or multiple volumes on computers that are running Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2. Single point-in-time shadow copies are also known as snapshots. For more information, search "Volume Shadow Copy Service" in [Microsoft Support](https://support.microsoft.com/).

- Restore the system state. Evaluate whether valid system state backups exist for this domain controller. If a valid system state backup was made before the rolled-back domain controller was incorrectly restored, and if the backup contains recent changes that were made on the domain controller, restore the system state from the most recent backup.

## Typical behavior that occurs when you restore an Active Directory-aware system state backup

Windows Server domain controllers use USNs together with the invocation IDs to track updates that must be replicated between replication partners in an Active Directory forest.

Source domain controllers use USNs to determine what changes have already been received by the destination domain controller that is requesting changes. Destination domain controllers use USNs to determine what changes should be requested from source domain controllers.

The invocation ID identifies the version or the instantiation of the Active Directory database that is running on a given domain controller.

When Active Directory is restored on a domain controller by using the APIs and methods that Microsoft has designed and tested, the invocation ID is correctly reset on the restored domain controller. domain controllers in the forest receive notification of the invocation reset. Therefore, they adjust their high watermark values accordingly.

## Software and methodologies that cause USN rollbacks

When the following environments, programs, or subsystems are used, administrators can bypass the checks and validations that Microsoft has designed to occur when the domain controller system state is restored:

- Starting an Active Directory domain controller whose Active Directory database file was restored (copied) into place by using an imaging program such as Norton Ghost.

- Starting a previously saved virtual hard disk image of a domain controller. The following scenario can cause a USN rollback:

  1. Promote a domain controller in a virtual hosting environment.
  2. Create a snapshot or alternative version of the virtual hosting environment.
  3. Let the domain controller continue to inbound replicate and to outbound replicate.
  4. Start the domain controller image file that you created in step 2.

- Examples of virtualized hosting environments that cause this scenario include Microsoft Virtual PC 2004, Microsoft Virtual Server 2005, and EMC VMWARE. Other virtualized hosting environments can also cause this scenario.

- For more information about the support conditions for domain controllers in virtual hosting environments, see [Things to consider when you host Active Directory domain controllers in virtual hosting environments](ad-dc-in-virtual-hosting-environment.md).

- Starting an Active Directory domain controller that is located on a volume where the disk subsystem loads by using previously saved images of the operating system without requiring a system state restoration of Active Directory.

  - Scenario A: Starting multiple copies of Active Directory that are located on a disk subsystem that stores multiple versions of a volume

      1. Promote a domain controller. Locate the Ntds.dit file on a disk subsystem that can store multiple versions of the volume that hosts the Ntds.dit file.
      2. Use the disk subsystem to create a snapshot of the volume that hosts the Ntds.dit file for the domain controller.
      3. Continue to let the domain controller load Active Directory from the volume that you created in step 1.
      4. Start the domain controller that the Active Directory database saved in step 2.

  - Scenario B: Starting Active Directory from other drives in a broken mirror

      1. Promote a domain controller. Locate the Ntds.dit file on a mirrored drive.
      2. Break the mirror.
      3. Continue to inbound replicate and outbound replicate by using the Ntds.dit file on the first drive in the mirror.
      4. Start the domain controller by using the Ntds.dit file on the second drive in the mirror.

Even if not intended, each of these scenarios can cause domain controllers to roll back to an older version of the Active Directory database by unsupported methods. The only supported way to roll back the contents of Active Directory or the local state of an Active Directory domain controller is to use an Active Directory-aware backup and restoration utility to restore a system state backup that originated from the same operating system installation and the same physical or virtual computer that is being restored.

Microsoft does not support any other process that takes a snapshot of the elements of an Active Directory domain controller's system state and copies elements of that system state to an operating system image. Unless an administrator intervenes, such processes cause a USN rollback. This USN rollback causes the direct and transitive replication partners of an incorrectly restored domain controller to have inconsistent objects in their Active Directory databases.

## The effects of a USN rollback

When USN rollbacks occur, modifications to objects and attributes aren't inbound replicated by destination domain controllers that have previously seen the USN.

Because these destination domain controllers believe they're up to date, no replication errors are reported in Directory Service event logs or by monitoring and diagnostic tools.

USN rollback may affect the replication of any object or attribute in any partition. The most frequently observed side effect is that user accounts and computer accounts that are created on the rollback domain controller do not exist on one or more replication partners. Or, the password updates that originated on the rollback domain controller don't exist on replication partners.

The following steps show the sequence of events that may cause a USN rollback. A USN rollback occurs when the domain controller system state is rolled back in time using an unsupported system state restoration.

1. An administrator promotes three domain controllers in a domain. (In this example, the domain controllers are DC1, DC2, and DC2, and the domain is Contoso.com.) DC1 and DC2 are direct replication partners. DC2 and DC3 are also direct replication partners. DC1 and DC3 aren't direct replication partners but receive originating updates transitively through DC2.

2. An administrator creates 10 user accounts that correspond to USNs 1 through 10 on DC1. All these accounts replicate to DC2 and DC3.

3. A disk image of an operating system is captured on DC1. This image has a record of objects that correspond to local USNs 1 through 10 on DC1.

4. The following changes are made in Active Directory:

   - The passwords for all 10 user accounts that were created in step 2 are reset on DC1. These passwords correspond to USNs 11 through 20. All 10 updated passwords replicate to DC2 and DC3.
   - 10 new user accounts that correspond to USNs 21 through 30 are created on DC1. These 10 user accounts replicate to DC2 and DC3.
   - 10 new computer accounts that correspond to USNs 31 through 40 are created on DC1. These 10 computer accounts replicate to DC2 and DC3.
   - 10 new security groups that correspond to USNs 41 through 50 are created on DC1. These 10 security groups replicate to DC2 and DC3.

5. DC1 experiences a hardware failure or a software failure. The administrator uses a disk imaging utility to copy the operating system image that was created in step 3 into place. DC1 now starts with an Active Directory database that has knowledge of USNs 1 through 10.

    Because the operating system image was copied into place, and a supported method of restoring the system state wasn't used, DC1 continues to use the same invocation ID that created the initial copy of the database and all changes up to USN 50. DC2 and DC3 also maintain the same invocation ID for DC1 well as an *up-to-date vector* of USN 50 for DC1. (An up-to-date vector is the current status of the latest originating updates to occur on all domain controllers for a given directory partition.)

    Unless an administrator intervenes, DC2 and DC3 don't inbound replicate the changes that correspond to local USN 11 through 50 that originate from DC1. Also, according to the invocation ID that DC2 uses, DC1 already has knowledge of the changes that correspond to USN 11 to 50. Therefore, DC2 doesn't send those changes. Because the changes in step 4 do not exist on DC1, logon requests fail with an "access denied" error. This error occurs either because passwords do not match or because the account does not exist when the newer accounts randomly authenticate with DC1.

6. Administrators who monitor replication health in the forest note the following situations:

   - The `Repadmin /showreps` command-line tool reports that two-way Active Directory replication between DC1 and DC2 and between DC2 and DC3 is occurring without error. This situation makes any replication inconsistency difficult to detect.

   - Replication events in the directory service event logs of domain controllers that are running Windows Server do not indicate any replication failures in the directory service event logs. This situation makes any replication inconsistency difficult to detect.

   - Active Directory Users and Computers or the Active Directory Administration Tool (Ldp.exe) show a different count of objects and different object metadata when the domain directory partitions on DC2 and DC3 are compared to the partition on DC1. The difference is the set of changes that map to USN changes 11 through 50 in step 4.

        > [!NOTE]
        > In this example, the different object count applies to user accounts, computer accounts, and security groups. The different object metadata represents the different user account passwords.

   - User authentication requests for the 10 user accounts that were created in step 2 occasionally generate an "access denied" or "incorrect password" error. This error may occur because a password mismatch exists between these user accounts on DC1 and the accounts on DC2 and DC3. The user accounts that experience this problem correspond to the user accounts that were created in step 4. The user accounts and password resets in step 4 didn't replicate to other domain controllers in the domain.

7. DC2 and DC3 start to inbound-replicate originating updates that correspond to USN numbers that are greater than 50 from DC1. This replication proceeds normally without administrative intervention because the previously recorded up-to-dateness vector threshold, USN 50, has been exceeded. (USN 50 was the up-to-dateness vector USN recorded for DC1 on DC2 and DC3 before DC1 was taken offline and restored.) However, the new changes that corresponded to USNs 11 through 50 on the originating DC1 after the unsupported restore will never replicate to DC2, DC3, or their transitive replication partners.

Although the symptoms that are mentioned in step 6 represent some of the effect that a USN rollback can have on user and computer accounts, a USN rollback can prevent any object type in any Active Directory partition from replicating. These object types include the following:

- The Active Directory replication topology and schedule
- The existence of domain controllers in the forest and the roles that these domain controllers hold

    > [!NOTE]
    > These roles include the global catalog, relative identifier (RID) allocations, and operations master roles. (Operations master roles are also known as flexible single master operations or FSMO.)
- The existence of domain and application partitions in the forest
- The existence of security groups and their current group memberships
- DNS record registration in Active Directory-integrated DNS zones

The size of the USN hole may represent hundreds, thousands, or even tens of thousands of changes to users, computers, trusts, passwords, and security groups. (The USN hole is defined by the difference between the highest USN number that existed when the restored system state backup was made and the number of originating changes that were created on the rolled-back domain controller before it was taken offline.)

## Detect a USN rollback on a Windows Server domain controller

Because a USN rollback is difficult to detect, a Windows Server 2003 SP1 or later version domain controller logs event 2095 when a source domain controller sends a previously acknowledged USN number to a destination domain controller without a corresponding change in the invocation ID.

To prevent unique originating updates to Active Directory from being created on the incorrectly restored domain controller, the Net Logon service is paused. When the Net Logon service is paused, user and computer accounts can't change the password on a domain controller that will not outbound-replicate such changes. Similarly, Active Directory administration tools will favor a healthy domain controller when they make updates to objects in Active Directory.

On a domain controller, event messages that resemble the following are recorded if the following conditions are true:

- A source domain controller sends a previously acknowledged USN number to a destination domain controller.
- There is no corresponding change in the invocation ID.

These events may be captured in the Directory Service event log. However, they may be overwritten before they're observed by an administrator.

You may suspect that a USN rollback has occurred. However, you don't see the correlating events in the Directory Service event log.
In this scenario, check for the Dsa Not Writable registry entry. This entry provides forensic evidence that a USN rollback has occurred.

- Registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters`
- Registry entry: Dsa Not Writable
- Value: 0x4

Deleting or manually changing the **Dsa Not Writable** registry entry value puts the rollback domain controller in a permanently unsupported state. Therefore, such changes are not supported. Specifically, modifying the value removes the quarantine behavior added by the USN rollback detection code. The Active Directory partitions on the rollback domain controller will be permanently inconsistent with direct and transitive replication partners in the same Active Directory forest.

## Recover from a USN rollback

There are three approaches to recover from a USN rollback.

- Remove the Domain Controller from the domain. To do this, follow these steps:

    1. Remove Active Directory from the domain controller to force it to be a standalone server. For more information, see [Domain controllers do not demote gracefully when you use the Active Directory Installation Wizard to force demotion](domain-controllers-not-demote.md).

    2. Shut down the demoted server.

    3. On a healthy domain controller, clean up the metadata of the demoted domain controller. For more information, see [Clean up Active Directory Domain Controller server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).

    4. If the incorrectly restored domain controller hosts operations master roles, transfer these roles to a healthy domain controller. For more information, see [Transfer or seize Operation Master roles in Active Directory Domain Services](transfer-or-seize-operation-master-roles-in-ad-ds.md).

    5. Restart the demoted server.
    6. If you are required to, install Active Directory on the stand-alone server again.
    7. If the domain controller was previously a global catalog, configure the domain controller to be a global catalog. For more information, see [How to create or move a global catalog](https://support.microsoft.com/help/313994).

    8. If the domain controller previously hosted operations master roles, transfer the operations master roles back to the domain controller. For more information, see [Transfer or seize Operation Master roles in Active Directory Domain Services](transfer-or-seize-operation-master-roles-in-ad-ds.md).

- Restore the system state of a good backup.

    Evaluate whether valid system state backups exist for this domain controller. If a valid system state backup was made before the rolled-back domain controller was incorrectly restored, and the backup contains recent changes that were made on the domain controller, restore the system state from the most recent backup.

- Restore the system state without system state backup.

    You can use the snapshot as a source of a backup. Or you can set the database to give itself a new invocation ID by using the procedure in the [To restore a previous version of a virtual domain controller VHD without system state data backup](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd363553%28v=ws.10%29#to-restore-a-previous-version-of-a-virtual-domain-controller-vhd-without-system-state-data-backup) section of [Running Domain Controllers in Hyper-V](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd363545(v=ws.10)).

## References

- [Things to consider when you host Active Directory domain controllers in virtual hosting environments](ad-dc-in-virtual-hosting-environment.md)

- [Virtualized domain controller Architecture](/windows-server/identity/ad-ds/get-started/virtual-dc/virtualized-domain-controller-architecture)
