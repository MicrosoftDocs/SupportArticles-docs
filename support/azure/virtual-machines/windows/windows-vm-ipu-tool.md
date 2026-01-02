---
title: Azure Virtual Machine (VM) Windows Update Error Detection tool
description: Scan CBS Logs for Windows Servicing Errors
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.date: 11/18/2025
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic, v-ryanberg
---
# Azure Virutal Machine (VM) Windows Update error detection tool

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

This PowerShell script scans **Component-Based Servicing (CBS) logs** for known Windows servicing error codes that indicate issues requiring an **in-place upgrade (IPU)** or repair. It counts occurrences of each error code and provides a summary at the end. If any errors are found, a remediation link to Microsoft documentation is displayed.

## Features

- Scans CBS logs and archived `.zip` logs in *C:\Windows\Logs\CBS\*.
- Filters based on a configurable date range (default: last 30 days).
- Categorizes errors by severity: `Critical`, `High`, `Medium`, `Low`.
- Displays a summary of error occurrences.
- Provides remediation guidance link if errors are detected.

For more information, see [Azure VM Windows Update Error Detection script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_Update_IPU_Validation).

:::image type="content" source="media/windows-vm-ipu-tool/windows-vm-ipu-tool.png" alt-text="Azure portal view Run Command example." lightbox="media/windows-vm-ipu-tool/windows-vm-ipu-tool.png":::   

## How to run the tool

You can run the tool in any of the following manners.

### 1. Download from GitHub and run within the VM 

Download the scripts from GitHub and then run them manually. To access the scripts, follow the resource links in the previous sections.

### 2. Use prepackaged run command scripts

For more information, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run `windows-vm-ipu-tool` to verify activation status and detect common issues.
2. Apply the suggested fixes or refer to the official documentation for advanced troubleshooting.

### Additional resources

- [Azure VM Windows Update Error Detection script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_Update_IPU_Validation)
- [Windows Update errors that require in-place upgrades for Azure VMs](windows-update-errors-requiring-in-place-upgrade.md)
- [In-place upgrade (server) for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)
- [In-place upgrade (client) for VMs running Windows in Azure](in-place-system-upgrade.md)


 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]