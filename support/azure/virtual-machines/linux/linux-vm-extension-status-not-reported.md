---
title: Linux VM extension status isn't reported after Azure Linux Agent 2.2.19 update
description: Discusses a problem in which the Linux VM extension status is not reported after an Azure Linux Agent update to version 2.2.19.
ms.date: 07/21/2020
ms.reviewer: danis, danis
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
ms.custom: linux-related-content
ms.collection: linux
---
# Linux VM extension status isn't reported after Azure Linux Agent 2.2.19 update

This article provides a solution to an issue in which the Linux VM extension status is not reported after an Azure Linux Agent update to version 2.2.19.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 4077547

## Symptoms

On a Linux virtual machine (VM) that's running on an instance of Microsoft Azure that has Azure Linux Agent 2.2.19 installed, you don't see the extension status being reported by using either the portal or Azure Command-Line Interface (Azure CLI).

## Cause

This problem occurs because of a [known issue](https://github.com/Azure/WALinuxAgent/wiki/Known-Issues#2219---protocolerror-varlibwaagentgoalstate1xml-is-missing).

## Resolution

Microsoft is taking steps to automatically resolve this problem. For VMs that have been automatically resolved, you will see the following additional Microsoft extension installed on the affected VMs:

- **Extension publisher:** Microsoft.CPlat.Core
- **Extension type:** RunCommandLinux

You can use [Azure CLI](/cli/azure/install-azure-cli)  to query the extensions that are assigned to a VM. To do this, run the following command:

```Azure CLI
az vm extension list --vm-name <vmName> -g <resGroupName>
```

You can also remove this extension by running the following command:

```Azure CLI
az vm extension delete --vm-name < vmName > -g <resGroupName> --name <extension name>
```

> [!NOTE]
> In these commands, \<vmName>, \<resGroupName>, and \<extension name> represent the actual variable names.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
