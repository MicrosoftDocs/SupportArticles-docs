---
title: Troubleshoot issues with forecasting
description: Provides resolutions for the known issues that are related to forecasting in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.reviewer: ladirohit, lavanyakr
ms.date: 03/13/2024
ms.subservice: d365-sales-sales
---
# Troubleshoot issues with forecasting

This article helps you troubleshoot and resolve issues related to forecasting in Microsoft Dynamics 365 Sales.

## Issue 1 - An error is displayed when you try to create a territory-based forecast

### Symptoms

When you try to create a territory-based forecast, an error is displayed. Also, the data in a territory-based forecast might not be refreshed.

### Cause

When system updates are performed, the territory entity's hierarchy is disabled (though you've enabled it earlier), which causes this error.

### Resolution

To resolve this issue, you must enable hierarchy in the **territory_parent_territory** relationship definition from **Relationships**. Follow these steps:

1. Go to **Advance settings**.

    The advance settings page opens in a tab.

2. Select **Settings** > **Customization** > **Customizations**.

    The **Power Apps** settings page opens.

3. Select **Data** > **Entities**, and then select **Territory**.

    :::image type="content" source="media/troubleshoot-forecast-issues/select-territory-in-power-apps.png" alt-text="Select the territory entity in Power Apps.":::

4. On the **Territory** page, select the **Relationships** tab, and then select **Parent**.

    :::image type="content" source="media/troubleshoot-forecast-issues/select-territory-parent-in-power-apps.png" alt-text="Select the parent for the territory entity.":::

5. In the **Many-to-one** dialog box, select the **Hierarchical** check box, and then select **Done**.

    :::image type="content" source="media/troubleshoot-forecast-issues/enable-hierarchy.png" alt-text="Enable the Hierarchy option in the Many-to-one dialog box.":::

6. Save and close the entity.

## Issue 2 - Can't hide the forecast category field in opportunity forms

### Cause

Sometimes, the app displays the **Forecast category** field in opportunity forms, even after it has been configured as invisible by default through form customizations.

### Resolution

To resolve this error, you must delete the **Forecast category** field from the form. Follow these steps:

1. In your app, on the nav bar, select the **Settings** icon, and then select **Advanced Settings**.

    :::image type="content" source="media/troubleshoot-forecast-issues/advanced-settings-option.png" alt-text="Advanced Settings on the Settings menu." border="false":::

    The **Business Management** settings page opens in a new browser tab.

2. On the nav bar, select **Settings**, and then under **Customization**, select **Customizations**.
3. Select **Customize the System**.
4. Under **Components** in the solution explorer, expand **Entities**, expand **Opportunity**, and then select **Forms**.
5. Open the **Opportunity** form of form type **Main**.

    The opportunity form opens in a new window.

6. In the **Summary** section, select the **Forecast category** field, and then select **Remove**.

    :::image type="content" source="media/troubleshoot-forecast-issues/remove-forecast-category-field.png" alt-text="Remove the forecast category field.":::

7. Save and publish the configuration.

## Issue 3 - Can't view forecasts

### Cause

If you were using the previous version of forecasting and updated to the latest, the forecasting site map might not be updated. This can be caused by the presence of an unmanaged layer of the Sales Hub app, which would allow the forecasting site map to open the previous version of forecasting.

The following image is an example of the previous version of forecasting home page.

:::image type="content" source="media/troubleshoot-forecast-issues/older-version-homepage.png" alt-text="Home page of the previous version of forecasting.":::

### Resolution

To resolve this issue, update the forecasting site map entry to the latest forecast entry grid. For more information, see [Add forecast grid and configuration options in site map](/dynamics365/sales/add-forecast-site-map).

## Issue 4 - Can't load the forecast grid and an error is displayed

### Cause

The **ForecastInstanceActions** process is deactivated. The reason might be that the owner of an organization has changed, which is causing the failure to load the forecast grid. The error shown in the following image is displayed.

> Action (ForecastInstanceActions) for fetching forecasts has been disabled.

:::image type="content" source="media/troubleshoot-forecast-issues/grid-loading-error.png" alt-text="The error message Action (ForecastInstanceAction) for fetching forecasts has been disabled." border="false":::

