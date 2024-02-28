---
title: HPC Management Service fails to initialize
description: Provides a solution for an issue where HPC Management Service fails to start after you restore a corrupted database
ms.date: 09/14/2022
ms.service: hpcpack
ms.reviewer: hclvteam, v-weizhu
---
# HPC Management Service fails to start after restoring database

This article provides a solution for an issue where HPC Management Service fails to start after you restore a corrupted database.

## Symptoms

After you restore a corrupted HPC management database, HPC Management Service fails to initialize. You reboot the head node and verify that all other HPC services are in running status. However, HPC Management Service still can't be started.

The following error is shown in HPC Management event logs:

> The HPC Management Service failed to initialize correctly: The instance collection of IDs cannot be resolved in the current instance view.

## Cause

HPC Management Service crashed with "InstanceCacheLoadException". Here is the error message in the HPC Management event log:

> [HPCManagement] Exception: Microsoft.SystemDefinitionModel.InstanceCacheLoadException: The instance collection of IDs cannot be resolved in the current instance view.

This issue occurs because many instances are in the wrong state. For each instance, there should be only one version in the "Current" state (instanceState value is 2). When the issue occurs, there are instances with two or three versions in the "Current" state (instanceState value is 2). To verify the number of the instance versions in the "Current" state, run the following SQL query against an HPC Management Database:

```sql
SELECT instanceId, count(*) as Number FROM Instances where instanceState = 2 group by instanceId having count(*) > 1
```

For each instanceId returned by the SQL query above, run the following SQL query:

```sql
SELECT Instances.instanceId, Instances.changeId, Instances.instanceVersion, Instances.instanceName, Instances.instanceState, Changes.changeName, Changes.changeState FROM Instances INNER JOIN Changes on Instances.changeId = Changes.changeId Where Instances.instanceId = '<instanceId>' and Instances.instanceState <> 3 Order by Instances.instanceVersion DESC
```

## Resolution

To resolve the issue, fix the instances in the wrong state. To do this, follow these steps:

1. Save the following PowerShell script as FixInstanceStateError.ps1 file.

    ```powershell
    param (
        [Parameter(Mandatory=$true)]
        [string] $ServerInstance,

        [Parameter(Mandatory=$false)]
        [string] $Database = "HpcManagement"
    )

    $dupInstances = Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query "SELECT instanceId, count(*) as Number FROM Instances where instanceState = 2 group by instanceId having count(*) > 1"
    $instanceIds = $dupInstances.instanceId
    $idsString = $instanceIds -join "','"
    $instanceEntries = Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query "SELECT * FROM Instances Where instanceId IN ('$idsString') and instanceState = 2"
    $sortedEntries = $instanceEntries | Sort-Object -Property @{Expression="instanceId"; Descending=$true},@{Expression="instanceVersion"; Descending=$true}
    $idMap = @{}
    foreach($entry in $sortedEntries)
    {
        if($idMap[$entry.instanceId])
        {
            Invoke-Sqlcmd -ServerInstance $ServerInstance -Database $Database -Query "Update Instances set instanceState = 3 where instanceId = '$($entry.instanceId)' and instanceVersion = $($entry.instanceVersion)"
        }
        else
        {
            $idMap[$entry.instanceId] = $true
        }
    }
    ```

2. Run PowerShell as an Administrator.

3. Run the following command:

    ```powershell
    .\FixInstanceStateError.ps1 -ServerInstance SQLserver -Database HpcManagement
    ```

4. Restart the HPC SDM Store Service and HPC Management Service.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
