---
title: Troubleshooting tool for Resetting Windows Update Servicing Stack
description: Troubleshooting tool for Resetting Windows Update Servicing Stack
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Resetting Windows Update servicing stack

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

This article offers you steps to run a script that will try to reset the Windows Servicing stack for a virtual machine running in Azure. Running the tool may fix problems that prevent Windows Update from installing successfully. \

This script is designed for troubleshooting update failures on Windows Server or Windows client systems.

> [!NOTE]
> This article is intended for use by support agents and IT professionals. If you're home users and looking for more information about fixing Windows update errors, see [Fix Windows Update errors](https://support.microsoft.com/help/10164).


## Features  
This PowerShell script automates the process by:

- Stopping key services: **wuauserv**, **cryptsvc**, and **BITS**
- Renaming critical folders:  
  - `%SystemRoot%\SoftwareDistribution`  
  - `%SystemRoot%\System32\catroot2`  
  (with a timestamp for backup)
- Re-registering core update-related DLLs (skipping any missing files)
- Restarting services
- Generating a summary of actions performed


:::image type="content" source="media/windows-vm-wureset-tool/windows-vm-wureset-tool.png" alt-text="Azure portal view Run Command example." lightbox="media/windows-vm-imds-tool/windows-vm-wureset-tool/windows-vm-wureset-tool.pmg":::   

For more information, see: 

- [Resetting Windowsu Update Servicing Stack script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_Update_Reset).



## Requirements

- PowerShell 5.1 or later.
- Script must be run with administrative privileges.

## How to run the tool

You can run the tool in any of the following manners.

### 1. Download from GitHub and run within the VM 

Download the scripts from GitHub, and then run them manually. To access the scripts, follow the resource links in the previous sections.

### 2. Use prepackaged Run Command scripts

For more information, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run **IMDS Cert Check** to verify activation status and detect common issues.
2. Apply the suggested fixes or refer to the official documentation for advanced troubleshooting.

### **Additional resources**


- [Resetting Windowsu Update Servicing Stack script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_Update_Reset).


[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]