### Resolution

To resolve this error, activate the **ForecastInstanceActions** process. Follow these steps:

1. Go to **Advanced settings**, and then select **Settings** > **Process Center** > **Processes**.
2. In the search box, enter **ForecastInstanceActions**. You can see that the process is in the **Draft** state.

   :::image type="content" source="media/troubleshoot-forecast-issues/instance-actions-process-draft.png" alt-text="ForecastInstanceActions process in draft state." border="false":::

3. Select the process, and then select **Activate**.

    :::image type="content" source="media/troubleshoot-forecast-issues/activate-forecast-instance-actions-process.png" alt-text="Activate the ForecastInstanceActions process." border="false":::

4. On the confirmation message, select **Activate**.

    :::image type="content" source="media/troubleshoot-forecast-issues/forecast-instance-actions-process-activate.png" alt-text="Forecast instance actions process activated." border="false":::

5. Verify that the process state is **Activated**, and then close **Settings**.

## Issue 5 - Can't view drill down data in a forecast grid

### Cause

You don’t have enough privileges for **Forecast Configuration** entity to view drill down data in the forecast grid. The error shown in the following image is displayed.

> Something went wrong.  
> There was an error in retrieving the forecast records.  
> Please reload the browser page again.

:::image type="content" source="media/troubleshoot-forecast-issues/drilldown-loading-error.png" alt-text="The something went wrong error message that occurs when you try to view drill down data in a forecast grid." border="false":::

### Resolution

To resolve this error, your administrator must provide read privileges on **Forecast Configuration** entity to your security role. Follow these steps:

1. Go to **Advanced settings**, and then select **Settings** > **Security** > **Security Roles**.
2. Select the security role for which you want to apply the privileges.
3. On the security role page, select **Custom Entities** tab and go to **Forecast Configuration** row.
4. Select and provide the read privileges.

    :::image type="content" source="media/troubleshoot-forecast-issues/provide-read-privileges.png" alt-text="Provide read privileges for Forecast Configuration entity." border="false":::

5. Close the settings.

## Issue 6 - Forecast category fields aren't updated

### Cause

In a forecast, after updating the forecast category field to **Won** or **Lost**, the opportunities still appear in the previous pipeline bucket. This error occurs because the **Opportunity Forecast Category Mapping Process** workflow is disabled in your organization.

### Resolution

To resolve the error, activate the **Opportunity Forecast Category Mapping Process** workflow. Follow these steps:

1. Go to **Advanced settings**, and then select **Settings** > **Customizations** > **Customize the System**.
1. In the sitemap, select **Processes**.
1. Select the **Opportunity Forecast Category Mapping Process** workflow and then select **Activate**.

   :::image type="content" source="media/troubleshoot-forecast-issues/activate-opportunity-forecast-category-process.png" alt-text="Activate the Opportunity Forecast Category Mapping Process workflow.":::

    The forecast categories in the opportunities will be updated properly. The opportunities that were changed before activating the workflow must be manually changed. Also, open the **Opportunity Forecast Category Mapping Process** workflow and verify that the conditions are properly defined for each forecast category.

   :::image type="content" source="media/troubleshoot-forecast-issues/opportunity-forecast-category-process-conditions.png" alt-text="The Opportunity Forecast Category Mapping Process workflow conditions.":::

1. Save and close the settings.

## Issue 7 - Can't activate a forecast that has a hierarchy-related column of lookup type

### Cause

This issue occurs because the "Dynamics 365 Sales Forecasting" user doesn't have the read permission to the hierarchy-related lookup entity.

### Resolution

To solve the issue, follow the steps:

1. Go to **Advanced settings**, and select **Settings** > **System** > **Security** > **Security roles**.

1. Open the **Forecast AppUser** role and select the tab where the entity type is present.

   :::image type="content" source="media/troubleshoot-forecast-issues/set-up-read-permission.png" alt-text="Screenshot that shows the the Forecast App User role.":::

1. Enable the **Read** permission at the organization level for the lookup field's entity type.
1. Save the changes.

