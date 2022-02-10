---
title: Troubleshooting issues with views
description: Learn how to troubleshoot issues with table views in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 02/02/2022
---

# Troubleshooting table views  

This article helps you troubleshoot and resolve issues related to table views.


## Issue: I can't see data in certain columns in table views<a name="no_data_in_views"></a>

### Cause

This error is occurring due to mismatch of column names between the `layoutxml` and `fetchxml` in the view ODATA file (*OrgUrl*/api/data/*Dynamics 365 version*/savedqueries(*ViewId*)). 

### Solution

To resolve this issue, you must remove and add back the column that is causing this error. This will ensure that the column names in `layoutxml` and `fetchxml` are matched.

> [!NOTE]
> Before you start resolving the issue, take note of the view for which this error is occurring.

1. Go to **Settings** > **Customizations** > **Customize the System**.
2. Select the **Entity** > **Views** and select the view that has this error. In this example, we're selecting the table **Account** and view as **Accounts Being Followed**.

    > [!div class="mx-imgBorder"]
    > ![Choose a view from the table.](media/sales/troubleshooting-column-entity-view-selection.png "Choose a view from the table")

3. Select **More Actions** > **Edit**. 

    The view edit page opens.

    > [!div class="mx-imgBorder"]
    > ![Edit a view.](media/sales/troubleshooting-column-edit-view.png "Edit a view")

4. Select the column that is causing the issue and select **Remove**. In this example, we select the column **Email (Primary Contact)** to remove.

    > [!div class="mx-imgBorder"]
    > ![Remove column from view.](media/sales/troubleshooting-column-remove-column-view.png "Remove column from view")

    The column is removed from the view.

5. Add back the column that you've deleted. Select **Add Columns** and readd the column that you removed. In this example, we're adding  the column **Email (Primary Contact)** that was removed.

    > [!div class="mx-imgBorder"]
    > ![Adding back the removed column.](media/sales/troubleshooting-column-add-back-column-view.png "Adding back the removed column")
   
    The data in the columns is displayed properly.

<a name="records_missing_in_views"> </a>
## Issue: I can't see some records in the table views

### Cause

This error is occurring due to the filtering of data on a view. 

### Solution

To resolve this issue, you must edit or remove filters for the view. This will ensure that filters are applied properly for the view.

> [!NOTE]
> Before you start resolving the issue, take note of the view for which this error is occurring.

1. Go to **Settings** > **Customizations** > **Customize the System**.
2. Select the **Entity** > **Views** and select the view that has this error. In this example, we're selecting the table **Account** and view as **Accounts I Follow**.

    > [!div class="mx-imgBorder"]
    > ![Choose the view from the table.](media/sales/troubleshooting-record-entity-view-selection.png "Choose the view from the selected table")

3. Select **More Actions** > **Edit**. 

    The view edit page opens.

    > [!div class="mx-imgBorder"]
    > ![Edit the view.](media/sales/troubleshooting-record-edit-view.png "Edit the view")

4. Select **Edit Filter Criteria** and recheck the filter condition either by updating or deleting.

    > [!div class="mx-imgBorder"]
    > ![Update or clear the filter criteria.](media/sales/troubleshooting-record-update-filter.png "Update or clear the filter criteria")
   
    The records in the views are displayed properly.

## Issue: I can't see some records in opportunity, quote, order, or invoice subgrids
<a name="missing-records"></a>

While working on opportunity, quote, order, or invoice records, you might observe that some records are missing.

### Cause

You might not see some records because of an error that occurred due to customization done to the subgrid.

### Solution

To fix the issue of incorrect customization, follow these steps to make sure your subgrid is configured correctly:

1.  In your app, on the nav bar, select the **Settings** icon, and then select **Advanced Settings**.

    > [!div class="mx-imgBorder"]
    > ![Advanced Settings link in the Settings menu.](media/sales/advanced-settings-option.png "Advanced Settings link in the Settings menu")

    The **Business Management** settings page opens in a new browser tab.

2. On the navigation bar, select **Settings**, and then under **Customization**, select **Customizations**. 

3. Select **Customize the System**.

4. Under **Components** in the solution explorer, expand **Entities**, expand **Opportunity**, and then select **Forms**.

5. Open the Opportunity form of type **Main**.

6. Double-click to select the **Connections** section in the **Product Line Items** section.

    > [!div class="mx-imgBorder"]
    > ![Product Line Items subgrid.](media/sales/product-line-items-subgrid.png "Product Line Items subgrid")

    The **Set Properties** dialog box opens.

    > [!div class="mx-imgBorder"]
    > ![Set properties of Opportunity Products grid.](media/sales/set-properties-opportunity-products-grid.png "Set properties of Opportunity Products grid")

