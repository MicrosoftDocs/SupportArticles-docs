---
title: Kernel Soft Reboot error c0000034
description: Describes a warning that occurs when you perform a Kernel Soft Reboot on a server with the Azure Stack HCI, version 21H2 installed.
ms.service: azure-stack
ms.date: 02/15/2022
ms.author: genli
author: genlin
ms.reviewer: katpa, v-abhjoa
appliesto:
- Azure Stack HCI, version 21H2
---
# Error c0000034 when performing Kernel Soft Reboot

This article provides information for an issue where you receive a warning message in Microsoft Azure Stack HCI, version 21H2 when performing Kernel Soft Reboot.

## Symptoms

When Azure Stack HCI, version 21H2 is installed on a system, consider the following scenario:

- Perform a [Kernel Soft Reboot (KSR)](/azure-stack/hci/manage/kernel-soft-reboot) by running the `ksrcmd.exe /Verbose /Self` command in Windows PowerShell on the server.
- Perform the first reboot.

In this scenario, the following volmgr warning is logged as a system log in the Event Viewer:

> There was an error validating KSR data - Operational 1 status c0000034

## Solution

This warning message is insignificant and you can safely ignore it. In later versions of Azure Stack HCI, version 21H2, the message will appear as an information event rather than a warning.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
