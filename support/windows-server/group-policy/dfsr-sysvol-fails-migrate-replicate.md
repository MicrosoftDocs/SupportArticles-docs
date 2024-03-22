---
title: Distributed File System Replication (DFSR) SYSVOL fails to migrate or replicate
description: Provides a solution to issues where DFSR SYSVOL fails to migrate or replicate, or SYSVOL isn't shared.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Group Policy\Sysvol access or replication issues, csstroubleshoot
---
# DFSR SYSVOL fails to migrate or replicate, SYSVOL not shared, Event IDs 8028 or 6016

This article provides a solution to issues where Distributed File System Replication (DFSR) `SYSVOL` fails to migrate or replicate, or `SYSVOL` isn't shared.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2567421

## Symptoms

**Scenario 1:** After starting a `SYSVOL` migration from File Replication Service (FRS) to DFSR, no domain controllers enter the Prepared phase, and remain stuck at Preparing. This issue continues even after you verify that Active Directory (AD) replication has converged on all domain controllers. The issue continues even on DCs in the same AD site as the PDCE, where AD replication occurs every 15 seconds and where you have run **DFSRDIAG.EXE POLLAD** on all the DCs.
Running the `/GETMIGRATIONSTATE` reporting command shows:

> **DFSRMIG.EXE /GETMIGRATIONSTATE**  
>
> Domain Controller (Local Migration State) - DC Type
>
> ===================================================  
2008R2-MIG-01 ('Preparing') - Primary DC  
**2008R2-MIG-02 ('Preparing') - Writable DC**  
Migration has not yet reached a consistent state on all Domain Controllers.  
State information might be stale due to AD latency.

Examining the DFS Replication event sign in the Primary Domain Controller (PDC) Emulator shows:

```output
Log Name: DFS Replication  
Source: DFSR  
Date: <DateTime> 
Event ID: 8028 
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: 2008r2-mig-01.cohowinery.com  
Description:  
DFSR Migration was unable to transition to the 'PREPARED' state for Domain Controller 2008R2-MIG-01. DFSR will retry the next time it polls the Active Directory. To force an immediate retry, execute the command 'dfsrdiag /pollad'.
Additional Information:
Domain Controller: 2008R2-MIG-01
Error: 5 (Access is denied.)
```

Examining the DFSR Debug sign in the PDCE shows:

```output
<DateTime> 1524 CFAD  2836 Config::AdObjectEditor::AddObject Add cn=DFSR-LocalSettings,CN=2008R2-MIG-01,OU=Domain
Controllers,DC=cohowinery,DC=com
<DateTime> 1524 ADWR   633
Config::AdWriter::CreateSysVolLocalObjectsOnLocalDc [SYSVOL] Local settings object already exists.
<DateTime> 1524 ADWR   655
Config::AdWriter::CreateSysVolLocalObjectsOnLocalDc [SYSVOL] Got Local Setting's SD for adding ACE
<DateTime> 1524 ADWR   678
Config::AdWriter::CreateSysVolLocalObjectsOnLocalDc [SYSVOL] Going to set new SD
<DateTime> 1524 CFAD  2570 [ERROR] Config::AdAttrEditor::ModifyValue Failed to ldap_modify_s(). dn:cn=DFSR-LocalSettings,CN=2008R2-MIG-01,OU=Domain Controllers,DC=cohowinery,DC=com Error:Insufficient Rights
<DateTime> 1524 SYSM   586 [ERROR] Migration::SysvolMigrationTask::Step [MIG] Failed Migration task.Error:
+ [Error:5(0x5) Migration::SysVolMigration::Migrate migrationserver.cpp:1200 1524 W Access is denied.] 
+ [Error:5(0x5) Migration::SysVolMigration::StepToNextStableState migrationserver.cpp:1271 1524 W Access is denied.]
+ [Error:5(0x5) Migration::SysVolMigration::Prepare migrationserver.cpp:1431 1524 W Access is denied.]
+ [Error:5(0x5) Migration::SysVolMigration::CreateLocalAdObjects migrationserver.cpp:2694 1524 W Access is denied.]
+ [Error:5(0x5) Config::AdWriter::CreateSysVolMigrationLocalObjects adwriterserver.cpp:1965 1524 W Access is denied.]
+ [Error:5(0x5) Config::AdWriter::CreateSysVolLocalObjectsOnLocalDc adwriterserver.cpp:726 1524 W Access is denied.]
+ [Error:5(0x5) Config::AdAttrEditor::ReplaceValue ad.cpp:2702 1524 W Access is denied.]
+ [Error:5(0x5) Config::AdAttrEditor::ModifyValue ad.cpp:2578 1524 W Access is denied.]
+ [Error:50(0x32) Config::AdAttrEditor::ModifyValue ad.cpp:2578 1524 U Insufficient Rights]
```

