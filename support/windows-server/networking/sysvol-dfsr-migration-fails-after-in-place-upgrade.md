---
title: SYSVOL DFSR migration fails after you in-place upgrade DC
description: Address an issue in which SYSVOL DFSR migration fails after you in-place upgrade a domain controller to Windows Server 2019.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dfsr, csstroubleshoot
---
# SYSVOL DFSR migration fails after you in-place upgrade a domain controller to Windows Server 2019

This article provides a solution to an issue where SYSVOL DFSR migration fails after you in-place upgrade a domain controller to Windows Server 2019.

_Applies to:_ &nbsp; Windows Server 2019  
_Original KB number:_ &nbsp; 4493934

## Summary

In a domain that is configured to use the File Replication Service, the SYSVOL folder is not shared after you in-place upgrade a Windows Server 2019-based domain controller from an earlier version of Windows. Until this directory is shared, the domain controller does not respond to DCLOCATOR requests for LDAP, Kerberos, and other DC workloads.

## Symptoms

In a domain that uses the legacy File Replication Service for SYSVOL, you in-place upgrade a domain controller to Windows Server 2019.

When you try to migrate the domain to Distributed File System (DFS) Replication, the following issues occur:

- All Windows Server 2019-based domain controllers in the domain stop sharing the SYSVOL folder and stop responding to DCLOCATOR requests.
- All Windows Server 2019-based domain controllers in the domain have the following event log errors:

    > Log Name:      DFS Replication  
    Source:        DFSR  
    Date:         \<time>  
    Event ID:      8013  
    Task Category: None  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:     \<fqdn>  
    Description:  
    DFSR was unable to copy the contents of the SYSVOL share located at C:\\Windows\\SYSVOL\domain to the SYSVOL_DFSR folder located at C:\\Windows\\SYSVOL_DFSR\\domain. This could be due to lack of availability of disk space or due to sharing violations.
    >
    > Additional Information:  
    > Sysvol NTFRS folder: C:\\Windows\\SYSVOL\\domain  
    Sysvol DFSR folder: C:\\Windows\\SYSVOL_DFSR\\domain  
    Error: 367 (The process creation has been blocked.)  

    > Log Name:      DFS Replication  
    Source:        DFSR  
    Date:          *\<DateTime>*  
    Event ID:      8028  
    Task Category: None  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:     \<fqdn>  
    Description:  
    DFSR Migration was unable to transition to the 'PREPARED' state for Domain Controller \<computer name>. DFSR will retry the next time it polls the Active Directory. To force an immediate retry, execute the command 'dfsrdiag /pollad'.  
    Additional Information:  
    Domain Controller: \<computer name>  
    Error: 367 (The process creation has been blocked.)

The `DFSRMIG.EXE /GetMigrationState` command generates the following output for all Windows Server 2019 domain controllers:

> Dfsrmig /getmigrationstate  
The following domain controllers have not reached Global state ('Prepared'):
>
> Domain Controller (Local Migration State) - DC Type  ===================================================  
\<Computer name>('Start') - Writable DC
>
> Migration has not yet reached a consistent state on all domain controllers.  
State information might be stale due to Active Directory Domain Services latency.

> [!NOTE]
> The global state can be **Prepared**, **Redirected**, or **Eliminated**, depending on which global state you set previously.

## Cause

The File Replication Service (FRS) was deprecated in Windows Server 2008 R2 and is included in later operating system releases for backwards compatibility only. Starting in Windows Server 2019, promoting new domain controllers requires the DFS Replication (DFSR) to replicate the contents in the SYSVOL share. If you try to promote a Windows Server 2019-based computer in a domain that still using FRS for SYSVOL replication, the following error occurs:

> Verification of prerequisites for Domain Controller promotion failed. The specified domain `contoso.com` is still using the File Replication Service (FRS) to replicate the SYSVOL share. FRS is deprecated. The server being promoted does not support FRS and cannot be promoted as a replica into the specified domain. You MUST migrate the specified domain to use DFS Replication using the DFSRMIG command before continuing. For more information, see `https://go.microsoft.com/fwlink/?linkid=849270`

Because of a code defect, in-place upgrading a Windows Server 2012 R2 or Windows Server 2016 domain controller to Windows Server 2019 does not enforce this block. When you then run `DFSRMIG.EXE /SetGlobalState` to migrate to DFSR, all upgraded Windows Server 2019 domain controllers are stuck in the **Start** phase and cannot complete the transition to the **Prepared** or later phases. Therefore, the SYSVOL and NETLOGON folders for the domain controllers are no longer shared, and the domain controllers stop responding to location questions from clients in the domain.

## Workaround

There are several workarounds for this issue, depending on which migration global state you specified earlier.

### Issue occurs in the Preparing or Redirecting phase

