---
title: HPC Management Service fails to initialize
description: Provides a solution for an issue where HPC Management Service fails to start after you restore a corrupted database
ms.date: 09/14/2022
ms.service: azure-common-issues-support
ms.author: v-weizhu
author: AmandaAZ
ms.reviewer: hclvteam 
---
# HPC Management Service fails to start after restoring database

This article provides a solution for an issue where HPC Management Service fails to start after you restore a corrupted database.

## Symptoms

After you restore a corrupted HPC management database, HPC Management Service fails to initialize. When you reboot the computer multiple times, all other services are in running status. However, HPC Management Service still doesn't start.

The following error is shown in HPC Management event logs.

> Level Date and Time Source Event ID Task Category Error 7/13/2020 14:06 Microsoft-HPC-Management 6106 Initialization The HPC Management Service failed to initialize correctly: The instance collection of ids cannot be resolved in the current instance view.

## Cause

Check HPC Management event logs:

:::image type="content" source="media/hpc-management-service-not-start/instancecacheloadexception.png" alt-text="Screenshot that shows HPC Management event logs.":::

HPC Management Service crashed with "InstanceCacheLoadException". The instances are sql instances. Many instances are in wrong state. For each instance, there's only one version in "Current" state (for example, instanceState is 2), but in your HPCManagement database, there are tens of instances with two or three versions in "Current" state.

## Resolution

To resolve the issue, fix the instances in wrong state. To do this, follow these steps:

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