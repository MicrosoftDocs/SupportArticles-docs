---
title: Static IP is missing from a virtual switch
description: Fixes an issue where the static IP information is missing from a virtual switch created in System Center 2012 Virtual Machine Manager SP1.
ms.date: 04/09/2024
ms.reviewer: wenca, alvinm
---
# Static IP is missing from a virtual switch created with System Center 2012 Virtual Machine Manager SP1

This article helps you fixes an issue where the static IP information is missing from a virtual switch created in System Center 2012 Virtual Machine Manager Service Pack 1 (SP1).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager Service Pack 1  
_Original KB number:_ &nbsp; 2800610

## Symptoms

When creating a virtual switch using System Center 2012 Virtual Machine Manager SP1 on a Windows Server 2012 Hyper-V host with a static IP, the static IP information is not present on the virtual switch.

## Cause

This issue can occur if a virtual network adapter is not created on the switch, or if the virtual network adapter doesn't have the setting **This virtual network adapter inherits settings from the physical management adapter** enabled.

## Resolution

When creating a virtual switch on a Hyper-V host, if you want the Network Interface Card (NIC) to send management information to Virtual Machine Manager, you need to create a management Virtual Network Interface Card (VNIC) adapter. This VNIC needs to be connected to a virtual machine network that doesn't have isolation enabled. If a VNIC isn't created, communication will only be allowed through the virtual machines that are connected.

If you want the static IP transferred to the virtual switch in Hyper-V, you need to check the setting **This virtual network adapter inherits settings from the physical management adapter** when creating the VNIC, otherwise it will obtain a DHCP address.
