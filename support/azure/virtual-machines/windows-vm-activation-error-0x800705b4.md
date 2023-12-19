---
title: Windows VM activation error 0x800705B4 (ERROR_TIMEOUT)
description: Provides a solution to an error 0x800705B4 that occurs when you try to activate an Azure Windows virtual machine (VM).
ms.date: 12/19/2023
ms.reviewer: cwhitley, v-naqviadil, v-weizhu
---
# Error 0x800705B4 when you activate an Azure Windows virtual machine

This article provides a solution to an error 0x800705B4 that occurs when you try to activate an Azure Windows virtual machine (VM).

## Symptoms

When you try to activate an Azure Windows VM, you receive the 0x800705B4 error:

> **Windows Activation**  
> A problem occured when Windows tried to activate. Error Code 0x00705B4.  
> For a possible resolution, click More Information. 
> Contact your system administrator or technical support department for assistance.

:::image type="content" source="media/windows-vm-activation-error-0x800705b4/error-0x800705b4.png" alt-text="Screenshot of the error 0x800705B4 and error message." border="false":::

It can also be displayed as the Security-SPP error (Event ID 8196) in the Application log.

## Cause

This error indicates a timeout. It could be caused by network connectivity or DNS resolution problems.

## Troubleshooting

Follow the steps in [Verify the connectivity between the VM and Azure KMS service](troubleshoot-activation-problems.md#step-2-verify-the-connectivity-between-the-vm-and-azure-kms-service) to check network connectivity problems, and then retry the activation.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]