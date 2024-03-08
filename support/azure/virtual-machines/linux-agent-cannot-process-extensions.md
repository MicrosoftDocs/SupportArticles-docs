---
title: Azure Linux VMs running Linux VM Agent 2.1.5 or 2.1.6 cannot process extensions
description: Resolves an issue in which Azure Linux VMs that are running Azure Linux VM Agent 2.1.5 or 2.1.6 cannot process extensions.
ms.date: 07/21/2020
ms.reviewer: danis, danis, scotro
ms.service: virtual-machines
ms.subservice: vm-extensions-not-operating
ms.custom: linux-related-content
ms.collection: linux
---
# Azure Linux VMs running Linux VM Agent 2.1.5 or 2.1.6 cannot process extensions

This article provides information about resolving a problem in which Azure Linux VMs that are running Azure Linux VM Agent 2.1.5 or 2.1.6 cannot process extensions.

_Original product version:_ &nbsp; Virtual Machine running Linux  
_Original KB number:_ &nbsp; 3200481

## Symptoms

Azure Linux virtual machines (VMs) that are running Azure Linux VM Agent 2.1.5 or 2.1.6 experience the following issues if they receive more than one automatic update of Azure Linux VM Agent:

- Inability to process extensions, such as install, delete, update, or get extension status
- Abnormal high CPU consumption during the Azure Linux VM Agent process

## Resolution

To resolve this issue, manually upgrade Azure Linux VM Agent to the latest version by using the following commands.

SUSE Linux Enterprise Server 12 SP1 (update to 2.2.0)

```bash
zypper refresh
```

```bash
zypper lu
```

```bash
zypper up python-azure-agent
```

```bash
sudo systemctl restart waagent.service
```  

Ubuntu 16.10 (updated version of 2.1.5)

```bash
apt install walinuxagent
```

```bash
systemctl restart walinuxagent
```  

Debian 9 (update to 2.2.0)

```bash
apt install waagent
```

```bash
service walinuxagent restart
```  

If you installed Azure Linux VM Agent 2.1.5 or 2.1.6 from GitHub directly, you can uninstall that version, and then install the currently supported Azure Linux VM Agent package version.

## Workaround

To work around this issue, restart the Azure Linux VM Agent service. This restores the functionality and performance of the VMs but does not resolve the issue. To apply the workaround, run the following command:

```bash
service walinuxagent restart
```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
