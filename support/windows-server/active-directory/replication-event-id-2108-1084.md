---
title: Active Directory replication event ID 2108 and 1084
description: Documents steps to troubleshoot and to resolve two specific events on domain controllers.
ms.date: 05/23/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, sagiv
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Active Directory replication event IDs 2108 and 1084 occur during inbound replication of Active Directory Domain Services

This article provides a solution to an issue where you get event IDs 2108 and 1084 when inbound replication of the Active Directory Domain Services (AD DS) occurs.

_Applies to:_ &nbsp; Supported versions of Windows Server  
_Original KB number:_ &nbsp; 837932

## Symptoms

When inbound replication of the Active Directory Domain Services (AD DS) occurs, a destination domain controller logs the following events in the Directory Service log:

```output
Event ID 1084: Internal event: Active Directory Domain Services could not update the following object with changes received from the following source directory service. This is because an error occurred during the application of the changes to Active Directory Domain Services on the directory service.
Object: CN=<cn path>  
Object GUID: <objectguid>  
Source directory service: NTDSA._msdcs.<forest root DNS domain name>  
Synchronization of the directory service with the source directory service is blocked until this update problem is corrected.  
This operation will be tried again at the next scheduled replication.  
User Action:  
Restart the local computer if this condition appears to be related to low system resources (for example, low physical or virtual memory).  
Additional Data:  
Error value: <error code> <error string>
```

> [!NOTE]
> In the Error value text, <error code> and <error string> represent the actual values that are shown in the log entry.

```output
Event ID 2108: This event contains REPAIR PROCEDURES for the 1084 event which has previously been logged. This message indicates a specific issue with the consistency of the Active Directory Domain Services database on this replication destination. A database error occurred while applying replicated changes to the following object. The database had unexpected contents, preventing the change from being made.  
Object: CN=<cn path>  
Object GUID: <objectguid>   
Source directory service: NTDSA._msdcs.<forest root DNS domain name>
```

> [!NOTE]
> This is a partner event to Event 1084.

## Cause

These events occur when the domain controller cannot write a transactional change to the local copy of the Active Directory database.

## Resolution

To resolve this problem, follow these steps. Retry the replication operation after each step that makes a change.

