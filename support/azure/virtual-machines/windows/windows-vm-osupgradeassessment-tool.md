---
title: Azure Virtual Machine (VM) Windows OS Upgrade Assessment Tool
description: Azure Virtual Machine (VM) Windows OS Upgrade Assessment Tool
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.date: 11/18/2025
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic, v-ryanberg
---
# Azure Virtual Machine (VM) Windows OS Upgrade assessment tool

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

This PowerShell script is designed to assess the readiness of a Windows machine (desktop or server) for an **in-place OS upgrade**, with special considerations for **Azure VMs**. It evaluates OS version, supported upgrade paths, system disk space, and Azure security features like **Trusted Launch**, **Secure Boot**, and **virtual trusted platform modules (vTPMs)**.

## Features

- **OS version detection**
  - Identifies whether the system is Windows 10, 11, or a Windows Server edition.
- **Server upgrade path check**
  - Matches current server version to supported upgrade targets.
- **Hardware validation**
  - Disk space (greater than or equal to 64 GB).
  - Physical memory (greater than or equal to 4 GB).
- **Azure VM security feature verification**
  - Trusted Launch.
  - Secure Boot.
  - vTPM.
- **Azure Virtual Desktop detection**
  - Flags unsupported pooled host pool configurations.
- **Upgrade recommendations**
  - Outputs supported upgrade paths or relevant upgrade guidance.

For more information, see [Azure VM Windows OS Upgrade Assessment Script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_OSUpgrade_Assessment_Validation).


:::image type="content" source="media/windows-vm-osupgradeassessment-tool/windows-vm-osupgradeassessment-tool.png" alt-text="Azure portal view Run Command example." lightbox="media/windows-vm-osupgradeassessment-tool/windows-vm-osupgradeassessment-tool.png":::   

## How to run the tool

You can run the tool in any of the following manners.

### 1. Download from GitHub and run within the VM 

Download the scripts from GitHub and then run them manually. To access the scripts, follow the resource links in the previous sections.

### 2. Use prepackaged run command scripts

For more information, see [Run scripts in your Windows VM by using action run commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run `Windows_OSUpgrade_Assessment_Validation` to verify the OS can be upgraded.
2. Apply the suggested fixes or refer to the official documentation.

## Additional resources

- [In-place upgrade (server) for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade?context=/troubleshoot/azure/virtual-machines/windows/context/context)
- [In-place upgrade (client) for VMs running Windows in Azure](in-place-system-upgrade.md)

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]