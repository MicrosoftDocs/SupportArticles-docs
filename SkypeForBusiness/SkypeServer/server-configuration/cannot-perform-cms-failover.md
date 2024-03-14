---
title: Can't perform a CMS failover in Skype for Business Server 2015
description: Fixes an issue in which the Invoke-CsManagementServerFailover cmdlet fails in Skype for Business Server 2015.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Server 2015
ms.date: 03/31/2022
---

# Can't perform a CMS failover in Skype for Business Server 2015

## Symptom

You can't run the [Invoke-CsManagementServerFailover](/powershell/module/skype/Invoke-CsManagementServerFailover) cmdlet to perform a Central Management Store (CMS) failover (failback) after another failover is performed. This issue occurs in one of the following scenarios: 

### Scenario 1

Assume that you perform a force failover because one of the pools is unavailable. After pool functionality is restored, you try to execute another failover operation by running the **Invoke-CsManagementServerFailover** cmdlet, and you receive the following error messages: 

**###50020:XDSForceReplication: This central management store is being moved to another location. No changes can be made until this move is complete**

**"WARNING: The Central Management Store database in Active Directory doesn't match the one in the topology"** 

### Scenario 2

This issue occurs when you perform the second failover immediately after the previous failover, and the pool isn't yet in a consistent state. When you try to run the **Invoke-CsManagementServerFailover** cmdlet, you receive the following error messages: 

**Invoke-CsManagementServerFailover: Cannot fail over the Central Management Server. The new Central Management Store located at "skypepool.contoso.com" is not in Backup mode.**

**Invoke-CSManagementServerFailover: Central Management Server cannot be moved to pool skypepool.contoso.com because either a previous failover attempt failover or there is already a failover in progress. If the central management server was recently moved to another pool this condition might be caused by a delay in Active Directory Replication** 

### Scenario 3

The ActiveMasterFqdn status is blank when you run the **[Get-CsManagementStoreReplicationStatus –CentralManagementStoreStatus](/powershell/module/skype/Get-CsManagementStoreReplicationStatus)** cmdlet. 

## Cause

### Scenario 1

If the main pool is unavailable, the CMS status that's persisted into databases will still be set as active. When pool functionality is restored, Backup services may take longer to mark the CMS as in Backup mode, CMS replication may fail, and a failover may be blocked. 

### Scenario 2

If a failover isn't completed and another failover is performed immediately after, the CMS could be marked either as in active or Backup mode due to a race condition issue. 

### Scenario 3

This scenario can occur as side effect of either scenario 1 or scenario 2. 

## Resolution

To fix this issue, follow these steps: 
 
1. Check whether the following services are started in both pools:  
  - Skype for Business Server Backup Service     
  - Skype for Business Master Replicator Agent     
  - Skype for Business Replica Replicator Agent     
  - Skype for Business File Transfer Agent     
2. In the Skype for Business Server Management Shell, run the **[Get-CsManagementConnection](/powershell/module/skype/Get-CsManagementConnection)** cmdlet and identify which pool is currently associated to the SQL Server store that's returned by the SQL Server output.     
3. On one of the servers that's associated with the identified pool, run the **Invoke-CsManagementServerFailover -Restore** cmdlet in the Skype for Business Server Management Shell.     
4. On each server of the identified pool, run the following cmdlets in sequence in the Skype for Business Server Management Shell:  
   - **Export-CsConfiguration -FileName c:\temp\configuration.zip**     
   - **Import-CsConfiguration -FileName c:\temp\configuration.zip -LocalStore**     
 
    > [!NOTE]
    > After the process is complemented, the configuration.zip file can be deleted, although we recommend that you keep a copy of the file for disaster recovery.    
5. On each server of the previously identified pool, run the **[Invoke-CsManagementStoreReplication](/powershell/module/skype/Invoke-CsManagementStoreReplication)** cmdlet in the Skype for Business Server Management Shell.     
6. Run the Invoke-CsManagementServerFailover cmdlet to perform a CMS failover again.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).