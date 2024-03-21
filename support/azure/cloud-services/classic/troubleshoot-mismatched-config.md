---
title: Troubleshoot Cloud Service mismatched .cscfg and .csdef schemas
description: Troubleshoot InvalidModel/BadRequest exceptions while deploying Azure cloud services (classic). Fix config schema (.cscfg) and definition schema (.csdef) files.
ms.service: cloud-services
ms.subservice: troubleshoot-deployment-classic
ms.date: 09/26/2022
ms.reviewer: chiragpa, v-leedennis
articleID: cab2e0b3-d753-4461-8a1e-38fc7629304e 
---
# Troubleshooting Cloud Service (classic) InvalidModel exception

> [!IMPORTANT]
> Cloud Services (classic) is now deprecated for new customers, and it will be retired on August 31st, 2024 for all customers. New deployments should use the new Azure Resource Manager-based deployment model, Azure Cloud Services (extended support).

This article helps you troubleshoot an InvalidModel or BadRequest exception that occurs when you deploy Azure cloud services.

## Cause

An InvalidModel or BadRequest exception was thrown during the deployment because of a service configuration and definition file mismatch.

## Solution

Review your service configuration (.cscfg) and service definition (.csdef) files so that all parameters are entered correctly.

Use [Azure Cloud Services (classic) configuration schema (.cscfg file)](/azure/cloud-services/schema-cscfg-file) and [Azure Cloud Services (classic) definition schema (.csdef file)](/azure/cloud-services/schema-csdef-file) as references for correcting each file.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
