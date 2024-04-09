---
title: Can't create a protection group in ASR
description: Work around an issue in which you can't create a protection group in Azure Site Recovery because an error occurred while retrieving the list of servers.
ms.date: 04/09/2024
ms.reviewer: wenca, markstan
---
# Error retrieving the list of servers when you create a protection group in Azure Site Recovery

This article helps you work around an issue in which you can't create a protection group in Azure Site Recovery because an error occurred while retrieving the list of servers.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, Azure Backup, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 3060975

## Symptoms

When you try to create a protection group by using Microsoft Azure Site Recovery (ASR), the attempt fails, and you receive the following error message:

> An error occurred while retrieving the list of servers

Additionally, a log entry that resembles the following is logged in a debug log:

> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\DRA\DRA\EnvironmentChange\EnvChangeManager.cs:522 GetFabricLayoutUpdate] The layout as reported by the fabric is: Clouds:  CloudId: cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082  CloudName: Cloudname  VmmId:     Hosts:  SrsDataContract.HvHostDetails  VirtualMachines:  Name             : CloudnameTS01  Id               : 0a00d728-9e8e-4edf-a7e5-2421dc92b6fb  VmmId            :   CloudId          : cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082  HostId           : Cloudnamevh01  Hyper-V VM Id    : 0a00d728-9e8e-4edf-a7e5-2421dc92b6fb  Fabric details   :   VmConfigurationFileLocation: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines\0A00D728-9E8E-4EDF-A7E5-2421DC92B6FB.xml   NicId: TWljcm9zb2Z0OjBBMDBENzI4LTlFOEUtNEVERi1BN0U1LTI0MjFEQzkyQjZGQlxCQkVCRDM0NC03NEQ2LTQyMjItQUJDRC03NkNCMUM5MUY1MTU=, VMNetworkId: Intel(R) PRO/1000 PT Dual Port Server Adapter #2 - Virtual Switch, VMSubnet: Intel(R) PRO/1000 PT Dual Port Server Adapter #2 - Virtual Switch    Name             : CloudnameDC01  Id               : fcbc3468-c1ec-444b-8db1-e64f696de9f9  VmmId            :   CloudId          : cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082  HostId           : Cloudnamevh01  Hyper-V VM Id    : fcbc3468-c1ec-444b-8db1-e64f696de9f9  Fabric details   :   VmConfigurationFileLocation: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines\FCBC3468-C1EC-444B-8DB1-E64F696DE9F9.xml   NicId: TWljcm9zb2Z0OkZDQkMzNDY4LUMxRUMtNDQ0Qi04REIxLUU2NEY2OTZERTlGOVw3MzI0NkI1MS0wNjYzLTRFMzctQjc4MS1BOEVGODg5QUExNEE=, VMNetworkId: Intel(R) PRO/1000 PT Dual Port Server Adapter #2 - Virtual Switch, VMSubnet: Intel(R) PRO/1000 PT Dual Port Server Adapter #2 - Virtual Switch    StorageClassifications:  StorageArrays:  StoragePools:  Luns:  VmNetworks:  VmmId:   LogicalNetworkId: 7ffb73ac-24a5-4d90-97e4-89508f5a8082  LogicalNetworkName: Cloudname  VMNetworkId: Intel(R) PRO/1000 PT Dual Port Server Adapter #2 - Virtual Switch  VMNetworkName: Intel(R) PRO/1000 PT Dual Port Server Adapter #2 - Virtual Switch  VMNetworkType: No isolation  VmSubnetList:    Intel(R) PRO/1000 PT Dual Port Server Adapter #2 - Virtual Switch :   Description: Intel(R) PRO/1000 PT Dual Port Server Adapter #2 - Virtual Switch  IsPaired: False    LogicalNetworks:  VmmId:   LogicalNetworkId: 7ffb73ac-24a5-4d90-97e4-89508f5a8082  LogicalNetworkName: Cloudname  Description:   IsNetworkVirtualizationEnabled: False  AreLNDsIsolated: False  IsGREUsed: False  IsTestFailoverLN: False    FabricReplicationGroups:  Site:  .  
> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\DRA\DRA\EnvironmentChange\EnvChangeManager.cs:373 UpdateInternal] DRA EnvChangeManager Update CarmineObjectType: Cloud  
> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\DRA\DRA\EnvironmentChange\EnvChangeManager.cs:389 UpdateInternal] DRA EnvChangeManager Update, new/update of handler called.  
> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\ReplicationProvider\DraPlugins\HyperVReplicaAzurePlugin\ConfigurationTasks\CreateProtectionUnits.cs:67 ExecuteInternal] Skipping PU creation for cloud 'cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082' as PU cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082_371f87f9-53e5-429f-b10b-f14700a4b137 is already present for provider Dra.Plugin.HyperVReplicaAzurePlugin.  
> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\ReplicationProvider\DraPlugins\HyperVReplicaAzurePlugin\ConfigurationTasks\CreateProtectionUnits.cs:95 ExecuteInternal] Created PU cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082_371f87f9-53e5-429f-b10b-f14700a4b137 for provider Dra.Plugin.HyperVReplicaAzurePlugin and attached it to cloud 'cloud_7ffee3ac-24a5-4d90-97a4-89508f5a8082' successfully.  
> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\ReplicationProvider\DraPlugins\HyperVReplicaPlugin\ConfigurationTasks\CreateProtectionUnits.cs:68 ExecuteInternal] Skipping PU creation for cloud 'cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082' as PU cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082_6c11a271-07bc-4ec4-bf1b-82b2189f980f is already present for provider '6c11a271-07bc-4aa4-bf1b-82b2189f980f' (HvrVM1: Hyper-V Replica (Windows Server 2012)).  
> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\ReplicationProvider\DraPlugins\HyperVReplicaPlugin\ConfigurationTasks\CreateProtectionUnits.cs:96 ExecuteInternal] Created PU cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082_6c11a271-07bc-4ec4-bf1b-82b2189f980f for provider '6c11a271-07bc-4ec4-bf1b-82b2189f980f' (HvrV1: Hyper-V Replica (Windows Server 2012)) and attached it to cloud 'cloud_7aaa3ac-24a5-4d90-97e4-89508f5a8082' successfully.  
> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\ReplicationProvider\DraPlugins\HyperVReplicaPlugin\ConfigurationTasks\CreateProtectionUnits.cs:68 ExecuteInternal] Skipping PU creation for cloud 'cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082' as PU cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082_9208701f-5eaa-45c9-ad8a-0d8d097264ef is already present for provider '9208701f-5eaa-4aa9-ad8a-0d8d097264ef' (HvrVM2: Hyper-V Replica (Windows Server Blue)).  
> [0]058C.0D40::‎2015‎-‎04‎-‎07 15:38:06.369 [Microsoft-Azure Site Recovery-Provider][s:\1664\1524\Sources\Online\RecSrv\SRS\Service\ReplicationProvider\DraPlugins\HyperVReplicaPlugin\ConfigurationTasks\CreateProtectionUnits.cs:96 ExecuteInternal] Created PU cloud_7ffb73ac-24a5-4d90-97e4-89508f5a8082_9208701f-5eaa-45c9-ad8a-0d8d097264ef for provider '9208701f-5eaa-45c9-ad8a-0d8d097264ef' (HvrV2: Hyper-V Replica (Windows Server Blue)) and attached it to cloud 'cloud_7faaaac-24a5-4d90-97e4-89508f5a8082' successfully.

## Cause

This problem may occur if the Microsoft Hyper-V virtual switch name contains the number sign (#).

## Workaround

To work around this problem, follow these steps:

1. On the Hyper-V host, open an elevated Command Prompt window. To do this, click **Start**, type **cmd**, right-click **cmd.exe** in the results list, and then click **Run as administrator**.
2. At the command prompt, run the following command:

   ```console
   net stop DRA
   ```  

3. Change the name of every Hyper-V virtual switch so that it does not contain the number sign (#).
4. At an elevated command prompt on the Hyper-V host, run the following command:

   ```console
   net start DRA
   ```  

5. On the **Servers** page in the Azure portal, restart the host server.

After you complete these steps, you should be able to create a protection group successfully.

## More Information

Microsoft has confirmed that this is a problem in Azure Site Recovery, and is working on a resolution.