## Issue 8 - Can't activate a forecast

### Cause

The forecast activation fails due to multiple reasons.

### Resolution

To solve the issue, follow the steps:

1. Ensure that you have done all the mandatory configurations for your forecast model.
1. Ensure that hierarchy filters in the forecast configuration don't filter out the entire hierarchy. Go to the **Preview** section in the **General** step to ensure that the hierarchy exists. For more information, see [Add additional filters to a forecast](/dynamics365/sales/add-additional-filters).

## Issue 9 - Can't find the forecast configuration option in App Settings

### Cause

The forecast configuration option might not be visible in the App Settings of the Sales Hub app due to the following reasons:

- You don't have the read permission to the forecast configuration entity.
- Your administrator didn't manually [add the forecast grid and configuration](/dynamics365/sales/add-forecast-site-map#add-forecast-grid-and-forecast-configuration-options-to-sitemap) under the **Performance Management** section.

### Resolution

To solve the issue, follow these steps:

1. Assign the Forecast Manager security role to the user who should be able to create and manage forecast configurations.
1. In **Forecast configuration**, the forecast navigation pane items must be added in a custom app.

## Issue 10 - Can't view forecasts for user hierarchy

### Cause

This issue occurs due to insufficient permissions to view the forecast.

### Resolution

To solve the issue, make sure that:

1. One of these conditions is satisfied:

   - You're the owner of the forecast. The **Owner lookup field** in the **Permissions** step of the forecast configuration shows who the owner is.

      :::image type="content" source="media/troubleshoot-forecast-issues/permission.png" alt-text="Screenshot that shows the Permissions step of the forecast configuration.":::

   - You're part of the security roles that have the read permission, as configured in the **Permissions** step of the forecast configuration.
   - Someone has shared the forecast with you. For more information, see [Enable or disable forecast sharing](/dynamics365/sales/provide-permissions-forecast).

1. The **Owner lookup field** in the **Permissions** step of the forecast configuration isn't set to **None**. If it's set to **None**, no one can view the forecast.

## Issue 11 - Forecast field values show zero or blank in the forecast grid

### Cause

The columns associated with the **Selector**, **Amount field**, and **Date field** might have field-level security enabled.

### Resolution

To solve the issue, you need to grant the **Read** permission to the **# Dynamics 365 Sales Forecasting** user in the field security profiles. Otherwise, the column will show **0** to all users. Follow these steps to configure the field security profiles:

1. Go to **Settings**> **Advanced Settings** > **Security** > **Field Security Profiles**.
1. Select the field security profile associated with the field that shows **0**.
1. Select **Users** > **Add**.
1. Search for the **# Dynamics 365 Sales Forecasting** user, select the checkbox against the user name, and then select **Select** > **Add**.
1. Select **Field Permissions** and grant **Read** permission to the field.
1. Save and close the profile.

Recalculate the forecast and verify that the column shows appropriate values.

## Issue 12 - Can't manually recalculate the prediction column on the Forecasts page

### Cause

The prediction column on the **Forecasts** page can't be [manually recalculated](/dynamics365/sales/keep-forecast-data-up-to-date#recalculate-and-refresh-forecast-data-manually).

### Resolution

The prediction column in the Forecast is automatically recalculated after every seven days, and it doesn't support manual recalculation. This is because predictions are based on AI-driven models that look at historical data and the open sales pipeline to predict future revenue outcome. The prediction column shows the predicted revenue for each seller and manager based on the **Status** field of an opportunity. To optimize the accuracy of the predictions, ensure the **Forecast Category** values are kept in sync with the **Status** field. For the out-of-the-box forecast category, a workflow ensures that when an opportunity is closed as **Won** or **Lost**, the forecast category is updated with the proper value.

## Issue 13 - Forecast underlying grid view is disabled (read-only) when the page is loading

### Cause

A [custom JavaScript configured in the forecast configuration](/dynamics365/sales/forecast-configure-advanced-settings#upload-the-javascript-library-to-your-forecast) prevents the grid from being editable.

### Resolution

To solve the issue, review the custom JavaScript code and check if it disables the underlying records grid view.
