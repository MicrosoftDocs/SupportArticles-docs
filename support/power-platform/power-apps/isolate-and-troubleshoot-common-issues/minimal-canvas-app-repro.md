---
title: Create a minimal repro canvas app for troubleshooting
description: Provides more information about how to create an app that showcases a problem clearly.
author: tahoon
ms.reviewer: tapanm
ms.date: 07/05/2023
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---
# How to create a minimal repro canvas app

A minimal repro app is an app that contains the minimum amount of logic and controls to reproduce a problem. This app helps you narrow down the source of the issue, whether it be with the data source, formulas, or a particular configuration.

After creating a minimal repro app, you can download a copy of it and share it with others, like in the [Microsoft Power Apps Community](https://powerusers.microsoft.com/t5/Power-Apps-Community/ct-p/PowerApps1) or with [Microsoft Support](https://powerapps.microsoft.com/support/).

You can create a minimal repro app with one of the following methods:

- Create a blank app and add just the necessary connections and controls to demonstrate the problem.
- Make a copy of the original app, progressively remove irrelevant screens and controls, and simplify formulas until you're left with the issue's essence.

## Replace external data sources

A minimal repro app should be self-contained. It shouldn't rely on connections to external data sources, like Dataverse or SharePoint, because external parties won't be able to access them.

You can see data sources used in the app in the **Data** panel.

:::image type="content" source="media/minimal-canvas-app-repro/studio-data-panel.png" alt-text="Screenshot that shows the Data panel in Power Apps Studio. The panel is empty if no data sources are used in the app." border="false":::

To handle data sources when creating a minimal repro app, you can:

- Remove them if they're not relevant to the issue you're showing.
- Use [Collections](/power-apps/maker/canvas-apps/create-update-collection) with sample data.
- Provide sample data in a *csv* or Excel file. Explain how to re-create the data source from scratch.

Sample data should be as simple as possible.

## Stub integrations and external web services

Apps may use features from other web services. For example, it may display a [Power BI tile](/power-apps/maker/canvas-apps/controls/control-power-bi-tile), YouTube video, or Power Automate flows.

Remove these components if they're not relevant to the issue you're showing. If they're essential, you should provide materials and instructions on how to re-create them. Use sample content instead of the original. If the issue doesn't occur with sample content, it might be an issue with the external content or service. For example, a Power BI report may not be configured correctly for embedding.

## Simplify components

If the app contains [components](/power-apps/maker/canvas-apps/create-component) or [code components](/power-apps/developer/component-framework/component-framework-for-canvas-apps), others may not be able to see their internals or load them correctly.

Remove these components if they're not relevant to the issue you're showing. If they're essential, you should simplify them as much as possible and then:

- Package them together with the app in an [unmanaged solution](/power-apps/maker/data-platform/export-solutions)
- Provide instructions on how to re-create these components from scratch.
- For code components, mention which lines of code and [framework feature](/power-apps/developer/component-framework/reference) aren't working.

## Review for privacy and security

Unauthorized users won't be able to access data sources in exported apps, but they can see how the data sources are used in them. They can also see the app's controls and formulas. If an entire solution *.zip* file is provided, assets like images are also visible.

Follow the below steps to help you limit privacy and security exposure before distributing the exported app:

- Don't include private and confidential information in the app. Check names of variables, controls, and other app elements that can inadvertently give away sensitive information.
- Create a new app from scratch instead of simplifying an existing production app. A new app will also reduce the accidental exposure of sensitive information if you were to use the original app instead. You'll save time by not needing to manually remove sensitive information from the original app.
- Distribute just the *.msapp* file instead of the *.zip* file. The *.msapp* file can be found inside the *.zip* package.

## Download the minimal repro app

A canvas app can be saved in a *.msapp* or *.zip* file, depending on how it was created.

### Power Apps

1. Sign in to [Power Apps](https://make.powerapps.com/).

1. Open the app for editing.

2. Expand the **Save** menu item and select **Download a copy**.

   :::image type="content" source="media/minimal-canvas-app-repro/studio-save.png" alt-text="Screenshot that shows an expanded sub-menu for the Save menu item in Power Apps Studio. The option Download a copy is highlighted.":::

   The downloaded *.msapp* file can be opened by others selecting **Open** in the menu bar of [Power Apps](https://make.powerapps.com/). You may have to expand the menu bar to see this option.

   :::image type="content" source="media/minimal-canvas-app-repro/studio-open.png" alt-text="Screenshot that shows a popup at the end of the menu bar in Power Apps Studio, containing more menu items. The option Open is highlighted.":::

### Microsoft Lists

1. Open the list.

1. Select **Integrate** > **Power Apps** > **Customize forms**. The customized form will open in Power Apps.

   :::image type="content" source="media/minimal-canvas-app-repro/microsoft-list.png" alt-text="Screenshot that shows the **Power Apps** menu in Microsoft List. The option Customize forms is highlighted.":::

1. Select **Share** from the menu at the top. The details page with the sharing panel will open.

   :::image type="content" source="media/minimal-canvas-app-repro/microsoft-list-studio.png" alt-text="Screenshot that shows editing an app in the studio. The icon button for Share is highlighted in the top menu bar." border="false":::

1. Dismiss the sharing panel.

1. Select **Export package** in the menu bar.

   :::image type="content" source="media/minimal-canvas-app-repro/microsoft-list-maker-portal.png" alt-text="Screenshot that shows the app details. The command button for Export package is highlighted in the top menu bar.":::

1. Type a name to the package. Review the exported content and select **Export**.

    The downloaded *.zip* file can be opened by others.

### Power Apps in Teams

1. In Microsoft Teams, go to the [Power Apps app list for your team](/power-apps/teams/manage-your-apps).

1. Select the app.

1. Select **Export solution** from the menu at the top.

   :::image type="content" source="media/minimal-canvas-app-repro/teams.png" alt-text="Screenshot that shows the apps list. An app is selected, and the command button for Export solution is highlighted in the top menu bar.":::

1. Review the exported content and select **Export as zip**.

    The downloaded *.zip* file can be [imported](/power-apps/maker/canvas-apps/export-import-app#importing-a-canvas-app-package) by other users.

### Custom pages

Only custom pages in [unmanaged solutions](/power-platform/alm/solution-concepts-alm#managed-and-unmanaged-solutions) can be exported. If the custom page is in a managed solution, ask the publisher of the solution to create an unmanaged solution that contains the custom page. You can also create a new unmanaged solution and custom page there.

You can [export custom pages in an unmanaged solution](/power-apps/maker/data-platform/export-solutions) just like any other solution component. The downloaded *.zip* file can be imported into any environment by other users.

## Next steps

- [Ask a question with Microsoft Power Apps Community](https://powerusers.microsoft.com/t5/Power-Apps-Community/ct-p/PowerApps1)
- [Get Microsoft Support](https://powerapps.microsoft.com/support/)

## See also

- [Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps)
- [Debugging model-driven apps with Monitor](/power-apps/maker/monitor-modelapps)
