---
title: Troubleshoot non-zone-redundant quota requests for Azure App Service
description: Resolve Azure App Service non-zone-redundant quota request and deployment errors so you can deploy or scale successfully. Follow these troubleshooting steps.
ms.topic: troubleshooting
ms.date: 08/17/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: amyluu, amehrot
ms.service: azure-app-service
ms.custom: sap:Quota
# Customer intent: As an Azure App Service customer, I want to resolve non-zone-redundant quota issues so that I can deploy or scale my App Service plan.
---

# Troubleshoot non-zone-redundant quota requests for Azure App Service

This article helps you resolve common non-zone-redundant (non-ZR), or regional, quota issues for Azure App Service.

App Service quota is scoped by subscription, region, deployment type, and App Service plan SKU. This article applies to non-ZR quota for standard App Service plan SKUs.

> [!IMPORTANT]
> This article doesn't apply to zone-redundant (ZR or AZ) quota or Isolated SKUs. If your deployment error mentions **AZ instances** or **AZ quota**, use the support-request path in the Azure portal for the zone-redundant scenario.

## Prerequisites

Before you begin, collect the following information:

- Subscription ID.
- Azure region.
- App Service plan SKU, such as P1v3, S1, or B1.
- Additional instances required.
- Complete deployment or scale-operation error.

