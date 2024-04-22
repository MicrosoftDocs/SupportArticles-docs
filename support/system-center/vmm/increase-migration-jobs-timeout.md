---
title: A migration job fails with error 23007 
description: Fixes an issue that a migration job fails because of the timeout when there are multiple concurrent migration jobs in System Center Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# Increase the timeout for migration jobs in System Center Virtual Machine Manager

This article provides a workaround for an issue that a migration job fails because of the timeout when there are multiple concurrent migration jobs in System Center Virtual Machine Manager.

_Original product version:_ &nbsp; System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 2790310

## Symptoms

With System Center Virtual Machine Manager service pack 1 (SP1), we now allow multiple migrations to occur and we can specify the maximum number of concurrent migration jobs in the properties of the host. What this means is that if we set the migration value to **2**, the third migration job will be queued until one of the earlier jobs is complete, and by default this job will wait 15 minutes before it times out and fails the job.

When this happens, you will see errors similar to the following in the VMM admin console:

> Error (23007)
> Migration timeout because: VMM cannot complete the host operation on the serverName.contoso.com server because of the error: Storage migration for 'serverName' was not finished because maximum storage migration limit '2' was reached, please wait for completion of an ongoing migration operation (Virtual machine ID \<VMID>).  
> Resolve the host issue and then try the operation again.

A VMM trace will show events similar to the following:

> 00005365 9.20626545 [388] 0184.0008::06/24-23:57:57.717  04VirVMTask.cs(211): GetFinalResult, got error: 32768 => [Storage migration for 'VMName' was not finished because maximum storage migration limit '2' was reached, please wait for completion of an ongoing migration operation (Virtual machine ID \<VMID>).]  
> 00005366 9.20648384 [388] 0184.0008::06/24-23:57:57.717  16DeployVmSubtask.cs(10151): Win8 live migration failed with error  
> 00005367 9.20675373 [388] 0184.0008::06/24-23:57:57.717  16DeployVmSubtask.cs(10151): Microsoft.Carmine.WSManWrappers.WSManException: VMM cannot complete the host operation on the serverName.contoso.com server because of the error: Storage migration for 'VMName' was not finished because maximum storage migration limit '2' was reached, please wait for completion of an ongoing migration operation (Virtual machine ID \<VMID>).

## Workaround

To work around this, you can increase the timeout between jobs by creating the following registry key and restarting the VMM service:

1. Go to `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft System Center Virtual Machine Manager Server\Settings`.
1. Create a new **DWORD** value.
1. Set the name to `LiveMigrationQueueTimeoutSecs`.
1. Set the value to **00000708 HEX**. This will set the timeout to 30 minutes.
1. Restart the VMM service.

## More information

This information can be found at [How to increase the timeout for Migration Jobs in System Center 2012 Virtual Machine Manager](https://techcommunity.microsoft.com/t5/system-center-blog/how-to-increase-the-timeout-for-migration-jobs-in-system-center/ba-p/347412).
