---
title: Azure Virtual Machines (VM) Windows Servicing Stack Reset Tool
description: Azure VM Windows Servicing Stack Reset Tool
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.date: 11/18/2025
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Azure Virtual Machine (VM) Windows servicing stack reset tool

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

This article covers steps to run a PowerShell script that resets the Windows servicing stack for a VM running in Azure. Running the tool can fix most problems that prevent Windows Updates from installing successfully. 

> [!NOTE]
> This article is intended for use with support agents and IT professionals. If you're a home user and looking for more information about fixing Windows update errors, see [Fix Windows Update errors](https://support.microsoft.com/help/10164).


## Features  

- Stops key services: `wuauserv`, `crypts`, and `BITS`.
- Renames critical folders:  
  - *%SystemRoot%\SoftwareDistribution*.
  - *%SystemRoot%\System32\catroot2* (with a timestamp for backup).
- Re-registers core update-related DLLs (skipping any missing files).
- Restarts services.
- Generates a summary of actions performed.

For more information, see [Resetting Windows Update servicing stack script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_WUA_Update_Reset?).


:::image type="content" source="media/windows-vm-wureset-tool/windows-vm-wureset-tool.png" alt-text="Azure portal view Run Command example." lightbox="media/windows-vm-wureset-tool/windows-vm-wureset-tool.png":::   

## How to run the tool

You can run the tool in any of the following manners.

### 1. Download from GitHub and run within the VM 

Download the scripts from GitHub and then run them manually. To access the scripts, follow the resource links in the previous sections.

### 2. Use prepackaged run command scripts

For more information, see [Run scripts in your Windows VM by using action run commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run `Windows_Update_Reset` to reset the servicing stack.
2. Try to install the Windows Update that previously failed.

## Additional resources

- [Resetting Window Update servicing stack script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_Update_Reset).


[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]