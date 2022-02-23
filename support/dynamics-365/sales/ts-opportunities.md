---
title: Troubleshoot issues related to an opportunity
description: Learn how to troubleshoot issues you might face while working with opportunities in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 02/23/2022
---

# Troubleshoot issues with opportunities  

Follow the instructions in this article to troubleshoot the issues you might face while working with opportunities in Dynamics 365 Sales.

<a name="opportunity_close"> </a>

## Opportunity issues and resolution for salespeople

### How do I close an opportunity?
      
Whether your customer has accepted or rejected your proposal, it's a good practice to close the opportunity as won or lost. 

When you close an opportunity, the opportunity is marked as complete, and can't be changed. To make further changes to an opportunity, you can reopen it. 


> [!NOTE]
> At the time of closing the opportunity, enter the Actual Revenue and Actual Close Date. The Actual Revenue is used for reporting purposes in charts and reports in Dynamics 365 Sales.

To close an opportunity, open the opportunity record, and on the command bar, select **Close as Won** or **Close as Lost**.

> [!div class="mx-imgBorder"]  
> ![Close opportunity as Won or Lost.](media/sales/close-opportunity.png "Close opportunity as Won or Lost")

<a name="close_opportunity"> </a>
### Issue: I can't close an opportunity

Here are some errors you might see when you close an opportunity: 
1.  [The opportunity can't be closed](#CannotBeClosed)
2.  [Access denied or Insufficient permissions](#AccessDeniedOpportunity)
3.  [The opportunity has already been closed](#AlreadyClosed)

The following sections describe each of these errors and how you can resolve them.

<a name="CannotBeClosed"> </a> 
#### 1. The opportunity can't be closed

##### Cause

There might be active or draft quotes associated with the opportunity.

##### Solution

1. In the opportunity record, go to the **Quotes** tab (or **Quotes line item** tab).
2. Make sure none of the quotes is in the Draft or Active status.

    > [!div class="mx-imgBorder"]  
    > ![Quotes in the Draft status.](media/sales/quotes-in-draft-state.png "Quotes in the Draft status")


<a name="AccessDeniedOpportunity"> </a> 
#### 2. Access denied or Insufficient permissions.

##### Cause

You don't have sufficient permissions on the opportunity you're trying to close.

##### Solution

Ask your system administrator to grant you the necessary permissions.

<a name="AlreadyClosed"> </a>
#### 3. The opportunity has already been closed.

##### Cause

The opportunity that you're trying to close is already marked as Won or Lost. 

##### Solution

If you want to make changes to the already closed opportunity, reopen the opportunity, make changes, and close it again.

<a name="edit_opportunity"> </a>
### Issue: I can't edit an opportunity

If you've already closed an opportunity as Won or Lost, it becomes read-only and you can't change it. To make any changes to a closed opportunity, reopen it. 

To reopen, open the opportunity, and on the command bar, select **Reopen Opportunity**.

> [!div class="mx-imgBorder"]
> ![Reopen opportunity.](media/sales/reopen-opportunity.png "Reopen opportunity")


<a name="add_products"> </a>
### Issue: I can't add products to an opportunity 

Here are some errors you might see when you add products to an opportunity: 
1.  [You must select a price list before attempting to add a product](#SelectPriceList)
2.  [You must provide a value for product description](#ProductName)
3.  [You can only add active products](#ActiveProducts)

<a name="SelectPriceList"></a>
#### 1. You must select a price list before attempting to add a product

##### Cause

You haven't selected a price list for the opportunity. Selecting a price list is required to add products to an opportunity. 

##### Solution

1. In the opportunity record, go to the **Product Line Item** tab.
2. In the **Price List** field, select a price list for the opportunity.  

<a name="ProductName"></a>
#### 2. You must provide a value for product description.

##### Cause

When creating a write-in product, you haven't entered the product name.  

##### Solution

Enter the product name.   

<a name="ActiveProducts"></a>
#### 3. You can only add active products.

##### Cause

When adding an existing product, you selected a product in the **Draft** status.  

##### Solution

Make sure the product you want to add is in the Active state, and then add the product.   

## Opportunity close issues and resolution for system administrators

<a name="access_denied"></a>
### Issue: Insufficient permissions or Access denied error when a user is trying to close an opportunity

#### Cause

The user trying to close the opportunity doesn't have sufficient permissions on the opportunity they're working on.

#### Solution

1. Go to **Settings** > **Security Role**.
2. Open the security role of the user.
3. Assign **Read**, **Create**, **Append**, **Append To** permissions to the user's Security Role at User level on the Opportunity entity and custom entity.

## Stakeholder and Sales team subgrids

<a name="cant-see-connection-records-from-stakeholders-subgrid"> </a>
### Issue: I can't see the connection records added from the Stakeholders subgrid

#### Cause

The out-of-the-box **Stakeholders** subgrid only shows connections that have a connection role category of **Stakeholder**. More information: [How are stakeholders and sales team members tracked for opportunities?](/dynamics365/sales/stakeholders-sales-team-members)

#### Solution

1. In the opportunity record, select the **Related** tab, and then select **Connections**. 

2. In the **Connections** subgrid, select the connection record you added.

3. Open the connection role selected in the **As this role** field. 

4. Make sure that **Connection Role Category** is set to **Stakeholder**. If it isn't, select **Stakeholder** in the **Connection Role Category** drop-down list. 
