---
title: Creating V-switches within the hyper-V environment fails
description: Provides workarounds for an issue where creating V-switches within the hyper-V environment fails.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:virtualization and hyper-v\virtual switch manager (vmswitch)
- pcy:WinComm Storage High Avail
---
# Creating V-switches within the hyper-V environment fails

This article provides workarounds for an issue where creating V-switches within the hyper-V environment fails.

_Original KB number:_ &nbsp; 2486812

## Symptoms

When trying to create a virtual switch from the Virtual Network Manager, you receive an error message while applying the new virtual network changes. The error message states: "Setup switch failed. Cannot bind to \<name of network adapter> because it is already bound to another virtual network."

When creating the virtual switch via a script, you may receive an error similar to one of the following:
> Creating Net2New-VirtualNetwork : VMM cannot complete the Hyper-V operation on server ... (Error ID: 12700, Detailed Error: Unknown error (0x8005))

Or:
> Remove-VirtualNetwork : A Hardware Management error has occurred trying to contact server `k9-campos7000-5.ad.iss-eps.net`.(Error ID: 2927, Detailed Error: Unknown error (0x80338029))

There are many possible error codes depending on the script, but in general the errors may not directly point back to a switch.

## Cause

The network adapter has the protocol used by the Hyper-V virtual switch still bound to it. This is called the vms_pp binding. (Microsoft Virtual Network Switch Protocol)

> [!Note]
> This issue is not currently known to be specific to a particular network adapter or hardware platform.

## Modify network bindings

To work around this issue, modify network bindings by using the following steps:

1. Produce a list of all the network adapters and their bindings. Find the problematic adapter and see if the vms_pp binding is enabled. Run the following cmdlet and note the name of the adapter.

    ```powershell
    Get-NetAdapterBinding -ComponentID "vms_pp"
    ```
  
2. Disable the vms_pp binding by using the following cmdlet:

    ```powershell
    Disable-NetAdapterBinding -Name "<Adapter Name>" -ComponentID "vms_pp"
    ```

3. Take the first step again and confirm that the value of the `Enabled` property is `False`. This is to confirm that the binding has been removed.
