---
title: Microsoft Web App Azure App Service Compliance with PCI Standards 3.0 and 3.1
description: PCI DSS version 3.1 certification requires disabling TLS 1.0. If you are using App Service Environments or are willing to migrate your workload to App Service Environments, you can get greater control of your environment.
author: genlin
ms.author: genli
ms.service: azure-app-service
ms.date: 08/14/2020
ms.reviewer: 
---
# Azure App Service Compliance with PCI Standards 3.0 and 3.1

_Original product version:_ &nbsp; Web App (Windows)  
_Original KB number:_ &nbsp; 3124528

The Azure App Service is currently in compliance with PCI DSS version 3.0 Level 1. We have also noted customer requests that make reference to PCI DSS version 3.1, and specifically the change from version 3.0 to 3.1, which states that SSL and "early TLS versions " will no longer be considered valid security options from June 30, 2018. From June 30th, 2018, the multi-tenant hosting model for Azure App Service, will be accepting TLS 1.2 with an option for customers to select their required TLS encryption level.

## What this means

PCI DSS version 3.1 certification requires disabling TLS 1.0. If you are using App Service Environments or are willing to migrate your workload to App Service Environments, you can get greater control of your environment including disabling TLS 1.0, for more information, see [Custom configuration settings for App Service Environments](/azure/app-service/environment/app-service-app-service-environment-custom-settings).

## More information

Microsoft regularly reviews standards compliance procedures and will periodically update compliance baselines as standards bodies update and change their requirements. As part of Microsoft's Fiscal 2017 compliance planning, PCI standards will again be re-reviewed and technical determinations will be made. To view the current certifications, technical determinations will be made. To view the current certifications, visit the [Microsoft Azure Trust Center: Compliance site](https://azure.microsoft.com/support/trust-center/compliance/).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