**Scenario 2:** A domain already replicates `SYSVOL` using DFSR. When a new DC is promoted, it fails to replicate `SYSVOL`, and the `SYSVOL` and `NETLOGON` shares aren't created.

Examining the DFS Replication event sign in that new DC shows:

```output
Log Name: DFS Replication
Source: DFSR
Date: <DateTime>
Event ID: 6016
Task Category: None
Level: Warning
Keywords: Classic
User: N/A
Computer: 2008-R2-TSPDC2.tailspintoys.com
Description:
The DFS Replication service failed to update configuration in Active Directory Domain Services. The service will retry this operation periodically.

Additional Information:
Object Category: msDFSR-LocalSettings
Object DN: CN=DFSR-LocalSettings,CN=2008-R2-TSPDC2,OU=Domain Controllers,DC=tailspintoys,DC=com**  
Error: 5 (Access is denied.)
Domain Controller: 2008-R2-TSPDC1.tailspintoys.com
Polling Cycle: 60
```

Examining the DFSR Debug sign in that DC shows:

```output
<DateTime> 1712 CFAD  2836 Config::AdObjectEditor::AddObject Add cn=DFSR-LocalSettings,CN=2008-R2-TSPDC2,OU=Domain Controllers,DC=tailspintoys,DC=com
<DateTime> 1712 ADWR   633 Config::AdWriter::CreateSysVolLocalObjectsOnLocalDc [`SYSVOL`] Local settings object already exists.
<DateTime> 1712 ADWR   655 Config::AdWriter::CreateSysVolLocalObjectsOnLocalDc [`SYSVOL`] Got Local Setting's SD for adding ACE
<DateTime> 1712 ADWR   678 Config::AdWriter::CreateSysVolLocalObjectsOnLocalDc [`SYSVOL`] Going to set new SD
<DateTime> 1712 CFAD  2570 [ERROR] Config::AdAttrEditor::ModifyValue Failed to ldap_modify_s(). dn:cn=DFSR-LocalSettings,CN=2008-R2-TSPDC2,OU=Domain Controllers,DC=tailspintoys,DC=com Error:Insufficient Rights
<DateTime> 1712 CFAD 11508 [ERROR] Config::AdReader::Read [SYSVOL] (Ignored) Failed to create SysVol objects, Error:
+ [Error:5(0x5) Config::AdWriter::CreateSysVolObjects adwriterserver.cpp:1360 1712 W Access is denied.]  
+ [Error:5(0x5) Config::AdWriter::CreateSysVolObjectsWithParams adwriterserver.cpp:1457 1712 W Access is denied.]
+ [Error:5(0x5) Config::AdWriter::CreateSysVolLocalObjectsOnLocalDc adwriterserver.cpp:726 1712 W Access is denied.]
+ [Error:5(0x5) Config::AdAttrEditor::ReplaceValue ad.cpp:2702 1712 W Access is denied.]
+ [Error:5(0x5) Config::AdAttrEditor::ModifyValue ad.cpp:2578 1712 W Access is denied.]
+ [Error:50(0x32) Config::AdAttrEditor::ModifyValue ad.cpp:2578 1712 U Insufficient Rights]
```

Examining the DFSR debug sign in the PDCE shows:

```output
<DateTime> 1792 CFAD  6160 [ERROR]   Config::AdSnapshot::BuildPartnersSubTree Failed to create computer tree for partner:CN=2008-R2-TSPDC2,CN=Topology,CN=Domain System Volume,CN=DFSR-GlobalSettings,CN=System,DC=tailspintoys,DC=com, Error:  
+ [Error:1168(0x490) Config::AdSnapshot::BuildPartnerComputerSubTree ad.cpp:6018 1792 W Element not found.] 
+ [Error:1168(0x490) Config::AdSnapshot::BuildLocalSettingsTree ad.cpp:6408 1792 W Element not found.]  
+ [Error:1168(0x490) Config::AdSnapshot::GetSubscriber ad.cpp:4112 1792 W Element not found.]  
+ [Error:1168(0x490) Config::AdSnapshot::GetSubscriber ad.cpp:4108 1792 W Element not found.]
```

