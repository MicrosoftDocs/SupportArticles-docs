---
title: Setup fails on VM with error 0xE0000100
description: Describes an issue in which you receive an error 0xE0000100 that occurs when Windows Server 2012 R2 setup fails on a virtual machine.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, luche
ms.custom: sap:setup, csstroubleshoot
---
# Windows Server 2012 R2 setup may fail on a virtual machine that is configured to use the minimum required memory

This article provides workarounds for an issue where Windows Server 2012 R2 setup fails with error 0xE0000100 on a virtual machine.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2901152

## Symptoms

Consider the following scenario:

- You create a virtual machine that is configured to use the minimum RAM requirement (512 megabytes [MB]).
- You start the virtual machine from an ISO image file.
- You try to set up Windows Server 2012 R2 on the virtual machine.

In this scenario, the setup fails, and you receive the following error message:
> Windows installation encountered an unexpected error. Verify that the installation sources are accessible, and restart the installation.  
>
> Error code: 0xE0000100

## Cause

This issue occurs because of insufficient memory during setup.

## Workaround

To work around this issue, use one of the following methods:

- Create a page file. To do this, follow these steps:
  1. When the virtual machine starts, press Shift + F10 to open the Command Prompt window.
  2. Run Diskpart.exe to create and format the partition (for example, C:) on which you want to install Windows Server 2012 R2.
  3. Run the following command to create a page file that has default size of 64 MB:

        ```console
        wpeutil createpagefile /path=C:\pf.sys
        ```

  4. Exit the Command Prompt window, and then continue the setup.
- Increase the allocated memory of the virtual machine before setup.
- Create and set up another virtual machine that is configured to use more memory, and then attach the virtual hard disk.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
