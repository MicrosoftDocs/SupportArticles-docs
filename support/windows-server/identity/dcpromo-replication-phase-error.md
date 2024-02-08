---
title: Internal error during replication phase of dcpromo
description: Describes how to troubleshoot an internal error that you receive during the replication phase of the Active Directory Installation Wizard (Dcpromo)
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jarrettr, arrenc
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Troubleshoot an Internal error message during the replication phase of dcpromo

This article describes how to troubleshoot an internal error that you receive during the replication phase of the Active Directory Installation Wizard (Dcpromo).

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 265090

> [!NOTE]
> **Home users:** This article is only intended for use by technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com/).

## Summary

During promotion, directory service objects are replicated in the order of the Update Sequence Number (USN) (low to high) for the schema, configuration, and domain. Internal errors can occur when a parent container for replicated child objects doesn't exist in the local directory service.

This issue can occur in either of the following scenarios:

- There is a live object whose parent was deleted in the past, and the parent has expired and been converted to a phantom. Therefore, the child object can no longer be replicated out. The call to **FillGuidAndSid** for the parent object in **ReplPrepareDataToShip** doesn't succeed, and an error is reported (8352 = ERROR_DS_NOT_AN_OBJECT). This error causes the outbound replication of the child object to quit, and you receive a replication internal error message.

    If there is a live (or deleted) object that has a phantom parent, Active Directory temporarily accepts the live object because of out-of-order replication requirements. Disk cleanup procedures, such as garbage collection, shouldn't be able to convert a deleted object into a phantom if the parent has child objects. The Ntdsa.dll file as of Windows 2000 Service Pack 2 (SP2) prevents this situation in the directory service. However, this file doesn't fix the issue after it has already occurred.

- You use the **authoritative restore** command when you use Windows Server 2003 or a later version of the Ntdsutil tool. Ntdsutil.exe increases the USN of specified containers and child objects in Active Directory. Beta versions of Ntdsutil.exe may incorrectly increase the USN for the Lost and Found container. When objects that are destined for the Lost and Found container are replicated before the container is created in the local directory service, the following event is reported:

    > Event 1084: Replication failed with an internal error

    To avoid this scenario, the Lost and Found container is normally one of the first containers that is replicated.

Internal errors can also occur on existing Active Directory domain controllers during normal or administrator-initiated Active Directory replication.

## Steps to troubleshoot this error message

1. Use Network Monitor, event logs, or Dcpromo.log to locate the source server that is being used during Active Directory replication (when you are using the Active Directory Installation Wizard).

2. If this error occurs when you are using Active Directory Installation Wizard and more than one potential replication partner exists, use the Active Directory Installation Wizard answer file to find the source server. Possible source domain controllers include domain controllers in the parent domain for new child domains, or domain controllers in the same domain for replicated domain controllers. Alternatively, if a specific source server is suspect, stop the Net Logon service on the suspect computer, and search from a different domain controller.

3. On the source server, locate and click the following registry sub key:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Diagnostics`

    Edit the following values:
   - 9 Internal Processing: Set the diagnostic level to 1.
   - 7 Internal Configuration: Set the diagnostic level to 3.
   - 5 Replication Events: Set the diagnostic level to 3.

4. Use Registry Editor to export the `\NTDS` key from the source server to the computer that is being promoted (for example, Ntds.reg). Copy the file to the computer that is encountering the internal error when replication occurs. If the internal error occurs when the Active Directory Installation Wizard is running, copy the .reg file to the desktop on the problem domain controller so that the file can be easily started.

    Alternatively, press Windows key+R, and then drag the .reg file from the staged Explorer window that is focused on that file. Select **OK** to add the contents of the .reg file to the registry.

5. When the computer that is being promoted starts replicating the schema naming context, run the Ntds.reg file to build the `\NTDS\Diagnostics` registry key and settings.

   > [!WARNING]
   > The `NTDS\Diagnostics` registry key does not exist at this phase of promotion and must be manually created on the destination domain controller. If the `NTDS\Diagnostics` registry key is loaded too early when the Active Directory Installation Wizard is running, the key is overwritten with default values and no events are logged. For existing domain controllers, the registry settings can be enabled any time.

6. Examine the directory service events logs on the source and destination servers. Internal events are displayed on the source server as event ID 1173. Review NTDS replication events that occur before the internal error to locate the global universal identification (GUID) of the object that's being replicated. (There may be back-to-back attempts to replicate the same object). Record the GUID for the problematic object or container.

7. Start Ldp.exe, initiate a connection, and bind against the source server. From the **Browse** menu, select **Delete**. For the distinguished name path, type *<GUID=GUID#>*, for example, \<GUID=b2d605a4-b9e6-4505-ba59-895e91a9a7b5>. Set the search scope to **Base**, and then delete the specified GUID.

8. Using Ldp.exe, set the value for the **TombstoneLifetime** attribute to 2 (the value in days before tombstoned objects are removed). TombstoneLifetime is located in the following distinguished name path:

    CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,,DC= root domain ,DC=COM

    Verify that the TombstoneLifetime attribute is present and its value is 2. If the value is less than 2, the value is invalid, and the server uses the default value of 60 days. (You can also use ADSIEDIT to change this attribute.)

    > [!NOTE]
    > After you wait two days for the tombstoned objects to be removed, you may have to wait an additional 60 minutes or longer before you restart the domain controller and continue the garbage collection process.

9. Initiate garbage collection on the source domain controller. Locate and click the following registry key:

    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Diagnostics key`

    Edit the following values:
   - 6 Garbage Collection: Set diagnostic level to 3.
   - 9 Internal Processing: Set diagnostic level to 1.

    To force a garbage collection, restart the domain controller. Garbage collection should run 15 minutes after you restart the domain controller. The diagnostic levels now record garbage collection events in the directory service event log.