You need the [Quota Request Operator](/azure/role-based-access-control/built-in-roles/management-and-governance#quota-request-operator) role, or another role with equivalent permissions, to view quota and submit quota requests for the subscription.

## Check App Service quota in the Azure portal

Use the [App Service quota self-service experience](https://techcommunity.microsoft.com/blog/appsonazureblog/announcing-the-public-preview-of-the-new-app-service-quota-self-service-experien/4450415) before you open a general support request.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Search for and select **Quotas**.
1. Select **App Service (Public Preview)**.
1. Filter by the affected subscription and region.
1. Locate the exact App Service plan SKU.
1. Review the current usage and limit.
1. Select the quota entry, and then submit a new quota request.

If the automated request can't be fulfilled, the Quotas experience provides an option to open a support request.

> [!NOTE]
> A new limit is the total quota that you want after approval, not only the number of additional instances. Use this formula:
>
> `New limit = Current limit + Additional instances required`

## Symptoms

You might experience one or more of the following symptoms:

- Creating or scaling an App Service plan fails with `SubscriptionIsOverQuotaForSku`.
- The quota limit for a SKU and region is 0.
- A quota request is rejected or delayed because no specific SKU was selected.
- Only part of a multi-SKU or multi-region request is fulfilled.
- The regional total doesn't appear to match an individual SKU limit.
- A quota request can't be fulfilled for a large increase or constrained SKU.

## Cause 1: The current SKU and region limit is too low

The number of instances already in use, plus the instances requested by a deployment or scale operation, exceeds the current limit for the subscription, region, and SKU.

### Solution

1. In **Quotas** > **App Service (Public Preview)**, filter by the affected subscription and region.
1. Locate the exact SKU used by the App Service plan.
1. Compare the current usage and limit.
1. Calculate the required new limit.

   ```console
   New limit = Current limit + Additional instances required
   ```

1. Submit the new total through the quota self-service experience.
1. After the limit is updated, retry the deployment or scale operation.

The request is resolved when the **Quotas** page shows the new limit and the previously blocked operation succeeds.

## Cause 2: The SKU or Total Regional VM limit is 0

A new subscription, region, or previously unused SKU might have a default limit of 0. A deployment can also be blocked when the SKU limit is available but the **Total Regional VM** limit is 0 or already consumed.

App Service applies both the SKU-level limit and the **Total Regional VM** limit. The lower available limit determines whether the deployment can proceed.

### Solution

1. Review the deployment error. A non-ZR quota error commonly includes:
   - `SubscriptionIsOverQuotaForSku`.
   - Location.
   - Current limit.
   - Current usage.
   - Minimum new limit required.
1. In **Quotas** > **App Service (Public Preview)**, verify the limit for the affected SKU and region.
1. Request at least the minimum new limit shown in the deployment error.
1. If the SKU quota is available but **Total Regional VM** is 0, request a small increase for the specific SKU. You can't request the **Total Regional VM** limit directly. It's updated through a SKU-level increase.
1. Wait for the **Quotas** page to show the updated limit, and then retry the deployment.

> [!TIP]
> Request enough quota for the immediate deployment and near-term growth. Very large requests can require extra review or might not be available in a constrained region.

## Cause 3: The subscription offer restricts quota increases

Free, trial, and some restricted subscription offers might have a default limit of 0 or might not support the requested App Service quota increase.

### Solution

1. In the Azure portal, open **Subscriptions**, and then select the affected subscription.
1. Check the subscription offer or plan.
1. If the offer restricts quota increases, upgrade or move the workload to a standard paid subscription.
1. After you update the subscription, return to **Quotas** > **App Service (Public Preview)**, and then check the default limits.
1. If you still need more quota, submit a new request for the exact SKU and region.
1. Retry the App Service plan creation or scale operation.

## Cause 4: The error is caused by regional capacity, not quota

Quota defines how many instances the subscription is allowed to use. It doesn't guarantee that the requested SKU has available physical capacity in a region at a specific time.

The following errors indicate capacity availability rather than a non-ZR quota limit:

- `No available instances to satisfy this request`
- `Not enough available reserved instance servers to satisfy this request`

### Solution

1. Confirm that the error mentions unavailable instances rather than `SubscriptionIsOverQuotaForSku`.
1. Retry the operation later because regional capacity can change.
1. If possible, request fewer instances for the immediate deployment.
1. Consider another App Service plan SKU that meets the workload requirements.
1. Consider an alternate Azure region that meets the workload's latency, resiliency, and compliance requirements.

## Frequently asked questions

### Is the requested new limit a total or an additional amount?

Enter the total quota that you want after the increase, not only the number of additional instances. For example, if your current limit is 10 and you need five more instances, request a new limit of 15.

### How does the Total Regional VMs limit work?

**Total Regional VMs** summarizes your usage and available quota across all individual App Service plan SKUs in a region.

Keep these points in mind:

1. Never request Total Regional VMs quota directly. Request an increase for the individual SKU that you want to deploy. The Total Regional VMs limit increases automatically in response to an eligible individual SKU quota increase.
1. A deployment requires sufficient quota for both the individual SKU and Total Regional VMs. If either limit is reached, request more quota for the individual SKU.
1. In some regions, Total Regional VMs shows `0 of 0` and no individual SKU quotas are listed. In this situation, don't submit a quota request through the Quotas page. Try the deployment first. If it fails with a quota-related error, submit a support request and include the complete error message.

### Why is my individual SKU quota zero?

A quota of zero can be the default for a new subscription, an unused region or SKU, or a restricted subscription offer. Request quota for the exact SKU and region. If the subscription offer doesn't support increases, move or upgrade the workload to an eligible paid subscription.

### Do I need separate requests for each SKU and region?

Yes. Quota is assigned independently for each subscription, SKU, and region combination. Submit and track a separate request for every combination required by your deployment.

### What is the difference between quota and regional capacity?

Quota is the maximum number of instances your subscription is allowed to use. Regional capacity is the physical availability of a SKU in a region at a specific time. A quota increase doesn't guarantee regional capacity.

### Does this guidance apply to zone-redundant or Isolated plans?

No. This article applies to non-ZR quota for App Service plan SKUs. For zone-redundant quota or Isolated SKUs, use the applicable Azure portal support-request path.

### When should I open a support request?

Open a support request when the Quotas experience directs you to do so, when a region shows Total Regional VMs as `0 of 0` with no individual SKUs and your deployment returns a quota error, or when a valid self-service request can't be fulfilled. Include the subscription ID, region, exact SKU, current usage and limit, requested new total, business impact, and complete error message.

## More information

- [App Service quota self-service experience](https://portal.azure.com/?feature.customportal=false#view/Microsoft_Azure_Capacity/QuotaMenuBlade/%7E/overview)
- [Announcing the public preview of the new App Service quota self-service experience](https://techcommunity.microsoft.com/blog/appsonazureblog/announcing-the-public-preview-of-the-new-app-service-quota-self-service-experien/4450415)
- [Frequently asked questions about creating or deleting resources in Azure App Service](/troubleshoot/azure/app-service/create-delete-resources-faq-new)
- [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-app-service-limits)