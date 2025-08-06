---
title: Zonal enablement request for restricted vm series
description: Guidance to request access to restricted vm series in selected zones.
ms.date: 08/06/2025
ms.service: azure-common-issues-support
ms.author: zmazieva
author: ZarinaMazieva
ms.reviewer: 
---
# Zonal enablement request for restricted VM series  

Zonal enablement requests allow customers to select preferred zones in a region when requesting access to restricted VM series. 

_Original product version:_ &nbsp;  
_Original KB number:_ &nbsp; 

## Step 1: Create a support request

This guide explains how to request restricted VM series in a zone using Help + Support path in Azure Portal.

1. Log into the [Azure Portal](https://portal.azure.com) and navigate to **Help + support**, then select **Create a support request**.
1. Type in **quotas** in the **Describe your issue** search bar.
1. Select **Service and Subscription Limits (quotas)** click **Create a support request**
1. In the **New support request** page, complete the following:
    1. In **Issue Type**, select **Service and Subscription Limits (quotas)**.
    1. In **Subscription**, select the relevant subscription for which you would like to request access.
    1. In **Quota type**, select **Compute-VM (cores-vCPUs) subscription limit increases** proceed next.
 
## Step 2: Provide problem details

1. In the **Problem details** section, select **Enter details**.
1. Select **Resource Manager** in the **Deployment model**.
1. Select **Zone access** in the **Choose request types**.
1. In the **Request details** section select preferred regions in **Locations**
1. In the displayed region boxes, select the appropriate zone from the **Select requested logical zone** dropdown list.
1. Then select the VM series you would like to request.
1. Select **Save and continue**.
> [!Note]
> Multiple regions and zones can be selected in one support request.

## Step 3: Review and Submit
1. Review and fill in the details for the best way to contact you.
1. Select **Create** to submit the request.

## Request processing

Once you create the support request, the ticket follows our standard process. The confirmation, including your support ticket number, will be sent to your registered email address. If the support team has additional questions, they will contact you using the communication method you specified in your request.

## Tracking request status

Status of the Quota request can be monitored through **Help + Support/Overview** or **Help + Support/All support requests** in Azure Portal.
