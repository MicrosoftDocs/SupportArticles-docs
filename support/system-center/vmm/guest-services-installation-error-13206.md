---
title: Error 13206 when installing virtual guest services
description: Fixes an issue where you receive error 13206 when installing System Center Virtual Machine Manager guest services.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# System Center Virtual Machine Manager guest services installation fails with error 13206

This article helps you work around an issue where you receive error 13206 when installing System Center Virtual Machine Manager guest services.

_Original product version:_ &nbsp; System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 2313592

## Symptoms

When using System Center Virtual Machine Manager to install virtual guest services, the job may fail with the following error.

> Error (13206)  
> Virtual Machine Manager cannot locate the boot or system volume on virtual machine \<virtual machine name>. The resulting virtual machine might not start or operate properly.

A trace of the job will contain a variation of the following entry:

> MountedVhd.cs,87,0x00000000,MountedVhd windows volume not found,{00000000-0000-0000-0000-000000000000},4,

## Cause

The boot and system files are on different partitions, with the Windows directory being on an extended partition instead of a primary partition. The Windows volume isn't found when the VHD is mounted for integration services.

## Resolution

Two possible workarounds:

1. Create a new VM with only primary partitions and copy the content of the problematic VM to this new disk structure.
2. Install integration services manually with Hyper-V.

It is possible to fully automate the installation of integration components on VMs by copying required files to the VM and executing the process remotely. No user interaction is required. The VM will reboot automatically if needed.

- From the Hyper-V server, copy the C:\Windows\VMguest directory to the VM.
- Use psexec.exe to initiate integration components on the VM.
  - Assuming `C:\Windows\VMguest` was copied to `C:\Temp\VMguest` on the VM.
  - On the Hyper-V server, execute:

    ```console
    psexec.exe \\<virtual machine name> -i C:\Temp\VMguest\Support\x86\setup.exe /quiet
    ```

For more information on psexec, see [PsExec v2.2](/sysinternals/downloads/psexec).

## More information

The autorun.inf file in the root of an .ISO can also be modified as shown below. If autorun is enabled on the VM operating system, this will automatically install integration components in the same manner as previously described.

```console
[AutoRun]
action=@support\x86\setup.exe,-2000
label=Integration Services Setup
open=support\x86\setup.exe /quiet

[DeviceInstall]
```
