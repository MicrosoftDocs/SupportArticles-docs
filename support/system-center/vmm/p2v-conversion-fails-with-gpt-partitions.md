---
title: A P2V conversion fails with GPT partitions
description: Fixes an issue in which a physical to virtual (P2V) conversion may fail if the source machine contains a GUID Partition Table formatted disk.
ms.date: 07/15/2020
ms.prod-support-area-path: 
---
# P2V fails with GPT partitions in System Center Virtual Machine Manager

This article helps you fix an issue in which a physical to virtual (P2V) conversion may fail if the source machine contains a GUID Partition Table (GPT) formatted disk.

_Original product version:_ &nbsp; System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 2705349

## Symptoms

A P2V conversion may fail in System Center Virtual Machine Manager if the source machine contains a GPT formatted disk. In this scenario, the conversion fails with an error similar to the following examples:

> Log Name: System  
> Source: Service Control Manager  
> Event ID: 7031  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> Description:  
> The Virtual Machine Manager P2V Agent service terminated unexpectedly. It has done this 1 time(s).  The following corrective action will be taken in 0 milliseconds: Restart the service.

> Log Name: Application  
> Source: Application Error  
> Event ID: 1000  
> Task Category: (100)  
> Level: Error  
> Keywords: Classic  
> Description:  
> Faulting application name: vmmP2VAgent.exe, version: 2.0.4271.0, time stamp: 0x4a7a0b17  
> Faulting module name: vmmP2VAgent.exe, version: 2.0.4271.0, time stamp: 0x4a7a0b17  
> Exception code: 0xc000000d  
> Fault offset: 0x0000000000038e45  
> Faulting process id: 0x6ec  
> Faulting application start time: 0x01cbbcc8d4befeb6  
> Faulting application path: C:\Program Files\Microsoft System Center Virtual Machine Manager 2008 P2V Agent\bin\vmmP2VAgent.exe  
> Faulting module path: C:\Program Files\Microsoft System Center Virtual Machine Manager 2008 P2V Agent\bin\vmmP2VAgent.exe  
> Report Id: 1272adba-28bc-11e0-89a1-e41f136885b0

A Virtual Machine Manager (VMM) trace will show patterns similar to the following example:

Variation 1:

