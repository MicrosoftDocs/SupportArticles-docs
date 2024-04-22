---
title: Error 2912 when deploying a virtual machine
description: Fixes an issue in which you receive error 0x80190193 when you deploy a virtual machine.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Deploying a VM with Virtual Machine Manager fails with error (2912) - Forbidden (403) (0x80190193)

This article fixes an issue in which you receive error 0x80190193 when you deploy a virtual machine.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager Service Pack 1  
_Original KB number:_ &nbsp; 2830506

## Symptoms

Using System Center 2012 Virtual Machine Manager (VMM) Service Pack 1 (SP1) to deploy a virtual machine fails with the following error:

> Error (2912):  
> An internal error has occurred trying to contact the \<HOST_NAME> server: NO_PARAM: NO_PARAM.  
> WinRM: URL: [http://<HOST_NAME>:5985], Verb: [INVOKE], Method: [GetError], Resource: [http://schemas.microsoft.com/wbem/wsman/1/wmi/root/microsoft/bits/BitsClientJob?JobId={3BA55CB4-5ECC-48A6-895F-C7B35EBF8B12}]  
> Forbidden (403) (0x80190193)

## Cause

This issue can occur if the VMM library share where the VHD file of the VM being created is located on a virtual machine that is running on a VMware ESX or ESXi host, and the virtual machine's disk where the VMM library share is located has `HotAdd`/`HotPlug` capability enabled.

To check whether the `HotAdd`/`HotPlug` capability is enabled for the virtual machine disk, use administrative credentials to try to remotely access the admin share of the disk where the VMM library share is located (such as \\\\\<server>\e$). If enabled, this operation should fail with the following error:

> You do not have permission to access \\\\\<server>\e$, contact your network administrator to request access.

This error will be displayed even if the account that was used to access the share has **Full Control** permissions.

## Resolution

To resolve this issue, disable the `HotPlug`/`HotAdd` capability of the virtual machine disk where the VMM library share is located as described in the VMware KB below:

[Disabling the HotAdd/HotPlug capability in ESXi 6.x, 5.x and ESXi/ESX 4.x virtual machines (1012225)](https://kb.vmware.com/s/article/1012225)

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