1. Make sure that sufficient free disk space is available on the volumes that host the Active Directory database, and then retry the operation. Follow these steps to free additional disk space:

    1. Move unrelated files to another volume.

    2. Perform a system state backup. This process reduces the size of the transaction log files. For more information, see [How to use the backup feature to back up and restore data](https://support.microsoft.com/help/326216).
   
    3. Perform an offline defragmentation of Active Directory. For more information, see [How to perform offline defragmentation of the Active Directory database](https://support.microsoft.com/help/232122).

2. Make sure that the physical drives that host the Ntds.dit file and the transaction log files do not have NTFS file system compression turned on. To confirm this, right-click the drive letter in My Computer, and then make sure that the **Compress drive to save disk space** check box is not selected.

3. Make sure that the physical drives that host the Ntds.dit file and the transaction log files are specifically excluded from remote and local antivirus programs. For more information, see:

- [Microsoft Defender Antivirus exclusions on Windows Server](/defender-endpoint/configure-server-exclusions-microsoft-defender-antivirus)  
- [Virus scanning recommendations for Enterprise computers that are running Windows or Windows Server (KB822158)](https://support.microsoft.com/topic/virus-scanning-recommendations-for-enterprise-computers-that-are-running-windows-or-windows-server-kb822158-c067a732-f24a-9079-d240-3733e39b40bc)

4. If the destination domain controller contains the global catalog, and the error occurs in one of the read-only partitions, use one of the following methods to help resolve the problem:

    - Method 1: Use the rehost option of the Repadmin.exe tool to rehost the affected partition.

        The Repadmin.exe tool is installed on computers that have the domain controller role, and is installed together with the Remote Server Administration Tools (RSAT) on member workstations and servers. To do this, type the following at a command prompt, where **domain_controller** is the name of the destination domain controller, and **good_source_domain_controller_name** is the name of another domain controller:

        ```console
        repadmin /rehost domain_controller naming_context good_source_domain_controller_name
        ```

    - Method 2: Configure the domain controller so that it is no longer a global catalog server. Follow these steps:

        1. Click **Start**, point to **Administrative Tools**, and then click **Active Directory Sites and Services**.
        2. Locate the **Default-First-Site-Name**\ **Servers**\ **domain_controller_name**\ **NTDS Settings** subtree.
        3. Right-click **NTDS Settings**, and then click **Properties**.
        4. Click to clear the **Global Catalog** check box, and then click **OK**.

    - Method 3

        If the error occurs in a program partition, use the Ntdsutil.exe tool to change the replica that hosts the program partition.

5. Use a third-party utility, such as the ProcMon utility, to determine whether a program or a user is accessing the Active Directory database, the transaction log files, or the Edp.tmp file. If file access activity exists, stop the services that are responsible for the activity. For more information about the ProcMon utility, see [ProcMon](/sysinternals/downloads/procmon).

6. Determine whether the problem is related to the parent of the Active Directory object on the destination domain controller. To do this, follow these steps:

    1. On the source domain controller, temporarily move the object that is referenced in Event 1084 to an organizational unit (OU) container. The OU must be unrelated to the current container. For example, move the object to a new container off the root of the domain.

    2. If replication is completed after you move the object, move the object back to its original container.

    3. Force the security descriptor propagator to rebuild the object container ancestry in the database that exists on both the source and destination domain controllers. To do this, follow these steps:
   
        1. Open an elevated command prompt on the DC or Windows client with RSAT installed.
            
        2. Type *ldp.exe <DC Name>* and press <kbd>Enter</kbd>.
            
        3. Select **Connection** > **Connect**, and then type the name of the server that you want to connect to.

            > [!NOTE]
            > You will connect over port 389 for Active Directory.
        4. Select **Connection** > **Bind**, and then type your administrative user name, password, and domain. (You must use domain administrator or enterprise administrator credentials.) Select **OK**.

        5. On the **Browse** menu, select **Modify**. Leave the **DN** text box blank. In the **Attribute** text box, type **FixUpInheritance**. Select **Yes** in the **Value** text box.

        6. In the **Operation** area, select **Add**.

        7. Select **Enter** to populate the **Entry List** area.

            > [!NOTE]
            > In the **Entry List** area, **[Add]fixupinheritance:yes** appears.

        8. Select **Run**.

            > [!NOTE]
            > The right pane now shows a **Modified** status, and the security descriptor propagator starts. The runtime for the security descriptor propagator depends on the size of the Active Directory database. The process is complete when the **DS Security Propagation Events** counter in the NTDS Performance object returns to zero.

        9. Select **Close** > **Connection**, and then select **Exit**.

7. On the source domain controller, type `repadmin /showmeta distinguished_name_path` at a command prompt, and then view the object metadata for the distinguished name path that is referenced in Event 1084. Repeat this step on the destination domain controller. Look for inconsistent values that include, but are not limited to, the following:

   - Incorrect names and numbers of attributes that appear on the object
   - Incorrect originating time or date stamps
   - Incorrect local update sequence numbers (USN)
  
    Incorrect values may indicate a problem with the database page that hosts the object.

    To use the Repadmin.exe tool when the distinguished name path refers to a live object, type the following at a command prompt:

    ```console
    repadmin /showmeta remote_domain_controller_name distinguished_name_path_of_reference _object
    ```

    If the object is in a deleted objects container or if you cannot use the Repadmin.exe tool to find the object, use the object's GUID reference to find the object. This GUID is referenced in Event 1084. To do this, type the following at a command prompt:

    ```console
    repadmin /showmeta remote_domain_controller_name "GUID_for_the_object that_is_referenced_in_Event_ID_1084"
    ```

    For example, if Event 1084 and Event 2108 reference an object where the GUID is b49cd496-98a2-4500-bb08-58550c2f79ac, type `repadmin /showmeta "<GUID=b49cd496-98a2-4500-bb08-58550c2f79ac>"`.

    > [!NOTE]
    > The quotation marks and brackets are required.

8. Use the *Ntdsutil.exe* tool to perform an integrity check of the Active Directory database on the source domain controller.

    Before you start the computer in Directory Services Restore Mode (DSRM), obtain the password for the offline administrator account, and DSRM account password. If your DSRM account passwords are managed by [Windows LAPS](/windows-server/identity/laps/laps-concepts-overview), obtain the password using [Get-LapsADPassword](/powershell/module/laps/get-lapsadpassword?view=windowsserver2022-ps).
 
    If you don't know the administrator account password, reset the Directory Services Restore Mode password before you start in this mode.
   
    Use the Ntdsutil Set Directory Services Restore Mode Password command.
   
    For more information about how to change the password, see ["Directory Services cannot start" error message when you start your Windows-based or SBS-based domain controller](https://support.microsoft.com/help/322672).
   
9. Restart the source domain controller, and then press <kbd>F8</kbd> to start Directory Services Restore Mode. At the command prompt, type `ntdsutil files integrity`, and then press <kbd>Enter</kbd>.

      > [!NOTE]
      > This command confirms the integrity of the database.

    - If the Ntdsutil tool reports that the database is corrupted, and you have replicas of the naming contexts on the source domain controller, force a demotion of the source domain controller, and then re-promote it after you verify the integrity of the drivers, the firmware, and the physical drives that host the Active Directory database and the transaction log files.
  
    - If the database is corrupted, and no replicas of the naming context on the source domain controller exist, restore the newest system state. Use the NTDSutil.exe tool to confirm the integrity of the database again. If you still receive a corruption message, restore older backups until you can confirm the integrity of the domain controller.

    - If the database is still corrupted, restore the most recent system state backup, and then, at a command prompt, type:

      ```console
      ntdsutil files recover
      ```

      Use the NTDSutil.exe tool confirm the integrity of the database again. If the database passes the integrity check, perform an offline defragmentation of the disk partition. For more information, see [How to perform offline defragmentation of the Active Directory database](https://support.microsoft.com/help/232122).

      To perform an integrity check of the database, type the following at a command prompt, and then press Enter, where **database_name** is the name of the Active Directory database:

        ```console
        esentutl.exe /g database_name
        ```

       Finally, use the Start Windows Normally option to restart the computer, and then retry replication from the source domain controller to the affected destination domain controller. If the database fails the integrity check, the domain controller must be discontinued. You use the Active Directory Migration Tool (ADMT) to migrate objects. You can also use the Ldifde.exe and Csvde.exe tools to export objects that you will import to a new destination domain controller.
     
      For more information about how to use the Ldifde.exe and Csvde.exe tools, see [Step-by-Step Guide to Bulk Import and Export to Active Directory](/previous-versions/windows/it-pro/windows-2000-server/bb727091(v=technet.10)).

10. If these steps do not succeed, and the replication error continues, demote the domain controller, confirm the integrity of the physical drives and the volumes that host the Ntds.dit file and the disk subsystem, and then promote the domain controller again. Use the same computer name.

11. Use the ntdsutil files compact command to perform an offline defragmentation of the Active Directory database. For more information, see [Performing offline defragmentation of the Active Directory Database ](https://support.microsoft.com/help/232122).

12. At the command prompt, type the following command, and then press <kbd>Enter</kbd>:

   ```console
   ntdsutil "semantic database analysis" "go"
   ```
   
   > [!NOTE]
   > The quotation marks in this example are required to run the semantic database analysis command by using a single command line argument.
   
   If errors are reported, type `ntdsutil go fixup`, and then press <kbd>Enter</kbd>.
   
   > [!NOTE]
   > The semantic database commands do not perform lossy repairs on Active Directory databases such as the pre-Windows Server 2003 Service Pack 1 Ntdsutil File Repair or `Esentutl /p` commands.
   [!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
   
## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
