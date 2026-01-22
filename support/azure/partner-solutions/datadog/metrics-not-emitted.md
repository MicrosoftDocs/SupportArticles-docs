---
title: Metrics Not Being Emitted
description: Resolve the problem in which Datadog doesn't receive metrics from Azure resources because of a missing or incorrect role assignment.
author: agrimayadav
ms.author: jarrettr
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.date: 09/19/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator or user, I want to resolve an issue in which Datadog isn't emitting metrics.

---

# Metrics not being emitted

## Summary

This article helps you resolve when Datadog isn't receiving metrics from Azure resources because the Datadog resource identity doesn't have the required Monitoring Reader role assignment.

## Prerequisites

- Access to the [Azure portal](https://portal.azure.com) with permissions to view access control (IAM) for the target subscription (Reader) and to assign roles (Contributor/Owner) if you will remediate the problem.
- The Datadog resource identity (managed identity or service principal) name or principal ID.

## Symptoms

- Metrics from Azure resources don't appear in the Datadog UI.
- The Datadog resource doesn't show a **Monitoring Reader** role assignment in the subscription's IAM list.

## Cause

Datadog requires the **Monitoring Reader** role on the appropriate Azure subscription to collect platform metrics. If the Datadog resource identity isn't assigned this role, Datadog can't read metrics and they won't be emitted to Datadog.

## Solution 

1. In the Azure portal, open the subscription that contains the resource.

1. Select **Access control (IAM)**.

1. On the **Role assignments** tab, search for the Datadog resource name.

1. If you don't find a Monitoring Reader assignment for the Datadog identity, complete these steps to add one:

   1. Select **Add** > **Add role assignment**.

   1. On the **Role** tab, select **Monitoring Reader**, and then select **Next**.

   1. In **Assign access to**, select **Managed identity** or **Service principal** as appropriate.

   1. Select the Datadog resource identity and then choose **Select**.

1. Wait a few minutes for role-based access control (RBAC) propagation, and then verify that Datadog is receiving metrics.

> [!warning]
> If you remove the system managed identity or the Monitoring Reader role assignment, Datadog can't collect metrics from your Azure resources.

> [!Note]
> Confirm that the Datadog identity is the one used by the Datadog integration (managed identity versus service principal). If you assign the role to the wrong principal, Datadog won't receive metrics.

## Resources

- [Azure role-based access control (RBAC)](/azure/role-based-access-control/)
- [Assign Azure roles using the Azure CLI](/azure/role-based-access-control/role-assignments-cli)
- [Datadog Azure integration documentation](https://docs.datadoghq.com/integrations/azure/)