> 3488 00003486 120.73740387 [4608] 1200.1610::01/28-18:29:10.912:WsmanAPIWrapper.cs(1415): WSMAN: URL: [`https://servername:80`] Verb: [INVOKE], method: [GetLUNIDFromFSPath], resource: [`https://schemas.microsoft.com/wbem/wsman/1/wmi/root/scvmmaccelerator/VirtualizationSANAccelerator`]
> 3489 00003487 120.73745728 [4608] 1200.1610::01/28-18:29:10.912:WsmanAPIWrapper.cs(544): HostSessionCache: elements for [S-1-5-18-servername]: [100]  
> 3490 00003488 120.73786926 [4608] 1200.1610::01/28-18:29:10.912:WsmanAPIWrapper.cs(593): WsmanAPIWrapper::CreateSession: going to use custom timeout for wsman operations: 300 secs.  
> 3491 00003489 120.84464264 [4608] 1200.1610::01/28-18:29:11.021:BitDeploymentSubtask.cs(771): MapSANWMIErrorCodeToCarmineError: Return value from agent CARMINE_SAN_WMI_NO_UNIQUE_LUN_IDENTIFIER, Mapped carmine error code DeployVMNoUniqueID  
> 3492 00003490 120.84486389 [4608] 1200.1610::01/28-18:29:11.021:HostProperties.cs(521): Found Disk: UniqueID:0, Name:\\\\.\PHYSICALDRIVE4, Capacity:624438581760  
> 3493 00003491 120.84495544 [4608] 1200.1610::01/28-18:29:11.021:WsmanAPIWrapper.cs(1415): WSMAN: URL: [`http://servername:80`] Verb: [INVOKE], method: [GetLUNIDFromFSPath], resource: [`https://schemas.microsoft.com/wbem/wsman/1/wmi/root/scvmmaccelerator/VirtualizationSANAccelerator`]
> 3494 00003492 120.84500885 [4608] 1200.1610::01/28-18:29:11.021:WsmanAPIWrapper.cs(544): HostSessionCache: elements for [S-1-5-18-servername]: [100]  
> 3495 00003493 120.84546661 [4608] 1200.1610::01/28-18:29:11.021:WsmanAPIWrapper.cs(593): WsmanAPIWrapper::CreateSession: going to use custom timeout for wsman operations: 300 secs.  
> 3496 00003494 120.96246338 [4608] 1200.1610::01/28-18:29:11.146:BitDeploymentSubtask.cs(771): MapSANWMIErrorCodeToCarmineError: Return value from agent CARMINE_SAN_WMI_NO_UNIQUE_LUN_IDENTIFIER, Mapped carmine error code DeployVMNoUniqueID  
> 3497 00003495 120.96269989 [4608] 1200.1610::01/28-18:29:11.146:HostProperties.cs(521): Found Disk: UniqueID:0, Name:\\\\.\PHYSICALDRIVE5, Capacity:624438581760  
> 3498 00003496 120.96279144 [4608] 1200.1610::01/28-18:29:11.146:WsmanAPIWrapper.cs(1415): WSMAN: URL: [`http://servername:80`] Verb: [INVOKE], method: [GetLUNIDFromFSPath], resource: [`https://schemas.microsoft.com/wbem/wsman/1/wmi/root/scvmmaccelerator/VirtualizationSANAccelerator`]
> 3499 00003497 120.96284485 [4608] 1200.1610::01/28-18:29:11.146:WsmanAPIWrapper.cs(544): HostSessionCache: elements for [S-1-5-18-servername]: [100]  
> 3500 00003498 120.96331024 [4608] 1200.1610::01/28-18:29:11.146:WsmanAPIWrapper.cs(593): WsmanAPIWrapper::CreateSession: going to use custom timeout for wsman operations: 300 secs.  
> 3501 00003499 121.08226776 [4608] 1200.1610::01/28-18:29:11.271:BitDeploymentSubtask.cs(771): MapSANWMIErrorCodeToCarmineError: Return value from agent CARMINE_SAN_WMI_NO_UNIQUE_LUN_IDENTIFIER, Mapped carmine error code DeployVMNoUniqueID  
> 3502 00003500 121.08245850 [4608] 1200.1610::01/28-18:29:11.271:HostProperties.cs(521): Found Disk: UniqueID:0, Name:\\\\.\PHYSICALDRIVE6, Capacity:624455032320  
> 3503 00003501 121.08254242 [4608] 1200.1610::01/28-18:29:11.271:WsmanAPIWrapper.cs(1415): WSMAN: URL: [`http://servername:80`] Verb: [INVOKE], method: [GetLUNIDFromFSPath], resource: [`https://schemas.microsoft.com/wbem/wsman/1/wmi/root/scvmmaccelerator/VirtualizationSANAccelerator`]
> 3504 00003502 121.08259583 [4608] 1200.1610::01/28-18:29:11.271:WsmanAPIWrapper.cs(544): HostSessionCache: elements for [S-1-5-18-servername]: [100]  
> 3505 00003503 121.08300781 [4608] 1200.1610::01/28-18:29:11.271:WsmanAPIWrapper.cs(593): WsmanAPIWrapper::CreateSession: going to use custom timeout for wsman operations: 300 secs.  
> 3506 00003504 121.23886871 [4608] 1200.1610::01/28-18:29:11.427:BitDeploymentSubtask.cs(771): MapSANWMIErrorCodeToCarmineError: Return value from agent CARMINE_SAN_WMI_NO_UNIQUE_LUN_IDENTIFIER, Mapped carmine error code DeployVMNoUniqueID  

Variation 2:

> 00000724 6.41339493 [3268] 0CC4.0378::07/27-03:32:02.851:DifferencingDisksRefresher.cs(630): Virtual disk for VM VMNAME:0041902D-E883-4189-8EFB-B0FE3E050FB1 is on a network path \\\\servername\share\New Virtual Hard Disk.vhd. We will mark it as unsupported  
> 00000725 6.41355848 [3268] 0CC4.0378::07/27-03:32:02.851:VmRefresher.cs(4832): VM VMNAME has an invalid bus specification or bad path or path that we cannot access and will be marked unsupported  
> 00000726 6.41393661 [3268] 0CC4.0378::07/27-03:32:02.851:VmRefresher.cs(4832): Microsoft.VirtualManager.Utils.CarmineException: The specified path \\\servername\share\New Virtual Hard Disk.vhd is not valid on the servername server.  
> 00000727 6.41393661 [3268] Ensure that you have specified a valid path, and then try the operation again.  
> 00000728 6.41393661 [3268] at Microsoft.VirtualManager.Engine.Backup.DifferencingDisksRefresher.GetDifferencingDisksHierarchyFromVMService(WSManConnectionParameters hostConnectionParameters, Boolean allowPartialObjects)  
> 00000729 6.41393661 [3268] at Microsoft.VirtualManager.Engine.Backup.DifferencingDisksRefresher.GenerateDiskHierarchy(WSManConnectionParameters hostConnnectionParameters, Boolean allowPartialObjects, UInt32& errorCode)  
> 00000730 6.41393661 [3268] at Microsoft.VirtualManager.Engine.BitBos.VMRefresherBase.UpdateDisks(IVMComputerSystem vmComputer)  
> 00000731 6.41393661 [3268] *** Carmine error was: HostAgentBadPathname (2906); 0

On the client, you may see a VMM trace with errors like the following examples:

