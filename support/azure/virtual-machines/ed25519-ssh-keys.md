---
title: Can't use Ed25519 SSH keys for Azure Linux VMs
description: Describes an issue that prevents you from using Ed25519 SSH keys in Azure Linux VMs. These keys aren't supported in Azure.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-deploy
ms.custom: linux-related-content
ms.collection: linux
---
# Can't use Ed25519 SSH keys for Azure Linux VMs

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4013792

## Symptoms

When you try to create a Linux VM with Ed25519 SSH keys in Microsoft Azure, or when you try to update an Azure Linux VM to use Ed25519 SSH keys, you receive an error message that resembles the following:

> The data section of the SSH key starts with an invalid pattern.

This issue occurs in Azure portal, Azure PowerShell, and JSON. The following is a sample of the Ed25519 SSH public key:

```
---- BEGIN SSH2 PUBLIC KEY ---- 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtYkeI+Apm1CjhzwUoV2+1O94ccDsDYKX2ltKcisADy
---- END SSH2 PUBLIC KEY ---- 
```

## Cause

The issue occurs because Ed25519 keys are not supported in Azure.

## Workaround

To work around this issue, use other SSH keys for the VM, such as RSA. You can generate SSH keys by using **ssh-keygen** in Linux and OS X, or by using PuTTYGen in Windows.
For more information, see [How to Use SSH keys with Windows on Azure](/azure/virtual-machines/linux/ssh-from-windows).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
