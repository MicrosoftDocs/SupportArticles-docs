---
title: Troubleshoot DNS and Private Link problems with Azure Bastion
description: Troubleshoot DNS and Private Link problems with Azure Bastion by identifying common causes and fixes for name resolution and Private Link problems. Find fixes.
services: bastion
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 04/06/2026
ms.custom: Connectivity
---

# Troubleshoot DNS and Private Link problems with Azure Bastion

## Summary

This article describes common DNS and Private Link problems with Azure Bastion and provides resolutions to help you restore connectivity.

## Common problems and resolutions

|Problem  |Description  |Resolution  |
|---------|---------|------|
|privatelink.azure.com can't resolve to management.privatelink.azure.com|DNS resolution fails for management.privatelink.azure.com when using privatelink.azure.com zone.|This problem might occur when the private DNS zone for privatelink.azure.com is linked to the Bastion virtual network, causing management.azure.com CNAMEs to resolve to management.privatelink.azure.com. To resolve this problem, create a CNAME record in your privatelink.azure.com zone for management.privatelink.azure.com to arm-frontdoor-prod.trafficmanager.NET.|

## Resources

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)