> 0639 00000637 28.49589729 [2800] 0AF0.0A00::03/09-21:15:59.638:HostProperties.cs(523): Found Disk: UniqueID:0, Name:\\\\.\PHYSICALDRIVE4, Capacity:2937995988480  
> 0640 00000638 28.49621391 [2800] 0AF0.0A00::03/09-21:15:59.638:WsmanAPIWrapper.cs(1415): WSMAN: URL: [`https://machinename:80`] Verb: [INVOKE], method: [GetLUNIDFromFSPath], resource: [`https://schemas.microsoft.com/wbem/wsman/1/wmi/root/scvmmaccelerator/VirtualizationSANAccelerator`]  
> 0641 00000639 28.49632645 [2800] 0AF0.0A00::03/09-21:15:59.638:WsmanAPIWrapper.cs(544): HostSessionCache: elements for [S-1-5-21-72034930-1147432956-5522801-23474-.]: [100]  
> 0642 00000640 28.49638367 [2800] 0AF0.0A00::03/09-21:15:59.638:WsmanAPIWrapper.cs(593): WsmanAPIWrapper::CreateSession: going to use custom timeout for wsman operations: 300 secs.  
> 0646 00000644 28.64711952 [2800] 0AF0.0A00::03/09-21:15:59.841:BitDeploymentSubtask.cs(771): MapSANWMIErrorCodeToCarmineError: Return value from agent CARMINE_SAN_WMI_NO_UNIQUE_LUN_IDENTIFIER, Mapped carmine error code DeployVMNoUniqueID
>
> 280 00000278 22.32052803 [6536] 1988.1658::03/09-21:16:11.349:sanacceleratorminiprovider.cpp(2482): <--CDisk::FindDisk  
> 281 00000279 22.32100105 [6536] 1988.1658::03/09-21:16:11.349:sanacceleratorminiprovider.cpp(1687)[00000000001A98: Disk pnp id \\\\?\mpio.disk&ven_hp&prod_p2000_g3_sas&rev_t200.1&7f6ac24&0&3630434646303031304537454642414237344431303030.{53f56307-b6bf-11d0-94f2-00a0c91efb8b}  
> 282 00000280 22.32103920 [6536] 1988.1658::03/09-21:16:11.349:sanacceleratorminiprovider.cpp(1689)[00000000001A98: Disk address Port3Path0Target3Lun4  
> 283 00000281 22.32107353 [6536] 1988.1658::03/09-21:16:11.349:sanacceleratorminiprovider.cpp(1691)[00000000001A98: Disk name \\\\?\PhysicalDrive4  
> 284 00000282 22.32113457 [6536] 1988.1658::03/09-21:16:11.349:sanacceleratorminiprovider.cpp(2263): ==>LunIdentifier::FindLunUniqueID  
> 285 00000283 22.32162285 [6536] 1988.1658::03/09-21:16:11.349:sanacceleratorminiprovider.cpp(2263): <--LunIdentifier::FindLunUniqueID  
> 286 00000284 22.32165909 [6536] 1988.1658::03/09-21:16:11.349:sanacceleratorminiprovider.cpp(1733)[00000000001A98: LUN has no unique storage identifier  
> 287 00000285 22.32180595 [6536] 1988.1658::03/09-21:16:11.349:sanacceleratorminiprovider.cpp(1740)[00000000001A98: GetLUNIDFromFSPath: Caught exception. Returning error code 9

## Cause

This behavior is by design. VMM doesn't support GPT disks on P2V targets. To successfully migrate a machine with a GPT disk, you must first convert the disk to master boot record (MBR) format.

## Resolution

To allow conversion of machines with GPT partitions, you must first convert the partition to MBR. There are two workarounds that may be used:  

### Option 1: Back up data on the physical machine

1. Back up existing data using your existing backup solution.
2. Delete any existing partitions on the disk(s).
3. Right-click on the disk and choose **Convert to MBR.**  
4. Restore your data using your backup solution.
5. Restart the computer and retry the P2V operation.

### Option 2

1. Use the Disk2VHD tool from [http://live.sysinternals.com/disk2vhd.exe](https://live.sysinternals.com/disk2vhd.exe) to convert the partition(s) to Virtual Hard Disk (VHD) files.
2. Create a new virtual machine and attach the virtual machine from step 1 to the VHD.
3. Boot the operating system from the operating system installation media, and use the appropriate repair steps to make the disk bootable.

## More information

You can verify the partition type on the target machine by inspecting the disk configuration in Disk Management (diskmgmt.msc). For more information, see [P2V: Requirements for Physical Source Computers](/previous-versions/system-center/virtual-machine-manager-2008-r2/cc917954(v=technet.10)). GPT requires an Extensible Firmware Interface (EFI) or Unified Extensible Firmware Interface (UEFI) BIOS to boot; Hyper-V doesn't have either EFI or UEFI BIOS support.
