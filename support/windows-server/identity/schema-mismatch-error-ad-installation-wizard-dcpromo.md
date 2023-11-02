---
title: (Schema mismatch) error message occurs when you try to run the Active Directory Installation Wizard (Dcpromo.exe)
description: Explains how to fix (Schema mismatch) error message when try to run the Active Directory Installation Wizard (Dcpromo.exe)
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: arrenc, kaushika
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
ms.technology: windows-server-active-directory
---
# "Schema mismatch" error message occurs when you try to run the Active Directory Installation Wizard (Dcpromo.exe)

This article provides the resolution of fixing the error "schema mismatch", when you try to run the Active Directory Installation Wizard (Dcpromo.exe).

_Applies to:_ &nbsp; Windows Servers 2012 R2  
_Original KB number:_ &nbsp; 838179

## Symptoms

When you run the Active Directory Installation Wizard (Dcpromo.exe) on a computer that is running one of the editions of Microsoft Windows that is listed in the "Applies to" section, you may receive a "schema mismatch" error message.

If you are running Microsoft Windows Server 2003, you may receive the following error message:

> Active Directory could not replicate the directory partition **DN path for partition** from the remote domain controller **fully qualified computer name of the source domain controller**. The replication operation failed because of a schema mismatch between the servers involved.

If you are running Microsoft Windows 2000, you may receive the following error message:

> The Directory Service failed to replicate the partition **partition name** from remote server **remote server name**. The replication operation failed because of a schema mismatch between the servers involved.

## Cause

This problem may occur if one of the following conditions is true:

- Condition 1: The source domain controller's copy of the Active Directory directory service contains duplicate multi-valued attributes.
- Condition 2: One or more attributes or pages in the database of the source domain controller are corrupted.
- Condition 3: The source domain controller has attributes in its database that are not covered by the current schema because of schema deletion.

## Resolution

To resolve this problem, use one of the following two methods. Method 1 addresses Condition 1 and Condition 2. Method 2 addresses Condition 3.

### Method 1: Resolution for Condition 1 and Condition 2

The "schema mismatch" error message is misleading. The root cause of the error may not have anything to do with the schema partition (CN) or with any objects that are in it. The actual problem may be a database constraint violation, such as a multi-valued attribute with duplicate values.

To troubleshoot and to resolve this problem, follow the steps in this six-part procedure.

#### Part 1: Turn on diagnostic logging

Turn on diagnostic logging on the source domain controller. To do this, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
2. Locate and then click the following registry subkey:

     `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics`
3. In the **Name** column in the right pane, right-click the **5 Replication Events** registry entry, and then click **Modify**.
4. Type *5*, and then click **OK**.
5. Repeat steps 3 and 4 for the following registry entries:
   - 7 Internal Configuration  
   - 8 Directory Access  
   - 9 Internal Processing  
   - 24 DS Schema
6. In the left pane, click the following registry subkey again:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics`
7. On the **File** menu, click **Export**.
8. In the **Save in** box, open the administrator's Desktop folder on the computer where you are receiving the "schema mismatch" error message. In the **File name** box, type *Ntds_logging*, and then click **OK**.

    > [!NOTE]
    > Typically, the administrator's Desktop folder is C:\\Documents and Settings\\Administrator\\Desktop. However the system drive letter can vary. To find the system drive that your computer uses, follow these steps:

      1. Log on to the computer where you are receiving the "schema mismatch" error message.
      2. Click **Start**, click **Run**, type *command*, and then click **OK**.
      3. Type *set*, and then press ENTER.

         The output line that begins with "SystemDrive=" shows you the drive letter that your system uses.
      4. Type *exit*, and the press ENTER.

#### Part 2: Force inbound replication of Active Directory

Force the destination computer to perform inbound replication of Active Directory from a domain controller where NTDS diagnostic logging has been enabled. If there are multiple source domain controllers, make sure that replication occurs from a source domain controller where diagnostic logging has been enabled. To do this, use one of the following methods:

- Increase `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics` logging on all possible source domain controllers by using steps 1 through 5 in the "Part 1: Turn on diagnostic logging" section.
- Stop the Net Logon service on all possible source domain controllers except the source domain controller that is referenced in the "schema mismatch" error where logging was increased. To do this, follow these steps:

  1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Services**.
  2. Right-click **Net Logon**, and then click **Stop**.
  3. Create an unattended **Active Directory Installation Wizard** answer file.

- Run the **Active Directory Installation Wizard** on the destination computer that is reporting the "schema mismatch" error with NTDS diagnostic logging enabled. The exact time that NTDS diagnostic logging occurs depends on whether the computer that is being promoted is running Windows 2000 or Windows Server 2003.

  The Active Directory Installation Wizard affects the following Windows registry keys:

  - Helper domain controllers that are running Windows 2000 or Windows Server 2003 preserve log settings in the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics` registry subkey until the Active Directory Installation Wizard demotes these domain controllers.
  - Windows 2000-based computers that are being promoted overwrite the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics` registry subkey at the beginning of each promotion attempt. Double-click **Ntds_logging.reg** as soon as inbound replication of the schema partition from the helper domain controller has started to pre-populate the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics` registry subkey for each attempt to promote the Windows 2000-based domain controller.
  - Windows Server 2003-based computers do not overwrite pre-existing values in the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics` registry subkey. However, existing settings are deleted after each failed promotion attempt.

#### Part 3: Pre-populate the registry on destination domain controllers

Pre-populate the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics` subkey on destination domain controllers that are running Windows 2000 or Windows Server 2003. To do this, follow these steps:

