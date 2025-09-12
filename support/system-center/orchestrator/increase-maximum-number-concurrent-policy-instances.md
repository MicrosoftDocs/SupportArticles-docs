---
title: Increase the maximum number of concurrent policy instances
description: Describes how to increase the maximum number of concurrent policy instances that are running on a single Opalis Integration Server Action Server.
ms.date: 06/26/2024
---
# Increase the maximum number of concurrent policy instances running on a single Opalis Integration Server Action Server

This article describes how to increase the maximum number of concurrent policy instances that are running on a single Opalis Integration Server Action Server.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2102398

## Summary

Opalis Integration Server imposes a default limit of 50 concurrent policy instances running on a single Action Server in order to prevent depletion of the Windows resource known as **Desktop Heap**, which causes unexpected execution results such as process terminations and inability to allocate necessary resources to perform just about any kind of task.

Error messages returned or exceptions captured in Action Server or Policy Module logs include **Out of memory**, **Not enough storage**, and other messages that make reference to an inability to allocate a resource such as a **Named Pipe** or **Windows Socket**.

Increasing the maximum number of policy instances that can run concurrently on a single Action Server consists of two steps:

1. Increase Windows Desktop Heap for desktops in the non-interactive windows stations.
2. Increase the value of allowed concurrent policy instances using the Action Server Policy Throttling command-line utility (aspt.exe) included with the Opalis Integration Server management server.

Increasing the Desktop Heap is a Windows system wide change and requires a reboot. More information including an explanation of Desktop Heap can be found in [User32.dll or Kernel32.dll does not initialize](https://support.microsoft.com/help/184802/).

## Increase Desktop Heap

Opalis Integration Server processes all use varying amounts of Desktop Heap depending on which objects and how many objects exist in each policy. As a guideline, calculations are set on the basis of each policymodule.exe consuming 10 KB of Desktop Heap. As outlined in [User32.dll or Kernel32.dll does not initialize](https://support.microsoft.com/help/184802/), Desktop Heap for the non-interactive desktops is identified by the third parameter of the `SharedSection=` segment of the following registry value:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\SubSystems\Windows`

The default data for this registry value will look something like the following:

`%SystemRoot%\system32\csrss.exe ObjectDirectory=\Windows SharedSection=1024,3072,512 Windows=On SubSystemType=Windows ServerDll=basesrv,1 ServerDll=winsrv:UserServerDllInitialization,3 ServerDll=winsrv:ConServerDllInitialization,2 ProfileControl=Off MaxRequestThreads=16`

The value to be entered into the third parameter of the `SharedSection=` segment should be based on the calculation of:

**(number of desired concurrent policies) * 10 = (third parameter value)**

Example: If it's desired to have 100 concurrent policy instances, then **100 * 10 = 1000**, rounding up to a nice memory number gives you 1024 as the third parameter resulting in the following update to be made to the registry value:

**SharedSection=1024,3072,1024**

Because the Service Control Manager creates a new desktop in the noninteractive window station for every service process that is running under a user account, a larger desktop value for the third parameter of the `SharedSection=` segment will reduce the number of user account services that can run successfully on the system.

## Increase maximum concurrent policy instances

Increasing the maximum number of concurrent policy instances running on any given Action Server is accomplished by executing the Action Server Policy Throttling utility (aspt.exe) located on the Opalis Integration Server management server computer in the management service installation folder (default = `C:\Program Files\Opalis Software\Opalis Integration Server\Management Service`).

Syntax for running aspt.exe is as follows:

`aspt.exe <ActionServer> <NumberOfPolicies>`

Examples:

- `aspt.exe COMPUTER1 100`

    The above will change the Action Server named *COMPUTER1* to allow a maximum of **100** concurrent policy instances to be running.

- `aspt.exe * 200`

    The above will change all Action Servers to allow a maximum of **200** concurrent policy instances to be running.

> [!NOTE]
> Each Action Server affected by a change using aspt.exe must have the OpalisActionService service restarted for the changes to take effect.
