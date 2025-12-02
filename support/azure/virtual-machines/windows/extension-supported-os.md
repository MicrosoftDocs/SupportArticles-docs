---
title: Azure Extension Supported Operating Systems
description: Provides a list of operating systems that extensions can support.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: azure-virtual-machines
ms.custom: sap:VM Extensions not operating correctly
---
# Azure extension-supported operating systems

**Applies to:** :heavy_check_mark: Linux VMs :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4078134


[!INCLUDE [VM assist troubleshooting tools](~/includes/azure/vmassist-include.md)]

VM extensions enable post-deployment configuration of a virtual machine (VM), including installing and configuring software. VM extensions also enable recovery features, such as resetting the administrative password of a VM. Without the Azure VM Agent, VM extensions can't be run.

* In order to run, the Windows VM Agent requires at least Windows Server 2008 SP2 (64-bit) and .NET Framework 4.0.
* The Linux agent runs on [multiple systems](/azure/virtual-machines/extensions/agent-linux#requirements). However, the extensions framework has a limit for the systems that support extensions.

Some extensions aren't supported across all systems. They might return Error Code 51, 'Unsupported OS'. Check the individual extension documentation for supportability.

For a discussion about Windows and Linux extensions and how to troubleshoot extensions, see [Azure virtual machine extensions and features](/azure/virtual-machines/extensions/overview).

Further troubleshooting guidance can be found at:

* [Azure VM extensions and features for Windows](/azure/virtual-machines/extensions/features-windows#troubleshoot-vm-extensions)
* [Azure VM extensions and features for Linux](/azure/virtual-machines/extensions/features-linux#troubleshoot-vm-extensions)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
