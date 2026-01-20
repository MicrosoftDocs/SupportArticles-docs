---
title: Metrics Collection Checkbox for Dynatrace Is Unavailable  
description: Resolve the issue in which the metrics collection checkbox is unavailable because the user lacks Owner permissions on the subscription.
author: agrimayadav
ms.author: jarrettr
ms.reviewer: v-ryanberg
manager: dcscontentpm
ms.service: partner-services
ms.custom:
  - sap:Dynatrace on Azure
ms.topic: troubleshooting-problem-resolution
ms.date: 09/22/2025
ai-usage: ai-assisted

# customer intent: As an Azure administrator or user, I want to enable the Metrics checkbox so that I can enable metrics collection for Dynatrace.

---

# Metrics collection checkbox is unavailable 

This article helps you resolve the issue where the **Enable metrics collection** checkbox is unavailable in your Dynatrace integration because the signed-in account doesn't have [Owner role permissions](/azure/role-based-access-control/built-in-roles#owner) on the Azure subscription.

## Prerequisites

- Access to the [Azure portal](https://portal.azure.com/) and the subscription that contains the resource.

## Symptoms

- The **Enable metrics collection** checkbox is unavailable (grayed out) in the Dynatrace integration UI.
- Attempting to enable metrics collection results in an error or no action.

## Cause

Enabling metrics collection requires Owner role permissions at the subscription scope. Users with Contributor or Reader role permissions can't enable metrics collection from the integration UI and the checkbox is unavailable.

## Solution: Request Owner role permission

1. In the Azure portal, go to the subscription that contains the resource.
2. Select **Access control (IAM)**.
3. Select **View my access** to see your current role at the subscription scope.

If you don't have Owner role permissions, contact the subscription Owner or admin and request Owner role permissions or ask them to enable metrics collection for you. After the Owner or admin assigns the role, wait 5–15 minutes for role-based access control (RBAC) propagation and then retry enabling metrics collection in the Dynatrace integration.

## Resource

- [Azure role-based access control (RBAC)](/azure/role-based-access-control/)
- [Assign Azure roles using the Azure CLI](/azure/role-based-access-control/role-assignments-cli)

 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]