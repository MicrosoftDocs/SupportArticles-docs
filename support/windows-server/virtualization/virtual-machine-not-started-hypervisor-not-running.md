---
title: Virtual machine could not start because the hypervisor is not running error in Windows Server
description: Fixes an issue that you're unable to start virtual machines because of incorrect DEP setting in BIOS.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: stevenxu, kaushika
ms.custom: sap:virtual-machine-will-not-boot, csstroubleshoot
ms.technology: hyper-v
---
# Error in Windows Server: Virtual machine could not start because the hypervisor is not running

This article helps fix an issue that you're unable to start virtual machines because of incorrect DEP setting in BIOS.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2490458

## Symptoms

Consider the following scenario:

1. You install the Hyper-V role on a computer that is running Windows Server.
2. You create a virtual machine and attempt to start the virtual machine.
3. You may see the following event ID:

    > Log Name: Microsoft-Windows-Hyper-V-Worker-Admin  
    Source: Microsoft-Windows-Hyper-V-Worker  
    Event ID: 3112  
    Level: Error  
    Description:  
    The virtual machine could not be started because the hypervisor is not running.  

In this scenario, you're unable to start the virtual machine and receive the error message below:

> Virtual machine could not start because the hypervisor is not running.

## Cause

The Data Execution Prevention (DEP) setting isn't enabled in BIOS. For HP server, it's called "No Execute Memory Protection."

## Resolution

To fix the issue, enable the DEP setting in BIOS.

## More information

[Hyper-V Installation Prerequisites](https://technet.microsoft.com/library/cc731898.aspx)
