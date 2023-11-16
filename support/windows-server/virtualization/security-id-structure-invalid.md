---
title: The security ID structure is invalid
description: Starting an imported virtual machine under Hyper-V sometimes fails with an error message that states.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, BenArm, SWernli
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
ms.technology: hyper-v
---
# Virtual machine can't start - The security ID structure is invalid (0x80070539)

This article provides a solution to an error that occurs when you start an imported virtual machine under Hyper-V.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2927313

## Symptoms

Starting an imported virtual machine under Hyper-V sometimes fails with an error message that states:

> The security ID structure is invalid (0x80070539)

## Cause

This issue is caused when a virtual machine is moved from one environment to another, and Hyper-V can't remove an invalid security ID from the virtual machine configuration as part of the import operation.

## Resolution

A user can reset the state of security IDs in the virtual machine configuration by adding a new, valid user ID. To do this, you'll need to:

1. Open an administrative PowerShell command window.
2. Run the following command:

    ```console
    Grant-VMConnectAccess -VMName "Name of VM that is not starting" -UserName "Domain and username of the current user"
    ```

The virtual machine should now be able to start successfully.