1. On the source domain controller, follow steps 1 through 5 in the "Part 1: Turn on diagnostic logging" section.
2. Right-click the following registry subkey, and then click **Export**:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ntds\Diagnostics`

3. In the **Save in** box, open the administrator's Desktop folder on the computer that is being promoted. In the **File name** box, type *Ntds_logging*, and then click **OK**.

    > [!NOTE]
    > To locate the Desktop folder, see the note in Part 1, step 8.
4. On the destination domain controller, double-click the **Ntds_logging.reg** file that you saved in the administrator's Desktop folder at the appropriate time, depending on whether the computer that is being promoted is running Windows Server 2003 or Windows 2000.

#### Part 4: Locate any duplicate multi-valued attributes

1. Examine the directory service event logs on both the source domain controller and the destination domain controller to find the problem object.
2. On the source domain controller, review the directory service event log and note the last object and attribute that were outbound replicated to the domain controller that is being promoted. The problem object is either the last object or attribute that is referenced in the directory service event log or the object in the same partition with the next highest Update Sequence Number (USN). Record the domain name path of the object that is referenced and the last attribute that was replicated. On the source domain controller, look for the last event 1240. On the destination domain controller, look for event 1203.
3. Use the `ldifde` command to export the object that is referenced. To do this:
   1. Click **Start**, click **Run**, type *command*, and then click **OK**.
   2. Type the following, and then press ENTER: `LDIFDE -f MISMATCH -d <domain name path of object referenced in event log of the source domain controller>`  

4. Examine the ldifde output in Notepad or another text editor. Pay particular attention to attributes that have duplicate values. For example, the following truncated example contains attributes with duplicate values:

    > msExchMonitoringResponses:: \<Start of Duplicate #1> W19fQ0xBU1M6c3RyKDE3KV1TTVRQRXZlbnRDb25zdW1lcltOb3RpZnlPbkVycm9yOnN0cigyKV0tMV tSZXNwb25kVG9XaGljaE9iamVjdHM6c3RyKDEpXTBbT2JqZWN0c1RvUmVzcG9uZFRvOnN0cigwKV1b U01UUFNlcnZlcjpzdHIoNCldQUxFWFtUb0xpbmU6c3RyKDI1KV1yamtlbnZpbkBtZXRib2UuazEyLm 5qLnVzW01lc3NhZ2U6c3RyKDMxNyldJVRhcmdldEluc3RhbmNlLk5hbWUlIGhhcyByZXBvcnRlZCBh ICVUYXJnZXRJbnN0YW5jZS5TZXJ2ZXJTdGF0ZVN0cmluZyUuICBSZXBvcnRlZCBzdGF0dXMgaXM6DQ pRdWV1ZXMgLSAlVGFy  
    Z2V0SW5zdGFuY2UuUXVldWVzU3RhdGVTdHJpbmclDQpEcml2ZXMgLSAlVGFy Z2V0SW5zdGFuY2UuRGlza3NTdGF0ZVN0cmluZyUNClNlcnZpY2VzIC0gJVRhcmdldEluc3RhbmNlLl NlcnZpY2VzU3RhdGVTdHJpbmclDQpNZW1vcnkgLSAlVGFyZ2V0SW5zdGFuY2UuTWVtb3J5U3RhdGVT     dHJpbmclDQpDUFUgLSAlVGFyZ2V0SW5zdGFuY2UuQ1BVU3RhdGVTdHJpbmclDQpbU3ViamVjdDpzdH   IoNTkpXSVUYXJnZXRJbnN0YW5jZS5TZXJ2ZXJTdGF0ZVN0cmluZyUgb24gJVRhcmdldEluc3RhbmNl Lk5hbWUl msExchMonitoringResponses:: \<Start of Duplicate#2> W19fQ0xBU1M6c3RyKDE3KV1TTVRQRXZlbnRDb25zdW1lcltOb3RpZnlPbkVycm9yOnN0cigyKV0tMV tSZXNwb25kVG9XaGljaE9iamVjdHM6c3RyKDEpXTBbT2JqZWN0c1RvUmVzcG9uZFRvOnN0cigwKV1b U01UUFNlcnZlcjpzdHIoNCldQUxFWFtUb0xpbmU6c3RyKDI1KV1yamtlbnZpbkBtZXRib2UuazEyLm 5qLnVzW01lc3NhZ2U6c3RyKDMxNyldJVRhcmdldEluc3RhbmNlLk5hbWUlIGhhcyByZXBvcnRlZCBh ICVUYXJnZXRJbnN0YW5jZS5TZXJ2ZXJTdGF0ZVN0cmluZyUuICBSZXBvcnRlZCBzdGF0dXMgaXM6DQ pRdWV1ZXMgLSAlVGFy  Z2V0SW5zdGFuY2UuUXVldWVzU3RhdGVTdHJpbmclDQpEcml2ZXMgLSAlVGFy Z2V0SW5zdGFuY2UuRGlza3NTdGF0ZVN0cmluZyUNClNlcnZpY2VzIC0gJVRhcmdldEluc3RhbmNlLl NlcnZpY2VzU3RhdGVTdHJpbmclDQpNZW1vcnkgLSAlVGFyZ2V0SW5zdGFuY2UuTWVtb3J5U3RhdGVT   dHJpbmclDQpDUFUgLSAlVGFyZ2V0SW5zdGFuY2UuQ1BVU3RhdGVTdHJpbmclDQpbU3ViamVjdDpzdH  IoNTkpXSVUYXJnZXRJbnN0YW5jZS5TZXJ2ZXJTdGF0ZVN0cmluZyUgb24gJVRhcmdldEluc3RhbmNl Lk5hbWUl

5. If duplicate values appear, use `Adsiedit.msc` or `ldifde` to remove one of the duplicates. After you have removed the duplicates, retry the promotion by running the **Active Directory Installation Wizard** again.

#### Part 5: Look for database corruption

The root cause may be database corruption on the source domain controller. To locate database corruption and repair it, follow these steps:

1. Examine the source domain controller's directory services event log for the last 1240 event that was logged. This event may be logged just before Internal Processing Event 1173. Note the DN path of the object that is referenced in the last 1240 event, and then run the Repadmin.exe tool on the console of the source domain controller. To do this, follow these steps:
   1. Click **Start**, click **Run**, type *command*, and then click **OK**.
   2. Type the following command, and then press ENTER:

    ```console
    REPADMIN /SHOWMETA CN=Secret,CN=Schema,CN=Configuration,DC=CORP,DC=COM  
    ```

2. View the metadata of the last outbound-replicated object that was replicated from the source domain controller. If no duplicate values are found, examine the source domain controller's directory services event log for the last 1240 event that was logged before a 1173 event. The following is a sample 1240 event.
3. Run the `repadmin /showmeta` command against the domain name path of the object that is referenced in the last 1240 event that was logged on the source domain controller. For example, using the sample event in step 2 for a domain controller in the CORP.COM domain, the syntax would be the following:

    ```console
    REPADMIN /SHOWMETA CN=Secret,CN=Schema,CN=Configuration,DC=CORP,DC=COM
    ```

    Look for inconsistent or suspicious values in the output, especially in the Local USN and the Originating time columns. For example, in the following truncated output example, two attributes, defaultObjectCategory and ObjectClass, have what appears to be USN numbers and 0 date and time stamps that are not valid.

   Truncated output from the `repadmin /showmeta` command:

   > CN=Secret,=Schema,CN=Configuration,DC=CORP,DC=COM object Loc. USNOriginating Time: Attribute 21962002-01-29 05:52.47 instanceType 18295873486194836 4446-09-07 21:51.13defaultObjectCategory 182958734861948362002-01-29 05:52.47 objectClass

4. If the problem object that is referenced in the output is not a critical object, make a ldifde backup of the object, and then delete the object. Do not delete problem objects that reside in the schema partition of Active Directory.
5. Run an NTDSUTIL files integrity check against the Active Directory database. To do this:
   1. Windows 2000 uses setpwd to change the DSRM passwords. Windows Server 2003 uses ntdsutil to change the DSRM passwords.

      The following option works in Windows Server 2003:

      [322672](https://support.microsoft.com/help/322672) How to reset the Directory Services Restore Mode administrator account password in Windows Server  

   2. Start the source domain controller in DSREPAIR mode.

      > [!NOTE]
      > Clients that try to access the DFS Root information or the DFS Link information may receive an "access denied" error message during an attempt to connect while the domain controller is in DSREPAIR mode. This behavior is by design.
   3. Run NTDSUTIL files integrity check from the Windows command prompt.
   4. Look for errors in the NTDSUTIL output.
6. If the NTDSUTIL integrity check logged jet error -1206, investigate the following options. Do not under any circumstances repair corrupted Active Directory databases by using NTDSUTIL or by using ESENTUTL equivalents.
   1. If other candidate domain controllers exist to source the new domain controller in the forest, run the Active Directory Installation Wizard with the problem source domain controller offline.
   2. If other domain controllers in the domain exist and if there is no significant system state unique to the helper domain controller, try to gracefully demote the original source domain controller. Otherwise, force-demote it, and then remove its metadata from the forest. Run the Active Directory Installation Wizard to add the original domain controller back to the forest after end-to-end replication of the removal on all domain controllers in the forest has occurred.
   3. Restore the system state for that domain controller if the all following conditions are true:
      - The original source domain controller is the only domain controller in its domain.
      - It contains critical system state (that is, it contains the forest root domain, or there is a significant investment in objects in its copy of Active Directory).
      - A valid system state backup exists (that is, the backup is less than tombstonelifetime days old and it contains no corrupted objects).

       > [!NOTE]
       > A system state restore of a partition that contains a single replica is effectively an authoritative restore of that partition.

   4. If the original source domain controller is the only domain controller in its domain and if it contains critical system state but no valid system state backups exist, consider doing the following:
     - Add a Microsoft Windows NT 4.0-based backup domain controller (BDC) to the domain. This option assumes a mixed mode or a switch that allows the Windows NT 4.0-based BDC to replicate with Windows 2000-based domain controllers in native mode domains.
     - Put the Windows NT 4.0-based BDC on a private network.
     - Promote the Windows NT 4.0-based BDC to a primary domain controller (PDC).
     - Upgrade the Windows NT 4.0-based PDC to Windows 2000 or to Windows Server 2003.
     - Add replica domain controllers for fault-tolerance and load balancing.
     - Add the required schema changes for Active Directory programs.

#### Part 6: Turn off diagnostic logging

After you have finished troubleshooting and resolving the problem, turn off diagnostic logging. To do this, go to "Part 1: Turn on diagnostic logging," and follow steps 1 through 5. Set the following registry entries to 0 (zero).

- 5 Replication Events
- 7 Internal Configuration
- 8 Directory Access
- 9 Internal Processing
- 24 DS Schema

### Method 2: Resolution for Condition 3

The third cause for the "schema mismatch" error occurs when the helper domain controller has attributes in its database that are not covered by the current schema. This problem may occur if a schema object was deleted on a Windows 2000 domain controller before Service Pack 3 (SP3) for Windows 2000 was installed.

To resolve this problem, follow these steps:

1. Identify the object that has the attributes that are not in the schema. To do this, consider the following:
   - If you are running Windows 2000, the 1039 event is logged on the source domain controller with the DN of the object that was affected.
   - If you are running any other operating system, enable replication events at level five (5) on the source. During outbound replication, the object and the attribute that are being shipped will be logged. When the error occurs, look for the next object that would be shipped to the destination computer.

2. After you identify the object that has the extra attributes, do any one or more of the following:
   - Delete the object. The offending attributes will be stripped, and the tombstone will be shipped for replication.
   - Edit the object to remove the attributes in question.
   - Re-add the schema entries that were removed.
