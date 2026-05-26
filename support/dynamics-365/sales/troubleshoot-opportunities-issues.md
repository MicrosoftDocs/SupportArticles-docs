---
title: Fix opportunity errors in Dynamics 365 Sales
description: Resolve common opportunity errors in Dynamics 365 Sales, such as close opportunity failures, missing permissions, currency mismatches, product errors, and pipeline view issues.
ms.date: 05/21/2026
ms.reviewer: shjais, ramakris, josaw, v-shaywood
ms.custom: sap:Opportunity
ai-usage: ai-assisted
---
# Troubleshoot issues with opportunities

## Summary

Use this article to troubleshoot issues that you might encounter when you work with opportunities in Microsoft Dynamics 365 Sales. It covers errors and unexpected behavior when you close opportunities, edit closed opportunities, add products, view the opportunity pipeline, and manage permissions and stakeholders. For more information about how to work with opportunities, see [Manage opportunities](/dynamics365/sales/opportunity-management-overview).

## Can't close an opportunity

The following errors or issues might occur when you try to close an opportunity:

- [The opportunity can't be closed](#the-opportunity-cant-be-closed)
- [Access denied or insufficient permissions](#access-denied-or-insufficient-permissions)
- [The opportunity is already closed](#the-opportunity-is-already-closed)
- [The opportunity close dialog doesn't open or shows unexpected behavior](#the-opportunity-close-dialog-doesnt-open-or-shows-unexpected-behavior)
- [Multiple cascading relationships on the close form](#multiple-cascading-relationships-on-the-close-form)
- [Close as Won or Close as Lost button isn't visible](#close-as-won-or-close-as-lost-button-isnt-visible)
- [Currency mismatch error ](#currency-mismatch-error)

The following sections describe each error and how to resolve it.

### The opportunity can't be closed

This error can occur when active or draft [quotes](/dynamics365/sales/create-edit-quote-sales) are associated with the opportunity.

#### Solution

To resolve this issue:

1. In the opportunity record, go to the **Quotes** tab (or **Quotes line item** tab).
1. Make sure none of the quotes are in the Draft or Active status.

    :::image type="content" source="media/troubleshoot-opportunities-issues/quotes-in-draft-state.png" alt-text="Quotes in the Draft status.":::

### Access denied or insufficient permissions

You don't have sufficient permissions on the opportunity that you're trying to close.

#### Solution

Ask your system administrator to grant you the required permissions. The administrator can follow these steps to grant the necessary permissions:

1. Go to **Settings** > **Security Role**.
1. Open the [security role](/power-platform/admin/security-roles-privileges) of the user.
1. Assign **Read**, **Create**, **Append**, and **Append To** permissions to the user's security role at User level on the Opportunity entity and the custom entity.

### The opportunity is already closed

The opportunity that you're trying to close is already marked as Won or Lost.

#### Solution

To change a closed opportunity, reopen it, make your changes, and then close it again.

### The opportunity close dialog doesn't open or shows unexpected behavior

One of the following issues might cause the opportunity close dialog to not open correctly:

- A required metadata flag is turned off.
- Active customization [solution layers](/power-platform/alm/solution-layers-alm) exist on the opportunity close entity.
- The opportunity close entity isn't added to the required [model-driven app](/power-apps/maker/model-driven-apps/model-driven-app-overview).
- The **Custom fields on closing form** setting isn't turned on in Sales Hub settings.

#### Solution

To resolve this issue:

1. Check whether any active layers exist on the opportunity close entity. To validate the scenario, remove these layers.

    > [!NOTE]
    > Removing active layers causes the system to lose all changes that are made as part of that solution.

1. Add the opportunity close entity to the required model-driven apps.
1. Make sure that the opportunity close customization is turned on in Sales Hub settings:

    1. Go to **App Settings** > **Lead + opportunity management** > **Opportunity closing**.
    1. Make sure the **Custom fields on closing form** toggle is turned on.

    :::image type="content" source="media/troubleshoot-opportunities-issues/opportunity-closing-custom-fields-setting.png" alt-text="Screenshot of the Opportunity closing settings page in Sales Hub showing the Custom fields on closing form toggle.":::

1. If you customized the opportunity close form by adding extra fields, make sure that scripts or fields don't cause errors. To isolate the issue, try to remove customizations, and then close the opportunity again.

### Multiple cascading relationships on the close form

When you try to close an opportunity, you receive the following error message:

> More than one parent exists

> MultipleParentEntitiesFoundByEntity

This error occurs because multiple fields in the opportunity close form have cascading relationships with the same entity. This configuration isn't supported.

#### Solution

To resolve this issue, remove one of the fields that has a cascading relationship with the same entity from the opportunity close form. For example, if a custom field and the **Regarding** field both reference the same entity, remove one of them. For more information, see [Create and edit 1:N (one-to-many) relationships](/dynamics365/customerengagement/on-premises/customize/create-and-edit-1n-relationships).

### Close as Won or Close as Lost button isn't visible

An active layer or managed component might be updating the ribbon definition. This update activity hides the close buttons.

#### Solution

To resolve this issue, check whether an active layer or managed component modifies the ribbon definition. Use the [Command Checker](/power-apps/maker/model-driven-apps/use-command-designer) to inspect the visibility rules for the **Close as Won** and **Close as Lost** buttons.

### Currency mismatch error

The actual revenue currency in the **Opportunity Close** entity doesn't match the transaction currency of the opportunity.

#### Solution

To resolve this issue:

1. Open the opportunity record, and check its transaction currency (for example, Japanese Yen).
1. Open the opportunity close form, and find the **Actual Revenue** field.
1. Make sure that the actual revenue currency matches the transaction currency of the opportunity.

## Can't edit an opportunity

After you close an opportunity as Won or Lost, the opportunity becomes read-only, and you can't change it. 

#### Solution

You have to reopen a closed opportunity to be able to change it. Select the opportunity, and then select **Reopen Opportunity** on the command bar.

:::image type="content" source="media/troubleshoot-opportunities-issues/reopen-opportunity.png" alt-text="Reopen opportunity to make any changes to a closed opportunity.":::

## Can't add products to an opportunity

When you try to add products to an opportunity, the following errors might occur:

- [You must select a price list before attempting to add a product](#you-must-select-a-price-list-before-attempting-to-add-a-product)
- [You must provide a value for product description](#you-must-provide-a-value-for-product-description)
- [You can only add active products](#you-can-only-add-active-products)

### You must select a price list before attempting to add a product

This error occurs because you didn't select a [price list](/dynamics365/sales/create-price-lists-price-list-items-define-pricing-products) for the opportunity. You need a price list to add products to an opportunity.

To resolve this issue:

1. In the opportunity record, go to the **Product Line Item** tab.
1. In the **Price List** field, select a price list for the opportunity.

### You must provide a value for product description

This error occurs because you didn't enter the product name for the write-in product. 

To resolve this issue, enter the product name.

### You can only add active products

This error occurs because the product that you selected is in the **Draft** status.

To resolve this issue, make sure that the product is in the Active state, and then add it.

## Can't see connection records added from the Stakeholders subgrid

The out-of-the-box **Stakeholders** subgrid shows only connections that have a connection role category of **Stakeholder**. For more information, see [How are stakeholders and sales team members tracked for opportunities?](/dynamics365/sales/stakeholders-sales-team-members).

To resolve this issue:

1. In the opportunity record, select the **Related** tab, and then select **Connections**.
1. In the **Connections** subgrid, select the connection record that you added.
1. On the connection record, open the connection role that's listed in the **As this role** field.
1. On the connection role record, make sure that the **Connection Role Category** field is set to **Stakeholder**.

## Opportunity pipeline view issues

### Pipeline view doesn't display bubbles in the Deal tracker

The bubbles might not be visible for the following reasons:

- To maintain clarity, the [bubble chart](/dynamics365/sales/use-opportunity-pipeline-view#understand-the-opportunity-pipeline-charts) shows only the first 50 valid opportunity entries (those entries that have defined x-axis, y-axis, radius data, and **Segment by** fields). As a result, some or all bubbles might not appear on the graph even though they exist in the grid view.
- If the [msdyn_Score](/dynamics365/sales/developer/entities/msdyn_predictivescore#BKMK_msdyn_Score) (opportunity score) and [msdyn_Grade](/dynamics365/sales/developer/entities/msdyn_predictivescore#BKMK_msdyn_Grade) (opportunity grade) fields are selected as the **Tooltips** fields for the Deal tracker, the "not null" filters of these fields are applied to the opportunities for the bubble chart. This action might filter out all opportunities from the chart even though they're visible in the grid view.

#### Solution

To resolve this issue:

1. Make sure that the fields that are selected for the **Deal tracker** setting in **App Settings** on the [opportunity pipeline settings page](/dynamics365/sales/opportunity-pipeline-view-for-admins#open-the-opportunity-pipeline-view-settings-page) have values for the x-axis, y-axis, radius data, and **Segment by** fields.
1. Avoid using the [msdyn_Score](/dynamics365/sales/developer/entities/msdyn_predictivescore#BKMK_msdyn_Score) (opportunity score) and [msdyn_Grade](/dynamics365/sales/developer/entities/msdyn_predictivescore#BKMK_msdyn_Grade) (opportunity grade) fields as the **Tooltips**, x-axis, y-axis, radius, or **Segment by** fields so that the bubbles appear in the Deal tracker. Alternatively, [turn on predictive opportunity scoring](/dynamics365/sales/digital-selling-scoring#set-up-lead-and-opportunity-scoring) in the organization to populate data for the `msdyn_Score` and `msdyn_Grade` fields.

### Deal manager access privileges are automatically assigned to newly created roles

When an administrator publishes deal manager settings from **App Settings** on the [opportunity pipeline settings page](/dynamics365/sales/opportunity-pipeline-view-for-admins#open-the-opportunity-pipeline-view-settings-page), the `prvReadmsdyn_dealmanageraccess` and `prvReadmsdyn_dealmanagersettings` privileges are automatically granted to all newly created roles in the environment.

This behavior is by design. It lets users read the deal manager settings configuration to show the bubble chart in the pipeline view.

For more information, see [Manage opportunities](/dynamics365/sales/opportunity-management-overview).

## Related content

- [Add products to an opportunity](/dynamics365/sales/add-products-opportunity)
- [Troubleshoot issues with currency and price lists](troubleshoot-currency-and-price-lists-issues.md)
- [Troubleshoot issues with a product](troubleshoot-products-issues.md)
- [Troubleshoot issues with Sales Pipeline chart and its phases](troubleshoot-sales-pipeline-issues.md)