1. If you have already run `DFRSMIG /SetGlobalState 1` or `DFRSMIG /SetGlobalState 2` previously, run the following command as a Domain Admin:

    ```console
    DFRSMIG /SetGlobalState 0
    ```

2. Wait for Active Directory replication to propagate throughout the domain, and for the state of Windows Server 2019 domain controllers to revert to the **Start** phase.

3. Verify that SYSVOL is shared on those domain controllers and that SYSVOL is replicating as usual again by using FRS.

4. Make sure that at least one Windows Server 2008 R2, Windows Server 2012 R2, or Windows Server 2016 domain controller exists in that domain. Verify all Active Directory partitions and the files in the SYSVOL are fully sourced from one or more source domain controllers and that they are replicating Active Directory as usual before you demote all of your Windows Server 2019 domain controllers in the next step. For more information, see [Troubleshooting Active Directory Replication Problems](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshooting-active-directory-replication-problems).

5. Demote all Windows Server 2019-based domain controllers to member servers. This is a temporary step.

6. Migrate SYSVOL to DFSR normally on the remaining Windows Server 2008 R2, Windows Server 2012 R2, and Windows Server 2016 domain controllers.

7. Promote the Windows Server 2019-based member servers to domain controllers.

### Issue occurs in the Eliminating phase

The FRS elimination phase cannot be rolled back by using DFSRMIG. If have already specified FRS elimination, you can use either of the following workarounds.

#### Option 1

You still have one or more Windows Server 2008 R2, Windows Server 2012 R2, or Windows Server 2016 domain controllers in that domain. Verify all Active Directory partitions and the files in the SYSVOL are fully sourced from one or more source domain controllers and that they are replicating Active Directory as usual before you demote all of your Windows Server 2019 domain controllers in the next step. For more information, see [Troubleshooting Active Directory Replication Problems](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshooting-active-directory-replication-problems).

1. Demote all Windows Server 2019-based domain controllers. This is a temporary step.
2. Migrate SYSVOL to DFSR as usual on the remaining Windows Server 2008 R2, Windows Server 2012 R2, and Windows Server 2016 domain controllers.
3. Promote the Windows Server 2019-based member servers to domain controllers.

#### Option 2

All domain controllers in the domain are running Windows Server 2019.

> [!NOTE]
>
> - Step 6 of this workaround requires the promotion of at least one Windows Server 2008 R2, Windows Server 2012 R2, or Windows Server 2016 DC.
> - Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. In the ADSIEDIT.MSC tool, change the following distinguished name value and attribute on the PDC Emulator:  
    CN=DFSR-GlobalSettings,CN=System,DC=\<domain>,DC=\<TLD> msDFSR-Flags = 0

2. Wait for Active Directory replication to propagate throughout the domain.

3. On all Windows Server 2019 domain controllers, change the DWORD type registry value **Local State** to **0**:

    - Registry setting: Local State
    - Registry path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DFSR\Parameters\SysVols\Migrating SysVols`
    - Registry value: 0
    - Data type: REG_DWORD

4. On all Windows Server 2019 domain controllers, restart the following services by running the following commands:

    ```console
    net stop netlogon & net start netlogon
    net stop DFSR & net start DFSR
    ```

5. Verify that SYSVOL has shared on those domain controllers and that SYSVOL is replicating as usual again by using FRS.

6. Promote one or more Windows Server 2008 R2, Windows Server 2012 R2, or Windows Server 2016 domain controllers in that domain. Verify all Active Directory partitions and the files in the SYSVOL are fully sourced from one or more source domain controllers and that they are replicating Active Directory as usual before you demote all of your Windows Server 2019 domain controllers in the next step. For more information, see [Troubleshooting Active Directory Replication Problems](/windows-server/identity/ad-ds/manage/troubleshoot/troubleshooting-active-directory-replication-problems).

7. Demote all Windows Server 2019-based domain controllers to member servers. This is a temporary step.

8. Migrate SYSVOL to DFSR as usual on the remaining Windows Server 2008 R2, Windows Server 2012 R2, and Windows Server 2016 domain controllers.

9. Promote the Windows Server 2019-based member servers to domain controllers.

10. Optional: Demote the Windows Server 2008 R2, Windows Server 2012 R2, or Windows Server 2016 DC that you added in step 6.

## References

For more information about how to migrate FRS to DFSR for SYSVOL, see the following articles:

- [Migrate SYSVOL replication to DFS Replication](/windows-server/storage/dfs-replication/migrate-sysvol-to-dfsr)

- [SYSVOL Replication Migration Guide: FRS to DFS Replication (downloadable)](https://www.microsoft.com/download/details.aspx?id=4843)

- [Streamlined Migration of FRS to DFSR SYSVOL](https://techcommunity.microsoft.com/t5/storage-at-microsoft/streamlined-migration-of-frs-to-dfsr-sysvol/ba-p/425405)
