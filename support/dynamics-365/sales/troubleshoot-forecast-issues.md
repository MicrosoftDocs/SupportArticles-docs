---
title: Troubleshoot issues with forecasting
description: Provides resolutions for the known issues that are related to forecasting in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 02/28/2022
ms.subservice: d365-sales-sales
---

# Troubleshoot issues with forecasting

This article helps you troubleshoot and resolve issues related to forecasting.

## Issue 1 - An error is displayed when you try to create a territory-based forecast

### Symptom

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

In a forecast, after updating the forecast category field to Won or Lost, the opportunities are still appearing in the previous pipeline bucket. This error is occurring due to the **Opportunity Forecast Category Mapping Process** workflow is disabled in your organization.

### Resolution

To resolve the error, activate the **Opportunity Forecast Category Mapping Process** workflow. Follow these steps:

1. Go to **Advanced settings**, and then select **Settings** > **Customizations** > **Customize the System**.
2. From the sitemap, select **Processes**.
3. Select the **Opportunity Forecast Category Mapping Process** workflow and select **Activate**.

    :::image type="content" source="media/troubleshoot-forecast-issues/activate-opportunity-forecast-category-process.png" alt-text="Activate the Opportunity Forecast Category Mapping Process workflow.":::

    The forecast categories in the opportunities will be updated properly. For opportunities that were changed before activating the workflow must be manually changed. Also, open the **Opportunity Forecast Category Mapping Process** workflow and verify that the conditions are properly defined for each forecast category.

    :::image type="content" source="media/troubleshoot-forecast-issues/opportunity-forecast-category-process-conditions.png" alt-text="The Opportunity Forecast Category Mapping Process workflow conditions.":::

4. Save and close the settings.
