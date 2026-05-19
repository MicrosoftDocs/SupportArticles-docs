---
title: Troubleshoot issues with an opportunity
description: Provides resolutions for the issues that may occur when working with opportunities in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.date: 05/19/2026
ms.custom: sap:Opportunity
ai-usage: ai-assisted
---
# Troubleshoot issues with opportunities

Follow the instructions in this article to troubleshoot the issues you might face when you work with opportunities.

## Opportunity issues and resolution for salespeople

### How do I close an opportunity?

Whether your customer has accepted or rejected your proposal, it's a good practice to close the opportunity as won or lost.

When you close an opportunity, the opportunity is marked as complete, and can't be changed. To make further changes to an opportunity, you can reopen it.

> [!NOTE]
> At the time of closing the opportunity, enter the Actual Revenue and Actual Close Date. The Actual Revenue is used for reporting purposes in charts and reports in Dynamics 365 Sales.

To close an opportunity, open the opportunity record, and on the command bar, select **Close as Won** or **Close as Lost**.

:::image type="content" source="media//troubleshoot-opportunities-issues/close-opportunity.png" alt-text="Close opportunity as Won or Lost.":::

### Issue 1 - Can't close an opportunity

Here are some errors you might see when you close an opportunity:

1. [Error 1 - The opportunity can't be closed](#error-1---the-opportunity-cant-be-closed)
2. [Error 2 - Access denied or Insufficient permissions](#error-2---access-denied-or-insufficient-permissions)
3. [Error 3 - The opportunity has already been closed](#error-3---the-opportunity-has-already-been-closed)

The following sections describe each of these errors and how you can resolve them.

#### Error 1 - The opportunity can't be closed

##### Cause

There might be active or draft quotes associated with the opportunity.

##### Resolution

1. In the opportunity record, go to the **Quotes** tab (or **Quotes line item** tab).
2. Make sure none of the quotes is in the Draft or Active status.

    :::image type="content" source="media/troubleshoot-opportunities-issues/quotes-in-draft-state.png" alt-text="Quotes in the Draft status.":::

#### Error 2 - Access denied or Insufficient permissions

##### Cause

You don't have sufficient permissions on the opportunity you're trying to close.

##### Resolution

Ask your system administrator to grant you the necessary permissions.

#### Error 3 - The opportunity has already been closed

##### Cause

The opportunity that you're trying to close is already marked as Won or Lost.

##### Resolution

If you want to make changes to the already closed opportunity, reopen the opportunity, make changes, and close it again.

#### Error 4 - The opportunity close dialog doesn't open or shows unexpected behavior

##### Cause

One of the following issues might cause the opportunity close dialog to not open correctly:

- A required metadata flag is turned off.
- There are active customization layers on the opportunity close entity.
- The opportunity close entity isn't added to the required model-driven app.
- The **Custom fields on closing form** setting isn't enabled in Sales Hub settings.

##### Resolution

Try the following steps to resolve this issue:

1. Check if there are any active layers on the opportunity close entity. Remove these layers to validate the scenario.

    > [!NOTE]
    > Removing active layers causes the system to lose all changes made as part of that solution.

1. Add the opportunity close entity to the required model-driven apps.
1. Ensure the opportunity close customization is enabled in Sales Hub settings. Go to **App Settings** > **Lead + opportunity management** > **Opportunity closing** and verify the **Custom fields on closing form** toggle is set correctly.

    :::image type="content" source="media/troubleshoot-opportunities-issues/opportunity-closing-custom-fields-setting.png" alt-text="Screenshot of the Opportunity closing settings page in Sales Hub showing the Custom fields on closing form toggle.":::

1. If you customized the opportunity close form with additional fields, ensure that scripts or fields don't cause errors. Try removing customizations and reattempt the opportunity close to isolate the issue.

#### Error 5 - "More than one parent exists" or "MultipleParentEntitiesFoundByEntity"

##### Cause

Multiple fields in the opportunity close form have cascading relationships with the same entity. This configuration isn't supported.

##### Resolution

Remove one of the fields that has a cascading relationship with the same entity from the opportunity close form. For example, remove a custom field or the **Regarding** field if both reference the same entity. For more information, see [Create and edit 1:N (one-to-many) relationships](/dynamics365/customerengagement/on-premises/customize/create-and-edit-1n-relationships?view=op-9-1&preserve-view=true).

#### Error 6 - Close as Won or Close as Lost button isn't visible

##### Cause

An active layer or managed component might be updating the ribbon definition, which hides the close buttons.

##### Resolution

Check if there's an active layer or managed component that modifies the ribbon definition. Use the [Command Checker](/power-apps/maker/model-driven-apps/use-command-designer) to inspect the visibility rules for the **Close as Won** and **Close as Lost** buttons.

#### Error 7 - Currency mismatch error when closing an opportunity

##### Cause

The actual revenue currency in the **Opportunity Close** entity doesn't match the transaction currency of the opportunity.

##### Resolution

1. Open the opportunity record and check its transaction currency (for example, Japanese Yen).
1. Open the opportunity close form and find the **Actual Revenue** field.
1. Ensure the actual revenue currency matches the transaction currency of the opportunity.

### Issue 2 - Can't edit an opportunity

If you've already closed an opportunity as Won or Lost, it becomes read-only and you can't change it. To make any changes to a closed opportunity, reopen it.

To reopen, open the opportunity, and on the command bar, select **Reopen Opportunity**.

:::image type="content" source="media/troubleshoot-opportunities-issues/reopen-opportunity.png" alt-text="Reopen opportunity to make any changes to a closed opportunity.":::

### Issue 3 - Can't add products to an opportunity

Here are some errors you might see when you add products to an opportunity:

1. [Error 1 - You must select a price list before attempting to add a product](#error-1---you-must-select-a-price-list-before-attempting-to-add-a-product)
2. [Error 2 - You must provide a value for product description](#error-2---you-must-provide-a-value-for-product-description)
3. [Error 3 - You can only add active products](#error-3---you-can-only-add-active-products)

#### Error 1 - You must select a price list before attempting to add a product

##### Cause

You haven't selected a price list for the opportunity. Selecting a price list is required to add products to an opportunity.

##### Resolution

1. In the opportunity record, go to the **Product Line Item** tab.
2. In the **Price List** field, select a price list for the opportunity.

#### Error 2 - You must provide a value for product description

##### Cause

When creating a write-in product, you haven't entered the product name.

##### Resolution

Enter the product name.

#### Error 3 - You can only add active products

##### Cause

When adding an existing product, you selected a product in the **Draft** status.

##### Resolution

Make sure the product you want to add is in the Active state, and then add the product.

## Opportunity close issues and resolution for system administrators

### Issue: Insufficient permissions or Access denied error when a user is trying to close an opportunity

#### Cause

The user trying to close the opportunity doesn't have sufficient permissions on the opportunity they're working on.

#### Resolution

1. Go to **Settings** > **Security Role**.
2. Open the security role of the user.
3. Assign **Read**, **Create**, **Append**, **Append To** permissions to the user's Security Role at User level on the Opportunity entity and custom entity.

## Stakeholder and Sales team subgrids

### Issue: Can't see the connection records added from the Stakeholders subgrid

#### Cause

The out-of-the-box **Stakeholders** subgrid only shows connections that have a connection role category of **Stakeholder**. For more information, see [How are stakeholders and sales team members tracked for opportunities?](/dynamics365/sales/stakeholders-sales-team-members).

#### Resolution

1. In the opportunity record, select the **Related** tab, and then select **Connections**.
1. In the **Connections** subgrid, select the connection record you added.
1. Open the connection role selected in the **As this role** field.
1. Make sure that **Connection Role Category** is set to **Stakeholder**. If it isn't, select **Stakeholder** in the **Connection Role Category** drop-down list.

## Opportunity pipeline view issues

### Issue 1: Pipeline view doesn't display bubbles in the Deal tracker

#### Cause

There are several reasons why the bubbles might not be visible:

- The [bubble chart](/dynamics365/sales/use-opportunity-pipeline-view#understand-the-opportunity-pipeline-charts) shows only the first 50 valid opportunity entries, meaning those with the defined x-axis, y-axis, radius data, and **Segment by** fields. This might result in some or all of the bubbles not showing up on the graph despite being present in the grid view.
- If the [msdyn_Score](/dynamics365/sales/developer/entities/msdyn_predictivescore#BKMK_msdyn_Score) (opportunity score) and [msdyn_Grade](/dynamics365/sales/developer/entities/msdyn_predictivescore#BKMK_msdyn_Grade) (opportunity grade) fields are selected as the **Tooltips** fields for the Deal tracker, the "not null" filters of these fields will be applied to the opportunities for the bubble chart, potentially filtering out all opportunities from the chart despite being visible in the grid view.

#### Resolution

To solve this issue, take the following steps:

1. Ensure that the fields selected for the **Deal tracker** setting in **App Settings** on the [opportunity pipeline settings page](/dynamics365/sales/opportunity-pipeline-view-for-admins#open-the-opportunity-pipeline-view-settings-page) have values for the x-axis, y-axis, radius data, and **Segment by** fields.

1. Avoid using the [msdyn_Score](/dynamics365/sales/developer/entities/msdyn_predictivescore#BKMK_msdyn_Score) (opportunity score) and [msdyn_Grade](/dynamics365/sales/developer/entities/msdyn_predictivescore#BKMK_msdyn_Grade) (opportunity grade) fields as the **Tooltips**, x-axis, y-axis, radius, and **Segment by** fields to ensure the bubbles appear in the Deal tracker. Alternatively, [enable predictive opportunity scoring](/dynamics365/sales/digital-selling-scoring#set-up-lead-and-opportunity-scoring) in the organization to populate data for the `msdyn_Score` and `msdyn_Grade` fields.

### Issue 2: Pipeline view doesn't show all the bubbles in the Deal tracker

The bubble chart is designed to display a maximum of 50 opportunities to maintain clarity of the bubble chart.

### Issue 3: Deal manager access privileges are automatically assigned to newly created roles

When an administrator publishes deal manager settings from **App Settings** on the [opportunity pipeline settings page](/dynamics365/sales/opportunity-pipeline-view-for-admins#open-the-opportunity-pipeline-view-settings-page), the `prvReadmsdyn_dealmanageraccess` and `prvReadmsdyn_dealmanagersettings` privileges are automatically granted to all newly created roles in the environment.

This behavior is by design. It allows users to read the deal manager settings configuration to display the bubble chart in the pipeline view.

For more information, see [Manage opportunities](/dynamics365/sales/opportunity-management-overview).
