---
title: DeploymentFailed Error When Creating a Confluent Cloud Resource
description: Resolve the DeploymentFailed error that can occur when you create a Confluent Cloud resource in Azure.
author:  
ms.author: jarrettr 
ms.service: partner-services 
ms.topic: troubleshooting-problem-resolution
ms.date: 09/23/2025
ai-usage: ai-assisted
# customer intent: As an Azure administrator or user, I want to resolve the DeploymentFailed error that I'm getting.

---

# DeploymentFailed error 

This article helps you resolve the **DeploymentFailed** error that appears when you try to create a Confluent Cloud resource in Azure and there's a subscription or billing issue.

## Prerequisites

- Access to the Azure portal and the subscription in which you're deploying the resource.
- Permissions to view subscription status and billing information.

## Symptoms

You see a **DeploymentFailed** error message when you try to create a Confluent Cloud resource.

## Cause

The Azure subscription is suspended or has unresolved billing problems.

## Solution: Check subscription status and resolve billing problems

1. In the Azure portal, go to the subscription in which you're trying to deploy the resource.
1. Check the subscription status. If it's **Suspended**, resolve any outstanding billing problems.
1. Go to **Cost Management** and **Billing** and review payment methods, invoices, and alerts.
1. Update payment information or resolve any billing alerts as needed.
1. After resolving problems, try again to deploy the resource.

## Related content

- [Azure subscription and billing troubleshooting](/azure/cost-management-billing/troubleshoot-billing/billing-troubleshoot-azure-payment-issues)
 