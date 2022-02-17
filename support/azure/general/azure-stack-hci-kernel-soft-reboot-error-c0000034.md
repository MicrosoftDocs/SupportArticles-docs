---
title: Kernel Soft Reboot error c0000034
description: Describes a warning that occurs when you perform a Kernel Soft Reboot on a server with the Azure Stack HCI, version 21H2 installed.
ms.service: azure-stack
ms.date: 02/15/2022
ms.author: genli
author: genlin
ms.reviewer: katpa, v-abhjoa
---
# Error c0000034 when performing Kernel Soft Reboot

## Symptoms

Consider the following scenario:

- You have a server with the Azure Stack HCI, version 21H2 operating system installed.
- You perform a [Kernel Soft Reboot (KSR)](/azure-stack/hci/manage/kernel-soft-reboot) by running the `ksrcmd.exe /Verbose /Self` command in Windows PowerShell on the server.
- You perform the first reboot.

In this scenario, the following volmgr warning is logged as a system log in the Event Viewer:

> There was an error validating KSR data - Operational 1 status c0000034

## Solution

This warning message is harmless, and you can safely ignore it. The warning message won't show in Azure Stack HCI, version 21H2 and later versions.
