---
title: Common issues and resolutions for Power Apps
description: A list of common issues and resolutions within Power Apps.
author: KumarVivek
ms.custom: canvas
ms.reviewer: tapanm, lanced, tahoon 
ms.date: 02/01/2024
ms.author: kvivek
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tapanm-msft
  - mduelae
---
# Common issues and resolutions for Power Apps

This article lists common issues you might encounter while using Power Apps. Issues are grouped by area, and summary-level workarounds are provided where applicable, with pointers to primary documentation locations where you might find more details.

Refer to the introductory article [Power Apps troubleshooting strategies](isolate-common-issues.md) for guidance on narrowing down the source of your issue. That article outlines key principles for debugging both functional and performance issues.

## Common issue areas

- [Connectors and delegation](#connectors-and-delegation)
- [Controls](#controls)
- [Integration](#integration)
- [Power Fx](#power-fx)
- [Region](#region)
- [Studio and Forms](#studio-and-forms)
- [Browser](#browser)
- [Power Apps for Windows](#power-apps-for-windows)
- [Next steps](#next-steps)
  
## Connectors and delegation

- See [Connections](/power-apps/maker/canvas-apps/connections-list) for an overview of how tabular and action connectors work.
- See [Understanding delegation in a canvas app](/power-apps/maker/canvas-apps/delegation-overview) for details about delegation.
- See [Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps) for a description of how to monitor the data being sent and returned.

### Common issues

1. **Automatic Next links for galleries and grids don't work for action-based connectors.**

    Next links (the property on a query result that enables a gallery or grid to automatically page in the next set of results of a query) aren't supported for action-based connectors. For a discussion of this topic, see the [Overview of connectors for canvas apps](/power-apps/maker/canvas-apps/connections-list#actions).

1. **Sharing a Canvas app using SharePoint connector**

    For more information about how to share an app for SharePoint, see [Connect to SharePoint from a canvas app](/power-apps/maker/canvas-apps/connections/connection-sharepoint-online).

1. **SQL data sources no longer add a "[dbo]" prefix to the data source name.**

    For more information about this change, see [Connect to SQL Server from Power Apps](/power-apps/maker/canvas-apps/connections/connection-azure-sqldatabase).

1. **Custom connectors and Microsoft Dataverse**

    If an app created using Power Apps build 2.0.540 or earlier relies on a database in the Dataverse and at least one custom connector in a different environment, you'll need to deploy the connector to the same environment as the database and update the app to use the new connector. Otherwise, a dialog will notify users that the API wasn't found. For more information, see [Environments overview](/power-platform/admin/environments-overview).

1. **Column names with spaces**

    If you're using a list created using Microsoft Lists, a SharePoint library, or an Excel table in which a column name contains a space, the column name with a space can be used with single quotes, like this `someList.'Color Tag'`.

1. **Apps that connect to on-premises SharePoint**

    If you share an app that relies on connections that aren't automatically shared (for example, an on-premises SharePoint site), users who open the app in a browser will see a dialog box with no text when they select or tap **Sign in**. To close the dialog box, select or tap the close (X) icon in the upper-right corner. The dialog box doesn't appear if you open the app in [Power Apps Studio](/power-apps/maker/canvas-apps/power-apps-studio) or [Power Apps mobile](/power-apps/mobile/run-powerapps-on-mobile). For more information about shared connections, see [Share app resources](/power-apps/maker/canvas-apps/share-app-resources).

1. **For apps that are created from data, only the first 500 records of a data source can be accessed.**

    Power Apps works with large data sources by delegating operations to the data source. For operations that can't be delegated, Power Apps will give a warning at authoring time and operate on only the first 500 records of the data source. For more information, see the [Delegation overview](/power-apps/maker/canvas-apps/delegation-overview#delegable-functions).

1. **Excel data must be formatted as a table.**

    For information about limitations when you use Excel as a data source, see [Cloud-storage connections](/power-apps/maker/canvas-apps/connections/cloud-storage-blob-connections).

1. **Microsoft Lists is supported but not SharePoint libraries, some types of list columns, or columns that support multiple values or selections.**

    For more information, see [SharePoint Online](/power-apps/maker/canvas-apps/connections/connection-sharepoint-online#known-issues).

1. **Sign-in issues on certain Android mobile devices when using authenticator**

    In certain devices and scenarios, you might experience sign-in failures when using an authenticator. This is due to the OEM limiting this functionality. For more information, see [ADALError: BROKER_AUTHENTICATOR_NOT_RESPONDING](https://github.com/AzureAD/azure-activedirectory-library-for-android/wiki/ADALError:-BROKER_AUTHENTICATOR_NOT_RESPONDING).

1. **Office 365 Video connector isn't supported.**

## Controls

### Common issues

1. **Can't copy and paste forms into data cards.**

    You can't copy and paste forms into data cards. This is to prevent certain combinations of controls from being created that risk the stability and performance of the app. To learn how to configure forms that allow scrolling, see [scrolling screen for forms](/power-apps/maker/canvas-apps/add-scrolling-screen#scrolling-screen-for-forms).

1. **Camera images don't contain meta-data information.**

    When you use the camera control, the image doesn't contain meta-data information. This is due to a limitation of how we take images with the camera. To mitigate this issue, use the [Add picture control](/power-apps/maker/canvas-apps/controls/control-add-picture).

1. **Images added from iOS don't contain meta-data information.**

    When using the **Add Picture** control on iOS, images imported by using the camera or gallery don't contain meta-data like orientation, location information, or camera settings.

1. **Combo box controls in galleries**

    When you use a **Combo box** control inside a gallery, its selections aren't maintained when the user scrolls the gallery. This isn't an issue if you use a **Combo box** control inside a gallery that doesn't scroll. A workaround isn't currently available.

1. **"Data Table" control**

    If you copy and paste a **Data Table** control for which the **Items** property is set to a formula that contains a **Filter** function, the formula for the **Items** property on the new **Data Table** control ends up with field names that contain a **_1** suffix. This makes the field names invalid and results in no data showing up in the data table. To work around this issue, before you copy the control, confirm that the **Filter** function doesn't reference any field in the data source that has the same name as a column in the **Data Table** control. If it does, rename the column in the **Data Table** control. Alternatively, remove the **_1** suffix from the invalid field names so that they match the names in the table.

1. **"Empty" gallery when opening an app**

    If you generate an app automatically from data, save the app, and then reopen it, the browse gallery might not immediately show any data. To resolve this issue, type at least one character in the search box, and then delete the text that you typed. The gallery will then show the data as expected.

1. **Scanning a barcode**

    For more information about limitations and best practices when you use a **Barcode** control, see [Barcode scanner control in Power Apps](/power-apps/maker/canvas-apps/controls/control-new-barcode-scanner).

1. **Camera usage might be temporarily disabled if memory is low.**

    If your mobile device is low on memory, the camera is temporarily disabled to avoid crashing the device.

1. **Multiple media controls in Power Apps Mobile**

    Power Apps Mobile runs on various types of devices, and some of them have limitations that are specific to that platform:

    - You can play videos in multiple **Video** controls at the same time on all platforms except iPhone devices.
    - You can record audio with multiple **Microphone** controls at the same time on all platforms except the web player.

1. **Drawing with mouse or touch input isn't smooth in Power Apps for Windows.**

    The pen control only has partial support for drawing using a mouse or touch input in the Windows app. Strokes might be intermittent. For smooth drawing, use a pen or run the app in a browser.

1. **Camera controls in Power Apps for Windows**

   Power Apps for Windows might crash if you open an app that uses a camera control. To avoid this problem, use the web player on the Windows platform. Also, multiple cameras aren't supported.

## Integration

## Power Fx

1. **`Connection.Connected` returns the wrong value during OnStart in Power Apps for Windows.**

   While offline, the `Connection.Connected` formula might wrongly return **true** immediately after starting an app in the Windows app. As a workaround, use a **Timer** control to delay the execution of the logic depending on it.

1. **Issues with Date-time**

    For more information about [Microsoft Power Fx](/power-platform/power-fx/overview) and the date and time issues in Power Apps canvas apps, see [Troubleshooting Canvas app date time issues](troubleshoot-canvas-app-date-time-issues.md). For the date and time issues in model-driven apps, see [Troubleshooting Model driven app date time issues](troubleshoot-model-driven-app-date-time-issues.md)

## Region

**Performance degradation when opening Power Apps Studio in China**

[Power Apps Studio](/power-apps/maker/canvas-apps/power-apps-studio) might take more than 30 seconds when loading in China. This issue doesn't impact tenants hosted locally by 21Vianet.

## Studio and Forms

The [Power Apps Studio](/power-apps/maker/canvas-apps/power-apps-studio) is home to the app editing and publishing experience.  

1. **Problems with startup**

    If you have trouble accessing or starting Power Apps, see [troubleshooting startup issues](troubleshooting-startup-issues.md).

1. **Problems changing dimensions or orientation of SharePoint forms**

   If you have issues with the **Screen size + orientation** settings for custom SharePoint forms, you can use the **Custom** size to work around the issue. First, reset the setting by selecting the **Small** size, then toggle **Orientation** to **Portrait** and then back to **Landscape**. Then, select **Custom** and enter a desired screen size. For reference, the preset values are "Width: 270, Height: 480" for the Small Portrait size, and "Width: 720, Height: 480" for the Small Landscape size.

1. **Copying and pasting screens across apps**

    Copying and pasting screens across apps isn't currently supported. To work around this issue, add a new screen to your target app, copy the controls from the screen in your source app, and then paste them into the screen of your target app.

1. **Changing the layout of SharePoint forms**

    While customizing SharePoint forms in certain languages, if you try to change the layout from **Portrait** (default) to **Landscape**, the app might show multiple errors (yellow triangles in controls). To resolve these errors and retain the landscape layout, select **Undo**.

1. **Changing a flow in a shared app**

    If you add a flow to an app, share it, and then add a service or change a connection in the flow, you must remove the flow from the shared app, re-add the flow, and then reshare the app. Otherwise, users who trigger the flow receive an authentication failure.

1. **Changing a "Title" field in a table**

    If you change the **Title** field for a table that other tables reference through one or more lookups, an error occurs when you try to save the change. To work around this issue, remove any lookups to the table for which you want to change the **Title** field, make the change, and then re-create the lookups. For more information about lookups, see [Create a relationship between tables](/power-apps/maker/data-platform/data-platform-entity-lookup).

1. **When Power Apps generates an app from data, the field used for sorting and searching isn't automatically configured.**

   To configure the field, edit the [Items](/power-apps/maker/canvas-apps/controls/properties-core) formula for the gallery, as described in [Filter and sort a gallery](/power-apps/maker/canvas-apps/add-gallery#filter-and-sort-a-gallery).

1. **It can sometimes take a moment before a newly shared app can be used.**

    In some cases, a newly shared app won't be immediately available. Wait a few moments, and it should become available.

1. **In the [Form control](/power-apps/maker/canvas-apps/controls/control-form-detail), you can't change data by using a custom card.**

    The stock custom card is missing the **[Update](/power-apps/maker/canvas-apps/controls/control-card)** property, which is required to write back changes. To work around this issue:

    - Select the **Form** control, and insert a card by using the right-hand pane based on the field that you want the card to show.
    - Unlock the card, as described in [Understanding data cards](/power-apps/maker/canvas-apps/working-with-cards#unlock-a-card).
    - Remove or rearrange controls within the card as you see fit, just as you would with the custom card.

1. **Card gallery is deprecated.**

    Existing apps that use this feature continue to run for now, but you can't add a card gallery. Replace card galleries with the new **[Edit form](/power-apps/maker/canvas-apps/controls/control-form-detail)** and **[Display form](/power-apps/maker/canvas-apps/controls/control-form-detail)** controls.

## Browser

**Browser running out of memory**

If you're using the 32-bit version of Google Chrome or Microsoft Edge and run out of memory while using Power Apps, consider using the 64-bit version.

## Power Apps for Windows

1. **Power Apps mobile app for the Windows platform doesn't support the Dropbox connector.**

   A pop-up dialog shows the following message in this situation:

   > We can't connect to the service you need right now. Check your network connection or try again later.

   When this issue occurs, consider using a web player on the Windows platform.

1. **Microsoft Entra Conditional Access with the policy "Require device to be marked as compliant" doesn't work in Power Apps for Windows.**

   When the Conditional Access policy is set to "Require device to be marked as compliant" in Microsoft Entra ID, users receive the following sign-in error and can't access their Power Apps.

   To work around the issue, they can use a browser.

   > The application contains sensitive information and can only be accessed from devices or client applications that meet your enterprise management compliance policy.

## Next steps

If your issue isn't listed in this article, you can [search for more support resources](https://powerapps.microsoft.com/support), or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support). For more information, see [Get Help + Support](/power-platform/admin/get-help-support).
