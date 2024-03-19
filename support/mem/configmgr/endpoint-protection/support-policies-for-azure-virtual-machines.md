---
title: Support policies for Azure Virtual Machines
description: Describes the support policy for System Center 2012 Configuration Manager and System Center 2012 Endpoint Protection to manage server software in the Azure Virtual Machine environment.
ms.date: 12/05/2023
ms.reviewer: kaushika, mikecure
ms.custom: sap:Endpoint Protection\Antimalware Policies
---
# System Center 2012 Configuration Manager and System Center 2012 Endpoint Protection support for Azure Virtual Machines

This article introduces the support policy for Microsoft System Center 2012 Configuration Manager and System Center 2012 Endpoint Protection to manage server software in the Microsoft Azure Virtual Machine environment (infrastructure-as-a-service).

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, System Center 2012 Endpoint Protection  
_Original KB number:_ &nbsp; 2889321

## Supported scenarios and features

System Center 2012 Configuration Manager Service Pack 1 (SP1) or later versions and System Center 2012 Endpoint Protection SP1 or later versions support two specific scenarios to manage server software in the Microsoft Azure Virtual Machine environment.

The following table lists the scenarios and supported Configuration Manager features in each scenario.

|Supported scenarios|Supported Configuration Manager features|
|---|---|
|Use an existing on-premises Configuration Manager infrastructure to manage Azure Virtual Machines that are running Windows Server or Linux.|For Windows Server:<ul><li>Application Management</li><li>Compliance Settings</li><li>Endpoint Protection</li><li>Inventory - Software, Hardware, and Asset Intelligence</li><li>Network Access Protection</li><li>Software Updates Deployment</li><li>Software Metering</li><li>Remote Control</li><li>Reporting</li></ul>For Linux:<ul><li> Software Distribution</li><li>Endpoint Protection</li><li>Inventory - Hardware, Software</li><li>Reporting</li></ul>|
|Set up a single stand-alone primary site in the Azure Virtual Machine environment to manage Azure Virtual Machines that are running Windows Server or Linux in the same virtual network.<br/><br/>The all-in-one, stand-alone primary site is a single Azure Virtual Machine that runs all required site system roles and Microsoft SQL Server locally without using any remote site systems or roles.|For Windows Server:<ul><li>Application Management</li><li>Compliance Settings</li><li>Endpoint Protection</li><li>Inventory - Software, Hardware, and Asset Intelligence</li><li>Software Updates Deployment</li><li>Software Metering</li><li>Remote Control</li><li>Reporting</li></ul>For Linux:<ul><li>Software Distribution</li><li>Endpoint Protection</li><li>Inventory - Hardware, Software</li><li>Reporting</li></ul>|
  
The following Linux distributions are endorsed for Microsoft Azure Virtual Machines in the supported scenarios:

- Canonical Ubuntu 12.04
- OpenLogic CentOS 6.3
- SUSE Linux Enterprise Server 11 SP2

> [!NOTE]
> The Linux-based virtual machines must be running version 1.0.0.4648 or later versions of the Linux client for Configuration Manager.

## References

For more information about the endorsed Linux distributions for Azure Virtual Machines, see [Endorsed Linux distributions on Azure](/azure/virtual-machines/linux/endorsed-distros?toc=%2Fazure%2Fvirtual-machines%2Flinux%2Ftoc.json).

For more information about supported Microsoft server software in the Azure Virtual Machine environment, see [Microsoft server software support for Microsoft Azure Virtual Machines](https://support.microsoft.com/help/2721672).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
