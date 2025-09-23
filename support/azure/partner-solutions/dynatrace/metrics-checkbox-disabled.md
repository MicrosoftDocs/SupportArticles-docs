---
title: Metrics Collection Checkbox for Dynatrace Is Unavailable  
description: Resolve the issue in which the metrics collection checkbox is unavailable because the user lacks Owner permissions on the subscription.
author: 
ms.author: jarrettr
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.date: 09/22/2025
ai-usage: ai-assisted

# customer intent: As an Azure administrator or user, I want to enable the Metrics checkbox so that I can enable metrics collection for Dynatrace.

---

# Metrics collection checkbox is unavailable 

This article helps you resolve the problem in which the **Enable metrics collection** checkbox is unavailable in your Dynatrace integration because the signed-in account doesn't have Owner permissions on the Azure subscription.

## Prerequisites

- Access to the Azure portal and the subscription that contains the resource.

## Symptoms

- The **Enable metrics collection** checkbox is unavailable (dimmed) in the Dynatrace integration UI.
- Attempting to enable metrics collection results in an error or no action.

## Cause

Enabling metrics collection requires Owner permissions at the subscription scope. Users with Contributor or Reader roles can't enable metrics collection from the integration UI. The checkbox is unavailable (dimmed).

## Solution: Request Owner permission

1. In the Azure portal, go to the subscription that contains the resource.
2. Select **Access control (IAM)** in the left pane.
3. Select **View my access** to see your current role at the subscription scope.
4. If you don't have Owner permissions, contact the subscription Owner or administrator and request Owner permissions, or ask them to enable metrics collection for you.
5. After the Owner assigns the role, wait 5–15 minutes for RBAC propagation, and then retry enabling metrics collection in the Dynatrace integration.

## Related content

- [Azure role-based access control (RBAC)](/azure/role-based-access-control/)
- [Assign Azure roles using the Azure CLI](/azure/role-based-access-control/role-assignments-cli)
 