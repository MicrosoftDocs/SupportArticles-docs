---
title: Azure VM Ghosted Nic Cleanup Script
description: Azure VM Ghosted Nic Cleanup Script
ms.service: azure-virtual-machines
ms.date: 06/04/2024
ms.custom: sap:Cannot create a VM, H1Hack27Feb2017
ms.reviewer: macla, scotro, glimoli, jarrettr, azurevmcptcic
---
# Troubleshooting tools for Azure VM Ghosted Nic issues

**Applies to:** :heavy_check_mark: Windows VMs

When an Azure Virtual Machine running Windows Server or Windows Client with **Accelerated Networking** enabled is **deallocated**, the following may occur:

- Connectivity issues may occur for the active NIC
- Interference with scripts or automation that enumerate NICs
- Stale IP configurations associated with removed adapters may be present
- Windows Update download issues 
- Performance issues
- Windows Activation failures

`Ghosted nics` can happen to Azure virtual machines (VMs) causing connectivity, performance, Windows Update, and other issues. Microsoft provides a script-based tool to help diagnose and clean-up the ghost-nic issues.

## Tool overview

### Azure VM Ghosted Nic Validation and Cleanup Scripts

**Purpose**  
There two scripts that can be used to detect if there are 'ghosted nics' inside of the VM. A VM that has one ore more could experience issues.This script detects ghosted (disconnected) network interface cards (NICs) and remove them from the registry.

- [Azure VM - Windows Ghosted NIC Check Warning Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/GhostedNIC_Check_Time_warning)
- [Azure VM - Windows Ghosted NIC Check Removal Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_GhostedNIC_Removal_time)



**Key features**  

* Detects for Ghosted Nics
* Removes Ghosted Nics

For more information, see: 

- [Troubleshooting: Multiple Mellanox Ethernet Adapters After VM Deallocation (Ghost NICs)](./windows-vm-ghostednic-troubleshooting.md)
- [Azure VM - Windows Ghosted NIC Check Warning Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/GhostedNIC_Check_Time_warning)
- [Azure VM - Windows Ghosted NIC Check Removal Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_GhostedNIC_Removal_time)

## How to run the tools

You can run either of the tools in any of the following manners:

### 1. Manual Removal via Device Manager**
- Open **Device Manager** → **View** → **Show hidden devices** → Remove ghosted NICs.


### 1. Detect and Remove using provided tools

#### Download from GitHub and run within the VM 

Download the scripts from GitHub, and then run them manually. To access the scripts, follow the resource links in the previous sections.

#### Use Azure Run Command
   
- Navigate to your VM in the Azure portal: > **Operations** > **Run Command**.
- Select the script from the list (see the following screenshot).

**Only the [Azure VM - Windows Ghosted NIC Check Warning Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/GhostedNIC_Check_Time_warning) is available in this method. The other script can be run via the Run Command prepackeged method.**

:::image type="content" source="media/windows-vm-ghostednic-tool/windows-vm-ghostednicvalidationtool-portal-runcmd.png" alt-text="Azure portal view Run Command example." lightbox="media/windows-vm-ghostednic-tool/windows-vm-ghostednicvalidationtool-portal-runcmd.png":::   
  
> [!NOTE]
> Alternatively, you can run these commands by using a command-line interface (CLI) tool, Windows PowerShell, or Windows on ARM.

#### Use prepackaged Run Command scripts

For more information, see [Run scripts in your Windows VM by using action Run Commands](/azure/virtual-machines/windows/run-command).

## Recommended workflow

1. Run **[Azure VM - Windows Ghosted NIC Check Warning Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/GhostedNIC_Check_Time_warning)** to verify activation status and detect common issues.
2. If ghost-nics are detected, run [Azure VM - Windows Ghosted NIC Check Removal Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_GhostedNIC_Removal_time) to remove them.

### **Additional resources**

- [Troubleshooting: Multiple Mellanox Ethernet Adapters After VM Deallocation (Ghost NICs)](./windows-vm-ghostednic-troubleshooting.md)
- [Azure VM - Windows Ghosted NIC Check Warning Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/GhostedNIC_Check_Time_warning)
- [Azure VM - Windows Ghosted NIC Check Removal Script](https://github.com/Azure/azure-support-scripts/tree/master/RunCommand/Windows/Windows_GhostedNIC_Removal_time)

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]