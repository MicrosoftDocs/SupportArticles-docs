---
title: Azure region access request process
description: Describes the process to request access for certain Azure regions.
ms.date: 04/12/2022
ms.service: azure
ms.author: genli
author: genlin
ms.reviewer: 
---
# Azure region access request process  

Certain Azure regions require customers to go through a request process in order to gain access. To request access to these regions, you may [open a support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) and work with our Support team to discuss or enable access.

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 4339658

## Step 1: Create a new support request

The process to request access is relatively straight forward, you can initiate the process directly within the Azure portal, follow these steps:

1. Log into the [Azure Portal](https://portal.azure.com) and navigate to **Help + support**, then select **Create a new support request**.

    :::image type="content" source="media/region-access-request-process/help-support.png" alt-text="Screenshot of New Support Request." border="true":::

2. In the **New support request** page, complete the following:
 
    1. In **Issue Type**, select **Service and subscription Limit (quotas)**.  
    2. In **Subscription**, select the relevant subscription for which you would like to request access.
    3. In **Quota type**, select **Compute-VM (core-vCPUs) subscription limit increases**.  
    4. Select **Next**.
    
    :::image type="content" source="media/region-access-request-process/increase-cpu-quota.png" alt-text="Screenshot of the New Support Request information under Basics tab." border="true":::


## Step 2: Provide problem details

1. In the **Problem details** section, select **Enter details**.
    :::image type="content" source="media/region-access-request-process/enter-details.png" alt-text="Screenshot of the enter details button." border="true":::

1. Select the deployment mode.
1. Select one or more countries/regions that you want to request access.
1. Select the VM series, and then specify new vCPU limit.

    :::image type="content" source="media/region-access-request-process/quota-details.png" alt-text="Screenshot of the quota details page." border="true":::
1. Select **Save and continue**.

## Step 3: Enter your support method

1. Select the severity based on your urgency of request.
1. Fill in the details for the best way to contact you. We will use this information to follow up with you if we need additional details, or need to learn more about your intended use of the Azure Region to which you are requesting access.
1. Select **Create** to complete the process.

## Request processing

Once you have created the support request, the ticket follows our standard process, including a stop with the Azure Engineering team, where we validate the claims made in the request. This may include reaching out to the requestor for further details, so please ensure you add up-to-date contact details.  

The support request will be routed back to you once complete, letting you know of the result. If successful, you will then see the Azure Region you have requested access to in your portal and can begin to consume resources just like any other Azure region.
