---
title: Azure Virtual Machine (VM) Windows OS Upgrade Assessment Tool
description: Azure VM Windows OS Upgrade Assessment Tool
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Azure VM Windows OS Upgrade Assessment Tool

**Applies to:** :heavy_check_mark: Windows VMs

## Overview

This PowerShell script is designed to assess the readiness of a Windows machine (desktop or server) for an **in-place OS upgrade**, with special considerations for **Azure VMs**. It evaluates OS version, supported upgrade paths, system disk space, and Azure security features like **Trusted Launch**, **Secure Boot**, and **vTPM**.

## Features

- **OS Version Detection**
  - Identifies whether the system is Windows 10, 11, or a Windows Server edition.
- **Server Upgrade Path Check**
  - Matches current server version to supported upgrade targets.
- **Hardware Validation**
  - Disk space (≥ 64 GB)
  - Physical memory (≥ 4 GB)
- **Azure VM Security Feature Verification**
  - Trusted Launch
  - Secure Boot
  - Virtual TPM
- **Azure Virtual Desktop (AVD) Detection**
  - Flags unsupported pooled host pool configurations.
- **Upgrade Recommendations**
  - Outputs supported upgrade paths or relevant upgrade guidance.

- [Azure VM Windows OS Upgrade Assessment Script](https://github.com/Azure/azure-support-scripts/blob/master/RunCommand/Windows/Windows_OSUpgrade_Assessment_Validation).


:::image type="content" source="media/windows-vm-osupgradeassessment-tool/windows-vm-osupgradeassessment-tool.png" alt-text="Azure portal view Run Command example." lightbox="media/windows-vm-osupgradeassessment-tool/windows-vm-osupgradeassessment-tool.png":::   

## How to run the tool

You can run the tool in any of the following manners.

### 1. Download from GitHub and run within the VM 

Download the scripts from GitHub, and then run them manually. To access the scripts, follow the resource links in the previous sections.

### 2. Use prepackaged Run Command scripts

For more information, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run **Windows_OSUpgrade_Assessment_Validation** to validate if the OS can be upgraded
2. Apply the suggested fixes or refer to the official documentation.

## Additional resources
- [In-place upgrade (server) for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade?context=/troubleshoot/azure/virtual-machines/windows/context/context)
- [In-place upgrade (client) for VMs running Windows in Azure](in-place-system-upgrade.md)

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]