10. To verify that the object has been deleted, run the following command:

    ```console
    repadmin /showmeta "<"GUID for deleted object">"
    ```

    If you receive a message: no such object, the object has already been successfully deleted, and you can now successfully run the Active Directory Installation Wizard. If the object has not yet undergone the garbage collection process, there should be metadata for the isDeleted attribute. The time stamp that's associated with the isDeleted attribute is the deletion time. Verify that the deletion time is set for at least two days ago, for example:

    ```console
    repadmin /showmeta "<GUID=b2d605a4-b9e6-4505-ba59-895e91a9a7b>"
    ```

11. When this issue is resolved, reset the diagnostics logging levels to **0** and set the tombstone lifetime back to what it was previously, or remove the value altogether to prompt the computer to use the default values. The TombstoneLifetime setting is critical in defining the useful life of system state and Active Directory backups. When TombstoneLifetime is set to **2**, backup tapes that are older than two days are unusable. Any domain controller that has been down for two or more days must be either restored from backup or reinstalled.

The following text is an example of the events that are reported in the directory service event log on the source and destination server:

> Event Type: Information
Event Source: NTDS Replication
Event Category: Replication
Event ID: 1240
Date: MM/DD/YY
Time: HH:MM:SS AM|PM
User: S-1-5-21-1151542997-2719369742-1698538726-500
Computer: computer_source
Description:
Property 0 (objectClass) of object CN="NTDS Settings DEL:51c6913c-9221-4ac4-8513-9155dd7e15ad",CN="ZA9902000 DEL:37eabd48-bc98-483f-b2fd-9c8869e9c3ce",CN=Servers,CN=Bull,CN=Sites,CN=Configuration,DC=mma,DC=fr (GUID 51c6913c-9221-4ac4-8513-9155dd7e15ad) is being sent to DSA 6abec3d1-3054-41c8-a362-5a0c5b7d5d71.
>
> Event Type: Warning Event Source: NTDS General Event Category: Internal Processing Event ID: 1173 Date: MM/DD/YY Time: HH:MM:SS AM|PM User: S-1-5-21-1151542997-2719369742-1698538726-500 Computer: computer_source
Description: Internal event: Exception e0010002 has occurred with parameters 8442 and 20a0 (Internal ID 11003a1).

The following text is reported in the Active Directory Installation Wizard log on the computer that is being promoted. In this sample Dcpromo.log file, the computer that is being promoted, \\\\computer_promoted, is encountering the "internal error" in the Active Directory Installation Wizard when it's sourcing from \\\\computer_source. Note the error 8442 that occurs while one of three naming contexts is being replicated ("The replication system encountered an internal error"). This example shows that the error occurs on the configuration naming context:

> MM/DD HH:MM:SS [INFO] Replicating CN=Configuration,DC=win2ktest,DC=A,DC=com: received 917 out of 1783 objects.  
MM/DD HH:MM:SS [INFO] Replicating CN=Configuration,DC=win2ktest,DC=A,DC=com: received 1049 out of 1783 objects.  
MM/DD HH:MM:SS [INFO] Replicating CN=Configuration,DC=win2ktest,DC=A,DC=com: received 1181 out of 1783 objects.  
MM/DD HH:MM:SS [INFO] Replicating CN=Configuration,DC=win2ktest,DC=A,DC=com: received 1200 out of 1783 objects.  
MM/DD HH:MM:SS [INFO] Error - The Directory Service failed to replicate the partition CN=Configuration,DC=test,DC=A,DC=com from remote server computer_source.test.a.com. (8442)  
MM/DD HH:MM:SS [INFO] NtdsInstall for `test.a.com` returned 8442  
MM/DD HH:MM:SS [INFO] DsRolepInstallDs returned 8442  
MM/DD HH:MM:SS [ERROR] Failed to install to Directory Service (8442)  
MM/DD HH:MM:SS [INFO] Starting service NETLOGON  
MM/DD HH:MM:SS [INFO] Configuring service NETLOGON to 2 returned 0  
MM/DD HH:MM:SS [INFO] Searching for the machine account forcomputer_promotedon \\computer_source.test.a.com...  
MM/DD HH:MM:SS [INFO] Configuring the server account  
MM/DD HH:MM:SS [INFO] NtdsSetReplicaMachineAccount returned 0  
MM/DD HH:MM:SS [INFO] Attempted to move accountcomputer_sourceto CN=GAXGPTS01,CN=Computers,DC=test,DC=A,DC=com
