---
title: Troubleshoot virtual network peering problems in Azure Bastion
description: Troubleshoot virtual network peering problems in Azure Bastion, including connectivity and permission problems. Learn how to resolve access issues and restore connectivity quickly.
services: bastion
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: Usability
---

# Troubleshoot virtual network peering problems in Azure Bastion

## Summary

This article describes common virtual network peering problems in Azure Bastion and their resolutions.

## Common problems and resolutions

|Problem  |Description  |Resolution  |
|---------|---------|------|
|Can't see VM in peered virtual network|You have access to the peered virtual network, but you can't see the VM deployed there.|Make sure you have **read** access to both the VM and the peered virtual network. Additionally, check under IAM that you have **read** access to the following resources:<br><br>* Reader role on the virtual machine<br>* Reader role on the NIC with private IP of the virtual machine<br>* Reader role on the Azure Bastion resource<br>* Reader role on the virtual network (not needed if there isn't a peered virtual network)<br><br>For a complete list of required permissions, see the [virtual network peering permissions table](#virtual-network-peering-permissions).|

### Virtual network peering permissions

The following table lists the permissions required for accessing VMs in peered virtual networks:

|Permissions|Description|Permission type|
|---|---| ---|
|Microsoft.Network/bastionHosts/read |Gets a Bastion Host|Action|
|Microsoft.Network/virtualNetworks/BastionHosts/action |Gets Bastion Host references in a virtual network.|Action|
|Microsoft.Network/virtualNetworks/bastionHosts/default/action|Gets Bastion Host references in a virtual network.|Action|
|Microsoft.Network/networkInterfaces/read|Gets a network interface definition.|Action|
|Microsoft.Network/networkInterfaces/ipconfigurations/read|Gets a network interface IP configuration definition.|Action|
|Microsoft.Network/virtualNetworks/read|Get the virtual network definition|Action|
|Microsoft.Network/virtualNetworks/subnets/virtualMachines/read|Gets references to all the virtual machines in a virtual network subnet|Action|
|Microsoft.Network/virtualNetworks/virtualMachines/read|Gets references to all the virtual machines in a virtual network|Action|

## Resources

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)
