---
title: Can't enable MAC spoofing when creating a VM template
description: Fixes an issue where you can't enable spoofing of MAC address when you create or modify a virtual machine template.
ms.date: 07/17/2020
ms.reviewer: dewitth
---
# Unable to enable MAC spoofing when creating a VM template in System Center 2012 Virtual Machine Manager

This article helps you fix an issue where you can't enable spoofing of MAC address when you create or modify a virtual machine (VM) template in Microsoft System Center 2012 Virtual Machine Manager (VMM).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2693675

## Symptoms

The virtual network adapter setting **Enable spoofing of MAC address** may not be applied even after enabling it when creating or modifying a VM template in System Center 2012 Virtual Machine Manager.

## Cause

The resulting PowerShell script that is created with the VM template wizard omits the `-EnableMACAddressSpoofing` parameter.

## Resolution 1

Use the following commands in a VMM command shell to configure this setting for an existing VM template.

> [!NOTE]
> Replace VMTemplate01 in the example below with the name of the template to be modified.

```powershell
PS C:\> $VMTemplate = Get-SCVMTemplate -Name "VMTemplate01"
PS C:\> $VirtNetworkAdapter = Get-SCVirtualNetworkAdapter -VMTemplate $VMTemplate
PS C:\> Set-SCVirtualNetworkAdapter -VirtualNetworkAdapter $VirtNetworkAdapter -EnableMACAddressSpoofing $True
```

## Resolution 2

When creating a new VM template, on the **Configure Hardware** step, select a hardware profile with **Enable spoofing of MAC address** already enabled.

To create a hardware profile:

1. In the VMM console, open the **Library** workspace.
2. In the left pane, expand **Profiles**, and then select **Hardware Profiles**.
3. On the **Home** tab, in the **Create** group, select **Create**, and then select **Hardware Profile**.
4. In the New Hardware Profile dialog box, on the **General** page, in the **Name** text box, provide a name for the hardware profile.
5. In the left pane of the New Hardware Profile dialog box, select **Hardware Profile**, and then configure the desired settings including selecting **Enable spoofing of MAC address** for the virtual network adapter.

## More information

For more information about how to configure NLB for a service tier, see [How to Configure NLB for a Service Tier](/previous-versions/system-center/system-center-2012-R2/hh335098(v=sc.12)?redirectedfrom=MSDN).
