---
title: Troubleshoot issues with table views
description: Provides resolutions for the known issues that are related to table views in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Opportunity
---

# Troubleshoot issues with table views

This article helps you troubleshoot and resolve issues related to table views.

## Issue 1 - Can't see data in certain columns in table views

### Cause

This issue is occurring due to mismatch of column names between the `layoutxml` and `fetchxml` in the view ODATA file (*OrgUrl*/api/data/*Dynamics 365 version*/savedqueries(*ViewId*)).

### Resolution

To resolve this issue, you must remove and add back the column that is causing this issue. This will ensure that the column names in `layoutxml` and `fetchxml` are matched.

> [!NOTE]
> Before you start resolving the issue, take note of the view for which this issue is occurring.

1. Go to **Settings** > **Customizations** > **Customize the System**.
2. Select the **Entity** > **Views** and select the view that has this issue. In this example, we're selecting the table **Account** and view as **Accounts Being Followed**.

    :::image type="content" source="media/troubleshoot-table-views-issues/column-entity-view-selection.png" alt-text="Choose a view from the table." lightbox="media/troubleshoot-table-views-issues/column-entity-view-selection.png":::

3. Select **More Actions** > **Edit**.

    The view edit page opens.

    :::image type="content" source="media/troubleshoot-table-views-issues/column-edit-view.png" alt-text="Open the view edit page to edit a view." border="false":::

4. Select the column that is causing the issue and select **Remove**. In this example, we select the column **Email (Primary Contact)** to remove.

    :::image type="content" source="media/troubleshoot-table-views-issues/remove-column-from-view.png" alt-text="Remove a column from view." border="false":::

    The column is removed from the view.

5. Add back the column that you've deleted. Select **Add Columns** and readd the column that you removed. In this example, we're adding  the column **Email (Primary Contact)** that was removed.

    :::image type="content" source="media/troubleshoot-table-views-issues/add-back-column-from-view.png" alt-text="Adding back the removed column." border="false":::

    The data in the columns is displayed properly.

## Issue 2 - Can't see some records in the table views

### Cause

This issue is occurring due to the filtering of data on a view.

### Resolution

To resolve this issue, you must edit or remove filters for the view. This will ensure that filters are applied properly for the view.

> [!NOTE]
> Before you start resolving the issue, take note of the view for which this issue is occurring.

1. Go to **Settings** > **Customizations** > **Customize the System**.
2. Select the **Entity** > **Views** and select the view that has this issue. In this example, we're selecting the table **Account** and view as **Accounts I Follow**.

    :::image type="content" source="media/troubleshoot-table-views-issues/record-entity-view-selection.png" alt-text="Choose the view from the table." lightbox="media/troubleshoot-table-views-issues/record-entity-view-selection.png":::

3. Select **More Actions** > **Edit**.

    The view edit page opens.

    :::image type="content" source="media/troubleshoot-table-views-issues/record-edit-view.png" alt-text="Open the view edit page to edit or remove the filters." border="false":::

4. Select **Edit Filter Criteria** and recheck the filter condition either by updating or deleting.

    :::image type="content" source="media/troubleshoot-table-views-issues/record-update-filter.png" alt-text="Update or clear the filter criteria." border="false":::

    The records in the views are displayed properly.

## Issue 3 - Can't see some records in opportunity, quote, order, or invoice subgrids

While working on opportunity, quote, order, or invoice records, you might observe that some records are missing.

### Cause

You might not see some records because of an error that occurred due to customization done to the subgrid.

### Resolution

To fix the issue of incorrect customization, follow these steps to make sure your subgrid is configured correctly:

1. In your app, on the nav bar, select the **Settings** icon, and then select **Advanced Settings**.

    :::image type="content" source="media/troubleshoot-table-views-issues/advanced-settings-option.png" alt-text="Advanced Settings link in the Settings menu." border="false":::

    The **Business Management** settings page opens in a new browser tab.

2. On the navigation bar, select **Settings**, and then under **Customization**, select **Customizations**.
3. Select **Customize the System**.
4. Under **Components** in the solution explorer, expand **Entities**, expand **Opportunity**, and then select **Forms**.
5. Open the Opportunity form of type **Main**.
6. Double-click to select the **Connections** section in the **Product Line Items** section.

    :::image type="content" source="media/troubleshoot-table-views-issues/product-line-items-subgrid.png" alt-text="Product Line Items subgrid.":::

    The **Set Properties** dialog box opens.

    :::image type="content" source="media/troubleshoot-table-views-issues/set-properties-opportunity-products-grid.png" alt-text="Set properties of Opportunity Products grid.":::

