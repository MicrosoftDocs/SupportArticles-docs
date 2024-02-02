---
title: How to rebuild the SYSVOL tree and its content in a domain
description: Describes how to use the Burflags registry value to rebuild each domain controller's copy of the system volume tree (SYSVOL) on all domain controllers in a common Active Directory domain.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:sysvol-access-or-replication-issues, csstroubleshoot
---
# How to rebuild the SYSVOL tree and its content in a domain

The article describes how to use the Burflags registry entry to rebuild each domain controller's copy of the system volume (SYSVOL) tree on all domain controllers in a common Active Directory directory service domain.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 315457

## Introduction

The term SYSVOL refers to a set of files and folders that reside on the local hard disk of each domain controller in a domain and that are replicated by the File Replication service (FRS). Network clients access the contents of the SYSVOL tree by using the following shared folders:

- NETLOGON
- SYSVOL

We recommend the procedure that is described in this article as a last resort to restore a domain's SYSVOL tree and its contents. Use this procedure only if you can't make the FRS functional on individual domain controllers in the domain. Use this procedure only if the bulk restart can be performed more quickly than troubleshooting and resolving replication inconsistencies, and time to resolution is a critical factor.

> [!IMPORTANT]
> Domain controllers will not service authentication request during the procedure. Only when the SYSVOL and NETLOGON folders are shared again will the domain controller authenticate requests. This procedure should not be performed during peak hours.

