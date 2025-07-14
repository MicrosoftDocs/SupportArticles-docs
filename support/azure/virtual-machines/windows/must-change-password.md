---
title: Azure virtual machine error You must change your password before logging on the first time
description: When using Remote Desktop Protocol to connect to a virtual machine, you might have to change the password of the account first.
services: virtual-machines
documentationcenter: ''
author: JarrettRenshaw
manager: dcscontentpm
tags: virtual-machines
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.workload: infrastructure-services
ms.tgt_pltfrm: vm-windows
ms.devlang: azurecli
ms.date: 07/29/2022
ms.author: jarrettr
ms.custom: sap:Cannot connect to my VM
---

# Azure virtual machine error: "You must change your password before logging on the first time"

**Applies to:** :heavy_check_mark: Windows VMs

## Symptom

When you use a Remote Desktop Protocol (RDP) connection to connect to an Azure virtual machine (VM), you encounter the error:

> You must change your password before logging on the first time. Please update your password or contact your system administrator or technical support.

:::image type="content" source="./media/must-change-password/rdp-error.png" alt-text="Remote Desktop Connection you must change your password before logging on the first time":::

## Cause

The account you are trying to use on the RDP connection is flagged to change the password on the first login.

## Resolution

**Important**
Before following the troubleshooting steps below, backup the VM OS disk by creating a snapshot, following the steps in [Snapshot a disk](/azure/virtual-machines/windows/snapshot-copy-managed-disk). If you need to revert any changes made while troubleshooting, you can use the snapshot to recreate the disk.

**Troubleshooting:**

Before using this option, make sure the VM agent is running. You can check the status of Azure guest agent in the Azure portal by going to the Virtual Machine, then **VM** > **Settings** > **Properties** > **Agent status**. If the VM agent is running healthy, you can use the Run Command described in [Remote troubleshooting tool for Azure VMs](./remote-tools-troubleshoot-azure-vm-issues.md).

If your VM doesn’t have an agent running, you can follow the steps in [Reset local Windows password for Azure VM offline](./reset-local-password-without-agent.md). When you can connect to the VM, you can use the following instructions to solve the issue on the account that needs a password reset.

1. Open the Run Command and input the following commands:
    - For local accounts:

        `net user <USERNAME> *`
    - For domain accounts:

        `net user <USERNAME> * /domain`

    **Note** This will ask for the password. Type the new password to set up the account.

1. After you change the password, the issue should be resolved and you can use the account to log in into the VM. There is no need to restart the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