7. On the **Controls** tab, double-click to select **Editable Grid**.

    > [!div class="mx-imgBorder"]
    > ![Double-click the Editable Grid option.](media/sales/editable-grid-option.png "Double-click Editable Grid option")

8. Make sure that all values are set correctly:

    -  Grid View: Opportunity Product Inline Edit View

    -  Nested Grid View: Select the pencil icon and fill in the following details:

        > [!div class="mx-imgBorder"]
        > ![Configure property dialog box.](media/sales/configure-property-dialog-box.png "Configure property dialog box")

        -  Table: Opportunity Products

        -  View: Opportunity Product Inline Edit View: Bundle Products

    -   Nested grid parent ID: parentbundleidref

    -   Group by Column: Enabled (Enum)

    -   Allow filtering: Enabled (Enum)

    -   Hide nested grid column header: Hide Column

        >[!NOTE]
        >If you're using product bundles and edit these bundled line items in the product grid, select **Hide nested grid column header** as **Show Column**.

## Issue: I can't set a custom view as the default view for the Existing products field in Add products dialog

To add products to an opportunity, quote, order, or invoice, you select the products from the **Existing product** lookup field in the **Add products** dialog. If you change the default view of the lookup field to a custom view, the field doesn't display products from the custom view. 

### Cause

To be able to display products from the selected price list, the lookup always defaults to a system view named **Products in Parent Price List**. So, even if you change the default, the lookup field will set the default back to the **Products in Parent Price List** view.

### Solution

This behavior is working as designed. Though you can't set a default view, you can manually switch to the view in the **Existing products** lookup field.

:::image type="content" source="media/sales/change-view-opportunity.PNG" alt-text="Change view option in add products dialog":::

## Issue: I can't update nested bundle items on the Product tab 
<a name="cannot_update_nested_bundle_items"></a>

### Cause

While working on an opportunity, when you update nested bundle items on the **Product** tab, the save icon is disabled. This error occurs because the header of the nested grid column is hidden under **Opportunity Product Inline Edit View** in customizations.  

### Solution

To resolve this issue, follow these steps to show the header of the nested grid columns for products on the opportunity form.

1.  In your app, on the nav bar, select the **Settings** icon, and then select **Advanced Settings**.

    > [!div class="mx-imgBorder"]
    > ![Advanced Settings on the Settings menu.](media/sales/advanced-settings-option.png "Advanced Settings on the Settings menu")

    The **Business Management** settings page opens in a new browser tab.

2. On the navigation bar, select **Settings**, and then under **Customization**, select **Customizations**. 

3. Select **Customize the System**.

4. Under **Components** in the solution explorer, expand **Entities**, expand **Opportunity**, and then select **Forms**.

5. Open the **Opportunity** form of form type **Main**.

6. In the **Product Line Items** section, double-click to select the **Opportunity products** section.

    > [!div class="mx-imgBorder"]
    > ![Select Opportunity products.](media/sales/troubleshooting-opportunity-products.png "Select Opportunity products")
    
    The **Set Properties** dialog box opens.

    > [!div class="mx-imgBorder"]
    > ![Set properties of Opportunity Products grid.](media/sales/set-properties-opportunity-products-grid.png "Set properties of Opportunity Products grid")

7. On the **Controls** tab, double-click to select **Editable Grid**.

    > [!div class="mx-imgBorder"]
    > ![Select Editable Grid.](media/sales/editable-grid-option.png "Select Editable Grid")

8. In the **Editable Grid** section, select the pencil icon next to **Hide nested grid column header**. 
    
    > [!div class="mx-imgBorder"]
    > ![Select Hide nested grid column header.](media/sales/troubleshooting-hide-nested-grid-column-header.png "Select Hide nested grid column header")

9. In the **Configure Property** dialog box, under **Bind to static options**, select **Show column header**.
    
    > [!div class="mx-imgBorder"]
    > ![Select Show column header.](media/sales/troubleshooting-select-show-column-header.png "Select Show column header")

10. Save and publish the configuration.

## Issue: When I select Opportunities from the site map, I can't see opportunity records in the legacy web client while I can see them in Unified Interface <a name="default-view-not-set"></a>

### Cause

Records are shown in the list based on table views. The issue might occur when there's no public view marked as the default view for a table.  

### Solution

Select one of the public views of the table as default. This ensures the views are displayed as expected. To learn how to make a view as your default view, see [Specify a model-driven app default view](/powerapps/maker/model-driven-apps/specify-default-views)

> [!NOTE]
> If you still can't see the records, clear the browser cache and try again.


