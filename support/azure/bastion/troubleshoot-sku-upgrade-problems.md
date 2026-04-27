---
title: Troubleshoot Azure Bastion SKU upgrade problems
description: Troubleshoot Azure Bastion SKU upgrade problems, including subnet errors, timeouts, and missing features. Learn how to resolve each problem quickly.
services: bastion
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: sap:Configuration and setup
---

# Troubleshoot Azure Bastion SKU upgrade problems

## Summary

This article describes common problems encountered when upgrading your Azure Bastion SKU and their resolutions. For upgrade instructions, see [View or upgrade an Azure Bastion SKU](/azure/bastion/upgrade-sku).

## Common problems and resolutions

|Problem  |Description  |Resolution  |
|---------|---------|---------|
|Upgrade fails to start|When you try to upgrade your Bastion SKU, the operation fails immediately.|Verify you have Contributor or Owner role on the resource group containing your Bastion host.|
|Upgrade fails with subnet error|Upgrade from Developer SKU fails with a subnet-related error.|Create a subnet named **AzureBastionSubnet** with a /26 or larger prefix before upgrading. The Developer SKU uses shared infrastructure, while Basic, Standard, and Premium require a dedicated subnet.|
|Upgrade times out|The upgrade operation takes longer than expected or times out.|The upgrade process typically takes approximately 10 minutes. Wait a few minutes and check the Bastion host status in the portal. If the status shows updating, wait for completion. If the status shows failed, try the upgrade again.|
|Features not available after upgrade|After upgrading, expected features aren't available.|Features must be explicitly enabled after upgrading. Go to your Bastion host, select **Configuration**, and enable the desired features available for your new SKU tier.|

## Resources

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)