7. On the **Controls** tab, double-click to select **Editable Grid**.

    :::image type="content" source="media/troubleshoot-table-views-issues/editable-grid-option.png" alt-text="Double-click the Editable Grid option.":::

8. Make sure that all values are set correctly:

    - Grid View: Opportunity Product Inline Edit View

    - Nested Grid View: Select the pencil icon and fill in the following details:

      :::image type="content" source="media/troubleshoot-table-views-issues/configure-property-dialog-box.png" alt-text="Details in the Configure Property dialog box.":::

        - Table: Opportunity Products
        - View: Opportunity Product Inline Edit View: Bundle Products

    - Nested grid parent ID: parentbundleidref
    - Group by Column: Enabled (Enum)
    - Allow filtering: Enabled (Enum)
    - Hide nested grid column header: Hide Column

        > [!NOTE]
        > If you're using product bundles and edit these bundled line items in the product grid, select **Hide nested grid column header** as **Show Column**.

## Issue 4 - Can't set a custom view as the default view for the Existing products field in Add products dialog

To add products to an opportunity, quote, order, or invoice, you select the products from the **Existing product** lookup field in the **Add products** dialog. If you change the default view of the lookup field to a custom view, the field doesn't display products from the custom view.

### Cause

To be able to display products from the selected price list, the lookup always defaults to a system view named **Products in Parent Price List**. So, even if you change the default, the lookup field will set the default back to the **Products in Parent Price List** view.

### Resolution

This behavior is working as designed. Though you can't set a default view, you can manually switch to the view in the **Existing products** lookup field.

:::image type="content" source="media/troubleshoot-table-views-issues/change-view-option.png" alt-text="The Change view option in add products dialog box.":::

## Issue 5 - Can't update nested bundle items on the Product tab

### Cause

For an opportunity, when you update nested bundle items on the **Product** tab, the save icon is disabled. This issue occurs because the header of the nested grid column is hidden under **Opportunity Product Inline Edit View** in customizations.

### Resolution

To resolve this issue, follow these steps to show the header of the nested grid columns for products on the opportunity form.

1. In your app, on the nav bar, select the **Settings** icon, and then select **Advanced Settings**.

    :::image type="content" source="media/troubleshoot-table-views-issues/advanced-settings-option.png" alt-text="Advanced Settings on the Settings menu." border="false":::

    The **Business Management** settings page opens in a new browser tab.

2. On the navigation bar, select **Settings**, and then under **Customization**, select **Customizations**.
3. Select **Customize the System**.
4. Under **Components** in the solution explorer, expand **Entities**, expand **Opportunity**, and then select **Forms**.
5. Open the **Opportunity** form of form type **Main**.
6. In the **Product Line Items** section, double-click to select the **Opportunity products** section.

    :::image type="content" source="media/troubleshoot-table-views-issues/opportunity-products.png" alt-text="Select Opportunity products.":::

    The **Set Properties** dialog box opens.

    :::image type="content" source="media/troubleshoot-table-views-issues/set-properties-opportunity-products-grid.png" alt-text="Set properties of Opportunity Products grid.":::

7. On the **Controls** tab, double-click to select **Editable Grid**.

    :::image type="content" source="media/troubleshoot-table-views-issues/editable-grid-option.png" alt-text="Select Editable Grid on the Controls tab.":::

8. In the **Editable Grid** section, select the pencil icon next to **Hide nested grid column header**.

    :::image type="content" source="media/troubleshoot-table-views-issues/hide-nested-grid-column-header.png" alt-text="Select Hide nested grid column header.":::

9. In the **Configure Property** dialog box, under **Bind to static options**, select **Show column header**.

    :::image type="content" source="media/troubleshoot-table-views-issues/select-show-column-header.png" alt-text="Select Show column header in the Configure Property dialog box.":::

10. Save and publish the configuration.

## Issue 6 - Can't see opportunity records in the legacy web client when you select Opportunities from the site map but you can see them in Unified Interface

### Cause

Records are shown in the list based on table views. The issue might occur when there's no public view marked as the default view for a table.

### Resolution

Select one of the public views of the table as default. This ensures the views are displayed as expected. To learn how to make a view as your default view, see [Specify a model-driven app default view](/powerapps/maker/model-driven-apps/specify-default-views)

> [!NOTE]
> If you still can't see the records, clear the browser cache and try again.
