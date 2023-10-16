---
title: 0x8000FFFF error when starting VM
description: Provides a solution to fix the 0x8000FFFF error that occurs when you start a Virtual Machine (VM) on a Windows Server 2012 R2-based Hyper-V server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, shenry, liexgu
ms.custom: sap:virtual-machine-will-not-boot, csstroubleshoot
ms.technology: hyper-v
---
# Catastrophic failure (0x8000FFFF) error when you start a VM on a Windows Server 2012 R2-based Hyper-V server

This article provides a solution to fix the 0x8000FFFF error that occurs when you start a Virtual Machine (VM) on a Windows Server 2012 R2-based Hyper-V server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2960802

## Symptoms

Consider the following scenario:

- You have a Windows Server 2012-based Hyper-V server.
- You have RemoteFX 3D Adapter (vGPU) enabled on a VM.
- You put the VM in saved state, and then upgrade the host server to Windows Server 2012 R2.
- You start the saved vGPU VM after the upgrade.
- You connect to the vGPU VM, and then restart the VM.

In this scenario, the vGPU VM cannot start. The following error message is received:
> '**\<hostname>**' Microsoft Video Monitor (Instance ID BA8735EF-E3A9-4F1B-BADD-DBF3A5909915): Failed to restore with Error 'Catastrophic failure' (0x8000FFFF). (Virtual machine ID 65DDF80E-B83D-4967-84A6-96BB935D66CF)

## Resolution

To work around this issue, follow these steps:

1. Start Command Prompt with elevated permissions, and then run the following command:

    ```console
    Net stop vmms
    ```

    If it prompts, input yes to stop the Remote Desktop Virtualization Host Agent service.
2. Open the configuration XML of the VM. Generally, the file is under the Virtual Machines folder of the VM.
3. Find the VDEVVersion tag that has a value of 512. Reduce this value to 256, and then save the XML file.
4. Start Command Prompt with elevated permissions, and then run the following command:

    ```console
    Net start vmhostagent
    ```

5. Try to start the VM again.

## Status

Microsoft has confirmed this is a problem in the Microsoft products that are listed in the "Applies to" section.
