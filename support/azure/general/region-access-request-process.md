---
title: Azure region access request process
description: Describes the process to request access for certain Azure regions.
ms.date: 08/14/2020
ms.prod-support-area-path: 
ms.service: azure
ms.author: genli
author: genlin
ms.reviewer: 
---
# Azure region access request process  

Certain Azure regions require customers to go through a request process in order to gain access.  To request access to these regions, a customer or their Cloud Solution Provider may [open a support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) and work with our Support team to discuss or enable access.

_Original product version:_ &nbsp; Azure  
_Original KB number:_ &nbsp; 4339658

## Step 1: Create a new support request

The process to request access is relatively straight forward, you can initiate the process directly within the Azure portal, just follow the steps below:

1. Log into the Azure Management Portal and navigate to the **Help + support** icon on the left-hand side of the screen, then select **+ New support request**.

    :::image type="content" source="./media/region-access-request-process/4511987_en_1.png" alt-text="New Support Request":::

2. You'll be presented with step 1 of the new support request, complete the following:

    :::image type="content" source="./media/region-access-request-process/4528754_en_2.jpg" alt-text="New Support Request (Basics).":::

    1. In **Issue Type**, select " **Service and subscription Limit (quotas)** ".  
    2. In **Subscription**, select the relevant subscription for which you would like to request access.
    3. In **Quota type**, select **Other Request**.  
    4. Click **Next**.

## Step 2: Provide problem details

1. Set the "Severity" - select the severity based on your urgency of request.|
2. In the description section, state "Request access for the Azure \<insert the region name> Regions for \<insert your organization name>". |
3. Add your initial deployment model and your compute, storage, and SQL resource quota needs.

    If you're unsure about what you'll need, we recommend that you add the following basic quota to the description section of the request, and include all the VM Types you are likely to need over time. This won't lock you into a specific quota. The quota can be adjusted as necessary over time.

    In your submission form, please list all Virtual Machine SKUs, which you would like to request access for, along with your requested quota, thereby avoiding the need to fill out multiple support requests.

    Likewise, if you want to request access for Storage, SQL, SQL-Managed Instance, HDI, and/or Batch, we recommend including these in your submission as well, along with your requested quota for these, thereby avoiding the need to fill out multiple support requests. For example: Once your Compute request has been approved, when logging in to your account, you will see that you have been granted access to associated products as well (like App Services, Functions, etc.).

    If you have multiple Subscription IDs, which you would like to request for, we recommend including any additional Subscription IDs in the description section, thereby avoiding the need to fill out multiple support requests.

    If you prefer to submit multiple requests, Microsoft Support will combine these on your behalf, for more streamlined communications.
4. Complete the following information:  

    :::image type="content" source="./media/region-access-request-process/4528808_en_2.png" alt-text="provide problem details.":::

    | Field| Value |
    |---|---|
    |Region to Enable| \<insert the region you are requesting access to> |
    | Deployment Model| ARM |
    | Planned VM type| for example, Dv3 Series |
    | Planned Compute usage in Cores|25|
    | Planned Storage usage in TB| 10 |
    | Planned SQL Database SKU| for example, S0 |
    | Planned No. of Databases per DB SKU (20 DB limit per SKU)| |
    |||  

    You can also include the following additional resource needs in your support request, or submit via a separate support request at another time:

    **Azure VM Reserved Instances**  

    List the specific VM Types for which you plan to apply Reserved Instances, and your estimated usage in Cores. 

    | Field| Value |
    |---|---|
    | Issue Type| Reserved Instance Region enablement |
    | Subscription ID that needs to be enabled| |
    | Region: Name of the region| <insert the Azure region you are requesting access to> |
    | VM Series: (Example Dv2)| |
    | Planned usage in Cores| |
    |||

    > [!NOTE]
    > Once access is confirmed for Reserved Instances, you can make the Reserved Instance purchase.

     **SQL Data warehouse**  

    In the details section of the request, add the **SQL Data warehouse** requirements with the following: 

    | Field| Value |
    |---|---|
    | Subscription GUID| Only needed if submitting as a standalone request |
    | Region| \<insert the Azure region you are requesting access to> |
    ||

5. Click **Next**.

## Step 3: Enter your contact details

1. Fill in the details for the best way to contact you. We will use this information to follow up with you if we need additional details, or need to learn more about your intended use of the Azure Region to which you are requesting access. 

    :::image type="content" source="./media/region-access-request-process/4528809_en_1.png" alt-text="provide Contact Info.":::

2. Click " **Create** " to complete the process. 

    :::image type="content" source="./media/region-access-request-process/4528810_en_1.jpg" alt-text="example request.":::

## Request processing

Once you have created the support request, the ticket follows our standard process, including a stop with the Azure Engineering team, where we validate the claims made in the request. This may include reaching out to the requestor for further details, so please ensure you add up-to-date contact details.  

The support request will be routed back to you once complete, letting you know of the result. If successful, you will then see the Azure Region you have requested access to in your portal and can begin to consume resources just like any other Azure region.
