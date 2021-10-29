---
title: Azure Extension Supported Operating Systems
description: Provides a list of operating systems that extensions can support.
ms.date: 07/21/2020
ms.prod-support-area-path: 
ms.reviewer: 
ms.service: virtual-machines
---
# Azure Extension supported operating systems

_Original product version:_ &nbsp; Virtual Machine running Linux, Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4078134

VM Extensions enable post-deployment configuration of VM, such as installing and configuring software. VM extensions also enable recovery features such as resetting the administrative password of a VM. Without the Azure VM Agent, VM extensions cannot be run. 

* The Windows VM Agent needs at least Windows Server 2008 SP2 (64-bit) to run, with the .NET Framework 4.0.
* The Linux agent runs on [multiple OSes](https://docs.microsoft.com/azure/virtual-machines/extensions/agent-linux#requirements), however the extensions framework has a limit for the OSes that support extensions.

Some extensions are not supported across all OSes and may emit Error Code 51, 'Unsupported OS'. Check the individual extension documentation for supportability.

For a discussion of Windows and Linux extensions and how to troubleshoot extensions, see [Azure virtual machine extensions and features](https://docs.microsoft.com/azure/virtual-machines/extensions/overview). 

Further troubleshooting guidance can be found at:

* [Azure VM extensions and features for Windows](https://docs.microsoft.com/azure/virtual-machines/extensions/features-windows#troubleshoot-vm-extensions)
* [Azure VM extensions and features for Linux](https://docs.microsoft.com/azure/virtual-machines/extensions/features-linux#troubleshoot-vm-extensions)
