---
title: Windows VM activation error 0xC004FD02
description: Provides a solution to the error 0xC004FD02 that occurs when you try to activate an Azure Windows virtual machine (VM).
ms.service: virtual-machines
ms.subservice: vm-windows-activation
ms.collection: windows
ms.date: 12/19/2023
ms.reviewer: cwhitley, v-naqviadil, v-weizhu
---

# Error 0xC004FD02 when you activate an Azure Windows virtual machine

This article provides a solution to the error 0xC004FD02 that occurs when you try to activate an Azure Windows virtual machine (VM).

## Symptoms

When you try to activate an Azure Windows VM, you receive an error message that resembles the following sample:

> Code:  
> 0xC004FD02  
> Description:  
> Windows isn't activated on the host machine. Please contact your system administrator.

:::image type="content" source="media/windows-vm-activation-error-0xc004fd02/error-0xc004fd02.png" alt-text="Screenshot of the error 0xC004FD02 and error message.":::

## Cause

The VM is configured to activate via Automatic Virtual Machine Activation (AVMA), which isn't supported in Azure.

This issue can happen in one of the following scenarios:

- The VM originally runs on-premises or in another cloud environment and is then migrated to Azure.

- An AVMA activation key is configured on the VM after being deployed to Azure.

To confirm the AVMA configuration, open the Command Prompt as an administrator and run the `slmgr /dlv` command. After the command execution, a **Windows Script Host** window appears:

:::image type="content" source="media/windows-vm-activation-error-0xc004fd02/windows-script-host.png" alt-text="Screenshot of the Windows Script Host window.":::

The "VIRTUAL_MACHINE_ACTIVATION" text in the **Description** line means that the AVMA activation method is used.

## Solution

To resolve this issue, change the activation method from AVMA to Key Management Services (KMS) by updating the activation key. KMS is a supported activation method in Azure. To do this, run the following command:

```cmd
slmgr /ipk <product key>
```

> [!NOTE]
> Replace `<product key>` with the 25 letters or numbers that belong to the product key you will use. If you use KMS, those keys are listed in [KMS keys](/windows-server/get-started/kms-client-activation-keys).

Once the key is entered successfully, an "Installation was successful" message pops up. At this point, the activation should happen automatically. You can talso rigger the activation manually by running the following commands:

```cmd
slmgr /ckms
slmgr /skms azkms.core.windows.net:1688
slmgr /ato
```

These commands will request the activation of the Azure KMS host.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