> [!NOTE]
> See the [How to temporarily stabilize the domain SYSVOL tree](#how-to-temporarily-stabilize-the-domain-sysvol-tree) section of this article for information about how to temporarily stabilize the domain SYSVOL tree until you can complete all the steps in the [How to rebuild the domain SYSVOL replica set across enterprise environments](#how-to-rebuild-the-domain-sysvol-replica-set-across-enterprise-environments) section.

We strongly recommend that you monitor FRS performance and health by using monitoring tools. By using monitoring tools, you may prevent the need for replica set authoritative and non-authoritative restores. Also, by using monitoring tools, you may provide insight into the root cause of FRS failures.

The monitoring tool Ultrasound is available for download.

Ultrasound is a powerful tool that measures the functioning of FRS replica sets by providing health ratings and historical information of these sets. The Ultrasound tool is a sophisticated monitoring system that uses Windows Management Instrumentation (WMI) providers, a data collection service, a Microsoft SQL Server Desktop Engine (MSDE) database, and a powerful user interface.

## Guidelines

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Use the following guidelines to configure the Burflags registry entry:

- If you start the FRS with the Burflags registry entry set to D4, the FRS initially treats the files and folders on its local copy of the SYSVOL tree as authoritative for the replica set. Only one member of an FRS replica set should be initialized with the D4 setting.

- If you start the FRS with the Burflags registry entry set to D2, the FRS performs a full synchronization of files and folders from a direct or transitive replication partner that is hosting the authoritative copy of files and folders in the replica set.

- When you start the FRS with the Burflags registry entry set to D4, the configuration is referred to as an "authoritative restore" for the contents of an FRS replica set, even though no actual restore of the system state occurred. Think of the D4 setting as rebuilding the FRS part of the first domain controller in a new domain.

- When you start the FRS with the Burflags registry entry set to D2, the configuration is referred to as a non-authoritative restore, even though no restore of the system state occurred. Think of the D2 setting as rebuilding the FRS part of the replica domain controller as if the domain controller were new.

- After each of the authoritative or non-authoritative restored computers has completed initialization, the FRS becomes multi-master aware.

- If you set Burflags to D4 on a single domain controller and set Burflags to D2 on all other domain controllers in that domain, you can rebuild the SYSVOL tree in that domain. This bulk rebuild process is known as a hub, branch, or bulk FRS restart.

The following section lists the valid uses of a bulk restart of the SYSVOL replica set:

- The members of an FRS replica set that are currently inconsistent can perform a full synchronization of all files and folders in the SYSVOL tree faster than the members can process the backlog of changes that reside in the outgoing logs of upstream replication partners.

- Most of the members in an FRS replica set have errors, such as journal_wrap errors. For more information about journal_wrap errors, see [How to troubleshoot journal_wrap errors on Sysvol and DFS replica sets](../networking/how-frs-uses-usn-change-journal-ntfs-file-system.md).

- The ID table on most of the members of the replica set contains an incomplete description of the files that should be hosted in the replica set.

- The FRS database files are compromised because of accidental deletion, file system errors, or database file errors, including corruption that is identified by JET Database validation tools.

- Most of the members in an FRS replica set cannot replicate files and folders, and a bulk D4 or D2 configuration is a way to reinitialize all members as new members.

> [!NOTE]
>
> - If the FRS is in an error state on a single member, you can set BurFlags to D2 only on that single member.
> - If you rebuild the SYSVOL tree because of environmental problems, or if a problematic topology has affected the consistency of files and folders in an FRS replica set, you may see only temporary benefits. For example, this scenario occurs when too many downstream partners exist or excessive changes have occurred on the replicated content. In this case, we recommend that you address the root cause of any underlying problem. Otherwise, problems that first caused you to rebuild the SYSVOL tree may happen again.
> - To rebuild the SYSVOL tree, we recommend that all Windows 2000-based domain controllers in the domain have Windows 2000 Service Pack 3 (SP3) or a later version of the NTFRS.exe file installed. If your version of the NTFRS.exe file is older than Windows 2000 Service Pack 3, install the latest Windows 2000 service pack.

## How to rebuild the domain SYSVOL replica set across enterprise environments

This section describes how to rebuild the domain SYSVOL replica set across enterprise environments.

### Summary of the steps

The following list summarizes the steps that are performed in a hub or branch restart:

1. Stop the FRS on all domain controllers in the domain.

2. Move all files and folders that should reside in the SYSVOL tree to a temporary folder on the reference domain controller. The temporary folder should be located on the same partition the SYSVOL tree is located.

    When you move files within a partition, the files are not altered. Therefore, they retain their original security settings. Files or Folders that are moved partitions or copied within or between partitions inherit the security of the destination parent directory. Therefore, any custom delegations of GPO management may be lost as a result. Additionally, the access control list (ACL) on the SYSVOL part of the Group Policy object is set to inherit permissions from the parent folder. Therefore, you may receive the following error message when you open a GPO by using GPMC:

    > The Permissions for This GPO in the SYSVOL Folder Are Inconsistent with Those in Active Directory

    If you have permissions to modify security on the GPO, select **OK** when you receive this error message. This action modifies the ACLs on the Sysvol part of the Group Policy object and makes them consistent with the ACLs on the Active Directory component. In this case, Group Policy removes the inheritance attribute in the Sysvol folder.

3. Verify junction points and required folders on each domain controller in the domain.
4. Restart the FRS on the reference domain controller with the D4 registry entry set.
5. Restart the FRS on all other domain controllers in the domain with the D2 registry entry set.
6. On the reference domain controller, move all files and folders to the root folder of the replica set. By default, this folder is the C:\\Windows\\Sysvol\\Domain folder.
7. Monitor the consistency of files and folders for all domain controllers in the domain.

> [!NOTE]
> If a member of any replica set has been restarted with the Burflags registry entry set to D4, restart the FRS on all other members of the replica set with the Burflags registry entry set to D2. This configuration prevents morphed folders.

When the Burflags registry entry is set to D2 or to D4, and the FRS is restarted, the originator GUID (OrigGUID) changes. If you want to track the source of a specific activity, you can run the File Replication Service Diagnostics Tool (FRSDiag) to obtain GUID2Name before you set the Burflags registry entry.

### Detailed list of the steps

The following list shows the detailed steps that are performed in a hub or branch restart:

1. On all domain controllers in the domain, stop the FRS, and then set the service startup type value for the FRS to **Disabled**.

2. On a single domain controller, configure the SYSVOL replica set to be authoritative. This reference domain controller will contain the authoritative copy of the SYSVOL tree for all other members of the replica set. For example, other domain controllers in the domain will directly or transitively replicate from this reference domain controller.

    Choose the reference domain controller based on connectivity and physical server resources. This domain controller will be known as the "reference domain controller" in all subsequent steps.

    To configure the SYSVOL replica set to be authoritative, follow these steps:

    1. Go to **Start**, select **Run**, type *regedit*, and then select **OK**.
    2. Locate and then select the **BurFlags** entry under the following registry subkey:  
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Cumulative Replica Sets\GUID`

        GUID is the GUID of the domain system volume replica set that is shown in the following registry subkey:  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Replica Sets\GUID`
    3. Right-click **BurFlags**, and then select **Modify**.
    4. Type *D4* in the **Value Data field (HexaDecimal)**, and then select **OK**.

3. On all domain controllers in the domain, verify that the file structure and junction points are correct. You can follow these steps:

    1. Verify that the following folders exist in the SYSVOL tree:

        - \\SYSVOL
        - \\SYSVOL\\domain
        - \\SYSVOL\\staging\\domain
        - \\SYSVOL\\staging areas
        - \\SYSVOL\\domain\\Policies
        - \\SYSVOL\\domain\\scripts
        - \\SYSVOL\\SYSVOL

    2. Verify that the following reparse points exist:

        - \\SYSVOL\\SYSVOL\\**DNS Domain Name**

            This reparse point must be linked to the \\SYSVOL\\domain folder.
        - \\SYSVOL\\staging areas\\**DNS Domain Name**  

            This reparse point must be linked to the \\SYSVOL\\staging\\domain folder.

        The default path for the SYSVOL tree is under the \\WINDOWS or \\WINNT folder on the partition where the operating system is installed. However, the SYSVOL tree may be installed on any partition that is formatted by using the NTFS file system.

        Verify that each domain controller in the domain has all the required folders and that the reparse points exists. Re-create any missing folders as needed. Don't use Windows Explorer to move or copy contents of the SYSVOL tree, or the reparse points may be damaged.

The SYSVOL tree contains reparse points to other folders in the SYSVOL tree. These reparse points are in the NTFS file system. Think of a reparse point as a source folder that maps or points to a destination folder when the source folder is accessed. The contents of the reparsed folders appear as mirror images of each other.

The following two reparse points for a SYSVOL tree are installed in the C:\\WINNT\\SYSVOL folder:

- C:\\WINNT\\SYSVOL\\SYSVOL\\**DNS Domain Name**.

    This reparse point is linked to the C:\\WINNT\\SYSVOL\\domain folder.
- C:\\WINNT\\SYSVOL\\staging areas\\**DNS Domain Name**  

    This reparse point is linked to C:\\WINNT\\SYSVOL\\staging\\domain folder.

On each domain controller in the domain, follow these steps:

1. Go to **Start**, select **Run**, type *cmd*, and then select **OK**.
2. Type `net start ntfrs` to start the File Replication service.
3. Type `ntfrsutl ds |findstr /i "root stage"`, and then press ENTER. The NTFRSUTIL command returns the current root directory for the SYSVOL replica set that is referred to as the "replica set root" and the staging folder. For example, this command returns:

    ```output
    Root: C:\WINNT\SYSVOL\domain  
    Stage: C:\WINNT\SYSVOL\staging\domain
    ```

4. Type `Linkd %systemroot%\SYSVOL\SYSVOL\DNS Domain name`, and then press ENTER. The LINKD command returns the following information:

    ```output
    Source DNS Domain Name is linked to %systemroot%\SYSVOL\domain
    ```

5. Type `linkd "%systemroot%\SYSVOL\staging areas\DNS Domain Name"`, and then press ENTER. This command returns the following information:

    ```output
    Source DNS Domain Name is linked to %systemroot%\SYSVOL\Staging\domain
    ```

    > [!NOTE]
    > The path that is reported by the LINKD command varies depending on the location of the SYSVOL\\SYSVOL\\**DNS Domain Name** folder. If the SYSVOL folder is in the default location in the %systemroot%\\SYSVOL folder, use the commands that are listed. Otherwise, type the actual path of the SYSVOL folders.

    For example, if the NTFRSUTL and LINKD commands are run on a domain controller in the `contoso.com` domain, and the SYSVOL folder is in the C:\\Windows\\SYSVOL folder, the command syntax and results for the SYSVOL and Staging folders will appear similar to the following output:

    ```console
    C:\>ntfrsutl ds |findstr /i "root stage"
    ```

    Output:

    ```output
    Root: C:\windows\sysvol\domain  
    Stage: C:\windows\\sysvol\staging\domain
    ```

    ```console
    C:\>Linkd %systemroot%\SYSVOL\SYSVOL\Contoso.com
    ```

    Output:

    ```output
    Source domain.com is linked to C:\WINDOWS\SYSVOL\domain
    ```

    ```console
    C:\>linkd "%systemroot%\SYSVOL\<staging areas>\Contoso.com
    ```

    Output:

    ```output
    Source domain.com is linked to C:\WINDOWS\SYSVOL\staging\domain
    ```

    To re-create the junction points if the LINKD command reports missing or invalid junction points, follow these steps:

    1. Type `linkd C:\WINNT\SYSVOL\sysvol\DNS_Domain_Name Source`, where **Source** is the root path that is determined by using the NTFRSUTL command.
    2. Type `C:\linkd "C:\WINNT\SYSVOL\staging areas\DNS_Domain_Name" Source`, where **Source** is the stage path that is determined by using the NTFRSUTL command.

6. On all domain controllers in the domain, verify that enough staging space is available. The ratio of staging area size to data set size depends upon a range of factors.

    To determine the size of the replica set root, right-click the replica set root that uses the Winnt\\SYSVOL\\domain folder in Windows Explorer, and then select **Properties**.

    To adjust the staging folder size, follow these steps:

    1. Go to **Start**, select **Run**, type *regedit*, and then select **OK**.
    2. Locate and then select the following registry subkey:  
        `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters`
    3. Right-click **Staging Space Limit in KB**, and then select **Modify**.
    4. Select **decimal**, type the size of the staging folder in kilobytes, and then select **OK**.
    5. Quit Registry Editor.

7. On the reference domain controller, build a good set of policies and scripts, and then put them in a temporary folder outside the SYSVOL replica set folders on the FRS reference domain controller.

    To complete this step, examine Active Directory to determine the group policies that are still used and that contain orphaned data. Policy information is located in the Group Policies container. To view this container, follow these steps:

    1. Start Active Directory Users and Computers.
    2. On the **View** menu, select **Advanced Features** if it is not already selected.
    3. Expand the domain container, expand the **System** container, and then expand the **Policies** container.

        In the right pane of Active Directory Users and Computers, all the Group Policy objects (GPOs) in Active Directory are listed. There should be a one-to-one mapping between valid GPOs in Active Directory with Group Policy folders in the SYSVOL tree.

          - If the SYSVOL folder contains a folder name that has a GUID that is not listed in Active Directory, the file system contains an orphaned GPO, and you can safely delete the folder from the file system.
          - If Active Directory contains a Group Policy GUID that does not map to a GUID in the SYSVOL\\domain\\policies folder on any domain controller in the domain, you can safely delete that policy setting from Active Directory.

        > [!NOTE]
        > If any domain controller that is participating in the domain has a newer version of a Group Policy in its local SYSVOL tree, make sure that it is copied to a temporary location on the reference domain controller.

    4. On the reference domain controller, delete any files or folders that are in the FRS replica set root or in the replica set stage folders.

        For default SYSVOL replica sets, delete files and folders under the following two folders:

        - C:\\WINNT\\SYSVOL\\domain
        - C:\\WINNT\\SYSVOL\\staging\\domain

        > [!NOTE]
        > Do not delete the folders themselves.

    5. On the reference domain controller, move the policies and scripts folders and the folder contents from the temporary location that you used in step c to the FRS replica set root folder. For the SYSVOL folder, the default location for the replica set root is the  folder: C:\\WINNT\\SYSVOL\\domain.

    6. On all domain controllers except the reference domain controller, configure the FRS to be non-authoritative. You can follow these steps:

        1. Go to **Start**, select **Run**, type *regedit*, and then select **OK**.
        2. Locate and then select the **BurFlags** entry under the following registry subkey:  
            `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Cumulative Replica Sets\GUID`

            **GUID** is the GUID of the domain system volume replica set that is shown in the following registry subkey:  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Replica Sets\GUID`
        3. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
        4. Type *D2* for the name of the DWORD, and then press ENTER.

        > [!NOTE]
        > For domain controllers that are not participating in Distributed File System (DFS) replication, set the DWORD to D2 in the registry subkey for bulk modifications: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Backup/Restore\Process atStartup\BurFlags`.

    7. Quit Registry Editor.

    The FRS is instructed to reinitialize its database and to overwrite the contents of the SYSVOL tree with data from an upstream partner.

    In large sites, we recommend that you use a staggered approach to rebuilding the SYSVOL tree. This approach helps avoid overloading a single domain controller or causing the FRS to source its contents from a domain controller that has not completed its own re-sourcing of the system volume. This process involves setting the Burflags registry entry to D2 on all hub site domain controllers before proceeding to branch office or to satellite sites.

    Use the Replica Set Parent registry entry to specify a source domain controller for the D2 setting:

    - Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\SYSVOL Seeding\DOMAIN SYSTEM VOLUME (SYSVOL SHARE)`
    - Value name: Replica Set Parent
    - Value type: REG_SZ
    - Value data: The source domain controller

    > [!NOTE]
    > If this registry entry does not exist, you must create it.

    We don't recommend that a single domain controller becomes the source for more than 10 to 15 domain controllers at the same time. If you must source more than 15 domain controllers off a single source, start the FRS on only 15 downstream partners of any particular source domain controller, and then wait for them to complete sourcing the SYSVOL tree before the FRS service is started on the next group of 15 computers.

    > [!NOTE]
    >
    > - We do not recommend that more than 15 domain controllers source their contents off of a single domain controller at the same time.
    > - Incoming replication depends on a schedule that is defined on the relevant site link or on the connection object that is used by the destination domain controller that allows replication. If the replication schedule is disabled, incoming replication will be delayed.
    > - If the "Replica set parent" registry entry is used, the FRS will source data upon restart of the service, independent of the whether replication is enabled or disabled on the day or the hour that the service restart occurred. After the initial source is complete, all additional replication will be based on connection schedules. If the registry entry is not used, the FRS will initiate replication based on the schedule that is defined on the relevant site link or connection object.

8. On all domain controllers in the domain except the reference domain controller, delete any files or folders under the FRS replica set root and the replica set stage directories. For example, for default SYSVOL replica sets, delete files and folders in the following two locations:

    - C:\\WINNT\\SYSVOL\\domain
    - C:\\WINNT\\SYSVOL\\staging\\domain

    > [!NOTE]
    > Do not delete the folders themselves.

    This step enables faster replication of the SYSVOL tree for the given source. This step eliminates the need for the FRS server to move the existing contents before replicating the new data. This step is not required but it is recommended.

9. On all domain controllers in the hub site, except the reference domain controller, restart FRS, and then verify that SYSVOL and NETLOGON are shared.

    > [!NOTE]
    > The service startup type for the FRS should be set to **Automatic**.

10. On all non-reference domain controllers in the branch sites, start the FRS service and verify that SYSVOL and NETLOGON are shared.

## How to temporarily stabilize the domain SYSVOL tree

1. Stop FRS on all domain controllers in the domain and set the service to **Disabled**.

2. Manually copy the full set of policies to the following folder on each domain controller:

    \\SYSVOL\\SYSVOL\\dns domain name\\policies

    Typically, the following two policies are required for authentication:

    - Default Domain Controllers Policy{6AC1786C-016F-11D2-945F-00C04fB984F9}
    - Default Domain Policy {31B2F340-016D-11D2-945F-00C04FB984F9}

    > [!NOTE]
    > You may have to copy additional policies depending on Group Policy requirements for the environment.

3. Manually copy all necessary scripts to the following folder:

    \\SYSVOL\\SYSVOL\\DNS Domain name\\scripts
