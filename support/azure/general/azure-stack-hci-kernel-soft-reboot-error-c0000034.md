---
title: Kernel Soft Reboot error c0000034 on Dell EMC server
description: Describes a warning that occurs when you perform a Kernel Soft Reboot on Dell EMC Integrated System with the Azure Stack HCI, version 21H2 installed.
ms.date: 02/15/2022
ms.author: genli
author: genlin
ms.reviewer: katpa, v-abhjoa
---
# Error c0000034 when performing Kernel Soft Reboot on Dell EMC server

## Symptoms

Consider the following scenario:

- You have Dell EMC Integrated System with the Azure Stack HCI, version 21H2 operating system installed.
- You perform a Kernel Soft Reboot (KSR) by running the `ksrcmd.exe /Verbose /Self` command in Windows PowerShell on the Dell EMC server.
- You perform the first reboot.

In this scenario, the following volmgr warning is logged as a system log in the Event Viewer:

> There was an error validating KSR data - Operational 1 status c0000034

## Status

Microsoft is investigating this issue and will post more information in this article when a fix becomes available.
