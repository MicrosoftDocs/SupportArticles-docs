---
title: Troubleshoot deployment and configuration problems in Azure Bastion
description: Troubleshoot common Azure Bastion deployment and configuration problems, including subnet errors, deployment failures, and force-tunneling problems. Learn how to resolve them.
services: bastion
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: sap:Configuration and setup
---

# Troubleshoot deployment and configuration problems

## Summary

This article describes common Azure Bastion deployment and configuration problems and their resolutions.

## Common problems and resolutions

|Problem  |Description  |Resolution  |
|---------|---------|---------|
|Failed to add subnet error|When you try to use **Deploy Bastion** in the portal, you get a **Failed to add subnet** error.|For most address spaces, add a subnet named **AzureBastionSubnet** to your virtual network before you select **Deploy Bastion**.|
|Deployment failures|Deployment of Azure Bastion fails with errors.|Review any error messages and [raise a support request in the Azure portal](/azure/azure-portal/supportability/how-to-create-azure-support-request) as needed. Deployment failures can result from [Azure subscription limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits). Specifically, you might encounter a limit on the number of public IP addresses allowed per subscription that causes the Azure Bastion deployment to fail.|
|Moving virtual network to another resource group|You want to move your virtual network to a different resource group.|Moving a virtual network with Bastion isn't directly supported. You must first delete Bastion from the virtual network, then move the virtual network to the new resource group. Once the virtual network is in the new resource group, you can deploy Bastion to the virtual network.|
|Force-tunneling Internet traffic|You're advertising a default route (0.0.0.0/0) over ExpressRoute or VPN.|Force-tunneling with Azure Bastion isn't supported if you're advertising a default route over ExpressRoute or VPN. Azure Bastion needs to communicate with certain internal endpoints. Ensure the host virtual network isn't linked to a private DNS zone with these exact names: `management.azure.com`, `blob.core.windows.NET`, `core.windows.NET`, `vaultcore.windows.NET`, `vault.azure.NET`, or `azure.com`. You can use private DNS zones ending with these names (for example: `privatelink.blob.core.windows.NET`). Azure Bastion isn't supported with Azure Private DNS Zones in national clouds.|

## Resources

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)
- [Azure Bastion configuration settings](/azure/bastion/configuration-settings)