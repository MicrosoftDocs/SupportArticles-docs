---
title: Troubleshoot network security group configuration problems in Azure Bastion
description: Resolve network security group (NSG) configuration problems in Azure Bastion by identifying common causes and fixes for NSG-related problems. Find fixes.
services: bastion
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: Configuration and setup
---

# Troubleshoot network security group configuration problems

## Summary

This article describes common Azure Bastion network security group (NSG) configuration problems and how to fix them.

## Common problems and resolutions

|Problem  |Description  |Resolution  |
|---------|---------|---------|
|Unable to create an NSG on AzureBastionSubnet|When you try to create an NSG on the Azure Bastion subnet, you get the following error: *'Network security group \<NSG name\> doesn't have necessary rules for Azure Bastion Subnet AzureBastionSubnet"*.|If you create and apply an NSG to *AzureBastionSubnet*, make sure you add the required rules to the NSG. For a list of required rules, see [Working with NSG access and Azure Bastion](/azure/bastion//bastion-nsg). If you don't add these rules, the NSG creation or update fails.<br><br>For an example of the NSG rules, see the [quickstart template](https://azure.microsoft.com/resources/templates/azure-bastion-nsg/). For more information, see [NSG guidance for Azure Bastion](/azure/bastion/bastion-nsg).|


## Resources

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)
- [Working with NSG access and Azure Bastion](/azure/bastion/bastion-nsg)
