---
title: Azure Hybrid Use Benefit images for EA subscriptions
description: Describes that the Windows Server images that are pre-configured with Hybrid Use Benefit for EA subscriptions will be removed from the Azure Marketplace by August 31, 2017.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-support-statements
ms.collection: windows
---
# Retirement: Azure Hybrid Use Benefit images for EA subscriptions

This article describes that the Windows Server images that are pre-configured with Hybrid Use Benefit for EA subscriptions will be removed from the Azure Marketplace by August 31, 2017.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4036360

## Retirement of the Hybrid Use Benefit images

As of April 12, 2017, Hybrid Use Benefit is open for all Azure subscriptions and can be applied to the regular Windows Server images in the Azure Marketplace. Therefore, be aware of the following news for the Windows Server images that are pre-configured with Hybrid Use Benefit for EA subscriptions:

- The last patch update will be July 2017.
- The image SKUs will be removed by August 31, 2017.

### Experience in the Azure portal

| **OS**| **Image SKUs** |
|---|---|
|Windows Server 2016|Windows Server 2016 Datacenter|
|Windows Server 2012 R2|Windows Server 2012 R2 Datacenter|
|Windows Server 2012|Windows Server 2012 Datacenter|
|Windows Server 2008 R2|Windows Server 2008 R2 SP1|
  
### New experience in the Azure Resource Manager (ARM), Azure PowerShell, and Azure Command Line Interface (CLI) starting September 1, 2017

| **OS**| **Image offer**| **Image SKUs** |
|---|---|---|
|Windows Server 2016|WindowsServer|2016-Datacenter|
|Windows Server 2012 R2|WindowsServer|2012-R2-Datacenter|
|Windows Server 2012|WindowsServer|2012-Datacenter|
|Windows Server 2008 R2|WindowsServer|2008-R2-SP1|
  
## About the Hybrid Use Benefit images

In November 2016, Azure introduced a second set of Windows Server Marketplace image SKUs to enable Enterprise Agreement (EA) subscriptions to use Hybrid Use Benefit. See [how to deploy a Windows Server image with Hybrid Use Benefits in Azure](/azure/virtual-machines/windows/hybrid-use-benefit-licensing).

### Current experience in the Azure portal

These image SKUs are prefixed by "[HUB]" on the Azure portal.

| **OS**| **Image SKUs** |
|---|---|
|Windows Server 2016|[HUB] Windows Server 2016 Datacenter|
|Windows Server 2012 R2|[HUB] Windows Server 2012 R2 Datacenter|
|Windows Server 2012|[HUB] Windows Server 2012 Datacenter|
|Windows Server 2008 R2|[HUB] Windows Server 2008 R2 SP1|
  
### Current experience in the ARM, Azure PowerShell, and Azure CLI

These image SKUs are appended by "-HUB" on the Azure portal.

| **OS**| **Image offer**| **Image SKUs** |
|---|---|---|
|Windows Server 2016|WindowsServer-HUB|2016-Datacenter-HUB|
|Windows Server 2012 R2|WindowsServer-HUB|2012-R2-Datacenter-HUB|
|Windows Server 2012|WindowsServer-HUB|2012-Datacenter-HUB|
|Windows Server 2008 R2|WindowsServer-HUB|2008-R2-SP1-HUB|
  
## Action required

Make sure that your virtual machine deployment is updated to use the new image SKUs.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