## Cause

The default user rights assignment "Manage Auditing and Security Log" (SeSecurityPrivilege) has been removed from the built-in Administrators group. Removal of this user right from Administrators on domain controllers isn't supported. It will cause DFSR `SYSVOL` migration to fail. DFSR migration and must be run by a user who is a member of the built-in Administrators group in that domain. All DCs are automatically members of the built-in Administrators group.

## Resolution

To resolve the issue, follow all steps in the order, using an elevated CMD prompt while running as a Domain Admin:

**Scenario 1:**

1. Determine which security group policy is applying this setting to the DCs by running on the PDCE:

    ```console
    GPRESULT.EXE /H secpol.htm
    ```

2. Open **secpol.htm** in a web browser then select **Show All**. Search for the entry **Manage Auditing and Security Log**. It will list the group policy that is applying this setting.
3. Using **GPMC.MSC**, edit that group policy to include the group **Administrators**.
4. Allow AD and `SYSVOL` replication to converge on all DCs. On the PDCE, run:

    ```console
    GPUPDATE /FORCE
    ```

5. Sign out the PDCE and log back on, to update your security token with the user right assignment.
6. Run:

    ```console
    DFSRMIG.EXE /CREATEGLOBALOBJECTS
    ```

7. Allow AD and `SYSVOL` replication to converge on all DCs. On the PDCE, run:

    ```console
    DFSRDIAG.EXE POLLAD
    DFSRMIG.EXE /GETMIGRATIONSTATE
    ```
  
8. Validate that some or all of the DCs have reached the Prepared state and are ready to redirect. At this point, you can proceed with your migration normally. See the [More information](#more-information) section below.

**Scenario 2:**

1. Determine which security group policy is applying this setting to the DCs by running on the PDCE:

    ```console
    GPRESULT.EXE /H secpol.htm
    ```

2. Open **secpol.htm** in a web browser, then select **Show All**. Search for the entry **Manage Auditing and Security Log**. It will list the group policy that is applying this setting.
3. Using **GPMC.MSC**, edit that group policy to include the group **Administrators**.
4. Allow AD and `SYSVOL` replication to converge on all DCs. On the affected DC, run:

    ```console
    GPUPDATE /FORCE
    ```

5. Restart the DFSR service on that DC.
6. Validate that the DC now shares `SYSVOL` and NETLOGON, and replicates `SYSVOL` inbound.

The `sysvol` may not be shared on any of the DCs. Which will prevent you from editing or applying Group Policy. As a workaround you can manually share the `sysvol`, edit the User Right "Manage Auditing and Security Log" and force a GP update.

Steps:

1. Manually share the `sysvol` - Edit this registry value
    `Key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\parameters`  
    Value `SysvolReady` = 1  
    run net share to make sure the `sysvol` is shared out.
1. Open the policy and add the user or group to the "manage auditing and security log" user right.
1. Run:

    ```console
    gpupdate force.
    ```

    > [!NOTE]
    > You may have to share the sysvol again at step 3 as a background process from `SYSVOL` migration may unshared it before you're done editing the policy
1. Continue with scenario 1 or 2 as noted above.

It's possible for DFSRMIG to successfully update AD but fail to update the Registry. If the AD updates are done successfully to create the sysvol replication group but the registry changes the DFSR service aren't made because of missing user rights, you'll only see events 8010 that the migration is underway.

## More information

It's normal for DCs to remain the Preparing state for an extended period of time during a migration, especially in larger environments where AD replication may take several hours or days to converge. It isn't normal for them to remain in that state even after AD replication has reached those DCs and 15 minutes has passed for DFSR AD Polling.

Don't share `SYSVOL` and NETLOGON manually to work around this issue. Don't set `SYSVOLREADY=1` to work around this issue. Doing so will cause the DC to contact itself for group policy. Since it can't populate its `SYSVOL`, any changes to fix the user rights won't be applied.

For more information on lowering the AD Replication convergence time using Inter-site Change Notification, see [Appendix B - Procedures Reference](/previous-versions/windows/it-pro/windows-2000-server/bb727062(v=technet.10)).

For more information on `SYSVOL` migration from FRS to DFSR, see [Migrate SYSVOL replication to DFS Replication](/windows-server/storage/dfs-replication/migrate-sysvol-to-dfsr).
