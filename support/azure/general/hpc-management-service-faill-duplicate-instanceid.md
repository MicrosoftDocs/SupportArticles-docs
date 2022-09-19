---
title: HPC Management Service fails to start because of duplicate instance ID
description: Provides a solution for an issue where HPC Management Service fails to start  because of duplicate instance ID
ms.date: 09/19/2022
ms.service: azure-common-issues-support
ms.author: genli
author: genlin
ms.reviewer: hclvteam 
---
# HPC Management Service fails to start because of duplicate instance ID

This article provides a solution for an issue where HPC Management Service fails to start because of duplicate instance ID.

## Symptoms

HPC management service failed to start. The [HPC service log](/powershell/high-performance-computing/using-service-log-files-for-hpc-pack?view=hpc19-ps#BKMK_loc&preserve-view=true ) shows the following error:

> Store corruption due to duplicate instance ids.

## Cause

This issue occurs if the HPC management database contains more than one instance records that are in current state(instanceState is 2). normally, each instance should have only one record in the current state.

You can run the following query on HPC management database to check the state of the instances:

`SELECT instanceId, count() as Number FROM Instances where instanceState = 2 group by instanceId having count() > 1`

## Resolution

To resolve the issue, run the following script repair the instances:

1. Save following PowerShell script as FixInstanceStateError.ps1 file.

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

1. Run PowerShell as an Administrator.

1. Run the following command:

    ```powershell
    .\FixInstanceStateError.ps1 -ServerInstance SQLserver -Database HpcManagement
    ```

1. Restart the HPC SDM Store Service and HPC Management Service.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]