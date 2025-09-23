---
title: DeploymentFailed error when creating Confluent Cloud resource
description: "Resolve the DeploymentFailed error when creating a Confluent Cloud resource in Azure."
author: v-albemi
ms.author: v-albemi
ms.service: Confluent integration
ms.topic: troubleshooting-problem-resolution
ms.date: 09/23/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# DeploymentFailed error when creating Confluent Cloud resource

This article helps you resolve the DeploymentFailed error that appears when you try to create a Confluent Cloud resource in Azure and there is a subscription or billing issue.

## Prerequisites

- Access to the Azure portal and the subscription where you are deploying the resource.
- Permissions to view subscription status and billing information.

## Symptoms

- You see a **DeploymentFailed** error message when attempting to create a Confluent Cloud resource.
- The resource creation fails and the resource status is not created or is marked as failed.

## Cause

- The Azure subscription is suspended or has unresolved billing issues, which prevents resource deployment.

## Solution 1: Check subscription status and resolve billing issues

1. In the Azure portal, open the subscription where you are deploying the resource.
2. Check the subscription status. If it is **Suspended**, resolve any outstanding billing issues.
3. Go to **Cost Management + Billing** and review payment methods, invoices, and alerts.
4. Update payment information or resolve any billing alerts as needed.
5. After resolving issues, retry the resource deployment.

## Solution 2: Verify subscription status using CLI or PowerShell

- Azure CLI example:

  az account show --subscription {subscription-id}

- PowerShell example:

  Get-AzSubscription -SubscriptionId {subscription-id}

If the subscription is not **Enabled**, follow Azure billing guidance to resolve issues.

## Verify

- After resolving subscription or billing issues, retry the deployment and confirm the Confluent Cloud resource is created successfully.
- The resource status should be **Succeeded** in the Azure portal.

## Related content

- [Azure subscription and billing troubleshooting](https://learn.microsoft.com/azure/cost-management-billing/manage/troubleshoot-azure-subscription)
- [Azure Marketplace documentation](https://learn.microsoft.com/azure/marketplace/marketplace-overview)
- [Confluent support](https://support.confluent.io)