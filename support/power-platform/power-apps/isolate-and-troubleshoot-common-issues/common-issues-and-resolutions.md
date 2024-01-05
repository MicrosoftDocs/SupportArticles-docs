---
title: Common issues and resolutions for Power Apps
description: A list of common issues and resolutions within Power Apps.
author: KumarVivek
ms.custom: canvas
ms.reviewer: tapanm, lanced
ms.date: 04/11/2022
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

There are different approaches to troubleshooting depending on the type of issue you're facing.  This top level guide gets you started in the right direction.

## Functionality troubleshooting

For issues with **functionality** - where Power Apps features aren't behaving as expected - you should first isolate the problem using the one of the articles listed as a guide.  Being able to reliably reproduce (a "repro") the issue with as few steps as possible is a critical first step in figuring out the issue.

* [General issue isolation approach](isolate-common-issues.md)

Then, specifically for Canvas apps, use these articles.

* [Isolating Canvas App issues](isolate-canvas-app-issues.md)
* [Minimal Canvas App repro](minimal-canvas-app-repro.md)

And for Model driven apps, use these articles.

* [Isolate Model App issues](isolate-model-app-issues.md)
* [Minimal Model App issues](vanilla-model-driven-app-repro.md)

When you have the specific issue then the following sections in this article (and associated links) may help.
    - [Connectors and delegation](#connectors-and-delegation)
    - [Controls](#controls)
    - [Integration](#integration)
    - [Power Fx](#power-fx)
    - [Region](#region)
    - [Studio and Forms](#studio-and-forms)
    - [Browser](#browser)
    - [Power Apps for Windows](#power-apps-for-windows)

See [Next steps](#next-steps) later in this article if your issue isn't listed.

## Performance troubleshooting

For an overview of how to create a performant canvas app, read this article:

* [Overview of creating performant apps](/power-apps/maker/canvas-apps/create-performant-apps-overview) section.

Then, these specific articles help guide you to a more performant app.

* [Small data payloads](/power-apps/maker/canvas-apps/small-data-payloads)
* [Optimized data query patterns](/power-apps/maker/optimized-query-data-patterns)
* [Speed up app or page load](/power-apps/maker/canvas-apps/fast-app-page-load)
* [Fast calculations](/power-apps/maker/canvas-apps/efficient-calculations)

### Specific common issues

**Explicit column selection and columns that disappear.**

Some customers may find issues with Explicit column selection (ECS) turned on - columns may not be retrieved from the data source if the data is first retrieved into a collection. See * [Speed up app or page load](/power-apps/maker/canvas-apps/fast-app-page-load) for a discussion on how to make this feature work.

## Specific functionality areas

Below common issues are arranged by several of the key areas of Power Apps along with links to the general documentation that may  be helpful.  Many of issues called out here are also listed in the general documentation but are highlighted here for easy reference.

### Connectors and delegation

See [Connections](/power-apps/maker/canvas-apps/connections-list) for an overview of Tabular and Action connectors work.  See [Understanding delegation in a canvas app](/power-apps/maker/canvas-apps/delegation-overview) for details about delegation. See [Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps) for a description on how to monitor the data being sent and returned.

#### Common issues

1. **Automatic Next links for galleries and grids do not work for action-based connectors.**

    Next links (the property on a query result that enables a gallery or grid to automatically page in the next set of results of a query) aren't supported for action-based connectors. See the [Overview of connectors for canvas apps](/power-apps/maker/canvas-apps/connections-list) for a discussion on this topic.

1. **Sharing a Canvas apps using SharePoint connector** (February 23, 2022)
    See [Connect to SharePoint from a canvas app](/power-apps/maker/canvas-apps/connections/connection-sharepoint-online) for details on how to share an app for SharePoint.

1. **SQL data sources no longer add a "[dbo]" prefix to the data source name** (April 27, 2021)

    See [Connect to SQL Server from Power Apps](/power-apps/maker/canvas-apps/connections/connection-azure-sqldatabase) for details on this change.

1. **Custom connectors and Microsoft Dataverse**

    If an app created using Power Apps build 2.0.540 or earlier relies on a database in the Dataverse and at least one custom connector in a different environment, you'll need to deploy the connector to the same environment as the database and update the app to use the new connector. Otherwise, a dialog box will notify users that the API wasn't found. For more information, see [Environments overview](/power-platform/admin/environments-overview).

1. **Column names with spaces**

    If you're using a list created using Microsoft Lists, or a SharePoint library, or an Excel table in which a column name contains a space, Power Apps will replace it with **"\_x0020\_"**. For example, **"Column Name"** in SharePoint or Excel will appear as **"Column_x0020_Name"** in Power Apps when displayed in the data layout or used in a formula.

1. **Apps that connect to on-premises SharePoint**

    If you share an app that relies on connections that aren't automatically shared (for example, an on-premises SharePoint site), users who open the app in a browser will see a dialog box with no text when they select or tap **Sign in**. To close the dialog box, select or tap the close (X) icon in the upper-right corner. The dialog box doesn't appear if you open the app in Power Apps Studio or Power Apps Mobile. For more information about shared connections, see [Share app resources](/power-apps/maker/canvas-apps/share-app-resources).

1. **For apps that are created from data, only the first 500 records of a data source can be accessed**.

     Power Apps works large data sources by delegating operations to the data source. For operations that can't be delegated, Power Apps will give a warning at authoring time and operate on only the first 500 records of the data source. For more information, see the [Delegation overview](/power-apps/maker/canvas-apps/delegation-overview#delegable-functions).

1. **Excel data must be formatted as a table**.

     For information about limitations when you use Excel as a data source, see [Cloud-storage connections](/power-apps/maker/canvas-apps/connections/cloud-storage-blob-connections).

1. **Microsoft Lists is supported but not SharePoint libraries, some types of list columns, or columns that support multiple values or selections**.

     For more information, see [SharePoint Online](/power-apps/maker/canvas-apps/connections/connection-sharepoint-online#known-issues).

1. **Sign-in issue on certain Android mobile devices when using authenticator** (August 21, 2019)

    In certain devices and scenarios, you may experience sign-in failures when using authenticator. This is due to the OEM limiting this functionality. For more information, see [ADALError: BROKER_AUTHENTICATOR_NOT_RESPONDING](https://github.com/AzureAD/azure-activedirectory-library-for-android/wiki/ADALError:-BROKER_AUTHENTICATOR_NOT_RESPONDING).

1. **Office 365 Video connector isn't supported**.

### Controls

#### Common issues

1. **Unable to copy paste forms into data cards** (March 2022)

    You can't copy and paste forms into data cards. This is to prevent certain combinations of controls from being created that risk the stability and the performance of the app. To learn about how to configure forms that allow scrolling, see [scrolling screen for forms](/power-apps/maker/canvas-apps/add-scrolling-screen#scrolling-screen-for-forms).

1. **Camera images when imported via Microsoft Edge are flipped** (January 20, 2020)

    When using the camera and the legacy Microsoft Edge browser, the image may be flipped. This is due to legacy Microsoft Edge browser defect. To mitigate this issue, use the new Microsoft Edge or a different browser.

1. **Camera images do not contain meta-data information** (January 20, 2020)

    When using the camera control, the image does not contain meta-data information. This is due to a limitation of how we take images with the camera. To mitigate this issue, use the [Add picture control](/power-apps/maker/canvas-apps/controls/control-add-picture).

1. **Images added from iOS do not contain meta-data information** (January 20, 2020)

    When using the Add Picture control on iOS, images imported by using the camera or gallery do not contain meta-data.

1. **Scrolling in flexible-height galleries** (Nov. 27, 2018)

    If you run into a limitation when you scroll with your finger, lift it and start to scroll again.

1. **Combo box controls in galleries** (May 3, 2018)

    When you use a **Combo box** control inside a gallery, its selections are not maintained when the user scrolls the gallery. This is not an issue if you use a **Combo box** control inside a gallery that doesn't scroll. A workaround is not currently available.

1. **Data Table control**

    If you copy and paste a **Data Table** control for which the **Items** property is set to a formula that contains a **Filter** function, the formula for the **Items** property on the new **Data Table** control ends up with field names that contain a **_1** suffix. This makes the field names invalid and results in no data showing up in the data table. To work around this issue, before you copy the control, confirm that the **Filter** function doesn't reference any field in the data source that has the same name as a column in the **Data Table** control. If it does, rename the column in the **Data Table** control. Alternatively, remove the **_1** suffix from the invalid field names so they match the names in the table.

1. **"Empty" gallery when opening an app**

    If you generate an app automatically from data, save the app, and then reopen it, the browse gallery might not immediately show any data. To resolve this issue, type at least one character in the search box, and then delete the text that you typed. The gallery will then show data as expected.

1. **Scanning a barcode**

    For more information about limitations and best practices when you use a **Barcode** control, see [Barcode scanner control in Power Apps](/power-apps/maker/canvas-apps/controls/control-new-barcode-scanner).

1. **Camera usage may be temporarily disabled if memory is low**.

     If your mobile device is low on memory, the camera is temporarily disabled to avoid crashing the device.

1. **Camera issue on Android mobile devices** (January 1, 2019)

    If the camera control stops working on an Android device, republish your app, and reopen it on the device. The camera control was updated in response to a change in the Android operating system, and your app will benefit from the update when you republish.

1. **Multiple media controls in Power Apps Mobile** (August 2, 2018)

    Power Apps Mobile runs on various types of devices, and some of them have limitations that are specific to that platform:

    * You can play videos in multiple **Video** controls at the same time on all platforms except for iPhone devices.
    * You can record audio with multiple **Microphone** controls at the same time on all platforms except for the web player.

1. **Drawing with mouse or touch input is not smooth in Power Apps for Windows** (September 24, 2018)

    The pen control only has partial support for drawing using mouse or touch input in the Windows app. Strokes might be intermittent. For smooth drawing, use a pen or run the app in a browser.

1. **Camera controls in Power Apps for Windows app**

   Power Apps for Windows app may crash if you open an app that uses a camera control. To avoid this problem, use the web player on the Windows platform. Also, multiple cameras aren't supported.

   1. **Camera control on a Windows Phone**

    An app that contains a camera control might crash if you open the app on a Windows Phone that's running build 10.0.10586.107. To avoid this problem, upgrade to the most recent build (for example, by running the [Upgrade Advisor](https://www.microsoft.com/store/p/upgrade-advisor/9nblggh0f5g4).

### Integration

1. **Power Apps Studio is not accessible from Power BI Desktop versions 2.102.845.0 and earlier** (April 11, 2022)

    Power Apps Studio will not load from Power BI Desktop on versions 2.102.845.0 and earlier anymore. Update your Power BI Desktop to version 2.103.881.0 or later, or access Power App Studio in Power BI from a browser instead.

### Power Fx

1. **`Connection.Connected` returns the wrong value during OnStart in Power Apps for Windows** (July 21, 2020)

   While offline, formula `Connection.Connected` may wrongly return **true** immediately after starting an app in the Windows app. As a workaround, delay when the logic depending on it is executed by using a **Timer** control.

1. **Issues with Date-time**

    See the [Trouble shooting Canvas app date time issues](troubleshoot-canvas-app-date-time-issues.md) article for details on Power Fx and date/time.  Similarly see [Trouble shooting Model driven app date time issues](troubleshoot-model-driven-app-date-time-issues.md)

### Region

1. **Performance degradation when opening Power Apps Studio in China** (March 25, 2022)

    Power Apps Studio may take more than 30 seconds when loading in China. This issue does not impact tenants hosted locally by 21Vianet.

### Studio and Forms

The Power Apps Studio is home to the app editing and publishing experience.  

1. **Problems with startup**
    If you're having trouble accessing or starting Power Apps, see [troubleshooting startup issues](troubleshooting-startup-issues.md).

1. **Problems with canvas app screen sizes** (April 27, 2021)

   Starting with Power Apps 3.21032, screens in some apps may be displaying unexpected dimensions or are not visible entirely. Check the affected screens' Height and Width properties and make sure they are set to an appropriate value, such as the default (`Max(App.Height, App.MinScreenHeight)` for Height, `Max(App.Width, App.MinScreenWidth)` for Width). A fix has already been deployed for screens that have a blank Height or Width. If you're still experiencing issues with the size of screens or the controls on them, the app may have been saved or auto-saved into the error state. Such apps can be restored to an earlier version via the portal, and the deployed fix will be applied the next time the app is opened for editing.

1. **Problems changing dimensions/orientation of SharePoint forms** (April 27, 2021)

   We are aware of issues affecting the "Screen size + orientation" settings for custom SharePoint forms. If you're having trouble with these settings, you can use the "Custom" size to work around the issue. First, reset the setting by selecting "Small" size, then toggle Orientation to Portrait and then back to Landscape. Then select "Custom" and enter a desired screen size. For reference, the preset values are Width: 270, Height: 480 for the Small Portrait size, and Width: 720, Height: 480 for Small Landscape size.

1. **Copying and pasting screens across apps** (April 4, 2018)

    Copying and pasting screens across apps is not currently supported. To work around this issue, add a new screen to your target app, copy the controls from the screen in your source app, and then paste them into the screen of your target app.

1. **Changing the layout of SharePoint forms** (March 7, 2018)

    While customizing a SharePoint forms in certain languages, if you try to change the layout from portrait (default) to landscape, the app may show multiple errors (yellow triangles in controls). To resolve these errors and retain the landscape layout, select **Undo**.

1. **Changing a flow in a shared app**

    If you add a flow to an app, share it, and then add a service or change a connection in the flow, you must remove the flow from the shared app, readd the flow, and reshare the app. Otherwise, users who trigger the flow will get an authentication failure.

1. **Changing a Title field in a table**

    If you change the **Title** field for a table that other tables reference through one or more lookups, an error will occur when you try to save the change. To work around this issue, remove any lookups to the table for which you want to change the **Title** field, make the change, and then recreate the lookups. For more information about lookups, see [Create a relationship between tables](/power-apps/maker/data-platform/data-platform-entity-lookup).

1. **When Power Apps generates an app from data, the field used for sorting and searching isn't automatically configured**.

   To configure this field, edit the **[Items](/power-apps/maker/canvas-apps/controls/properties-core)** formula for the gallery, as the sections for filtering and sorting in [Add a gallery](/power-apps/maker/canvas-apps/add-gallery) describe.

1. **It can sometimes take a moment before a newly shared app can be used**.

     In some cases, a newly shared app won't be immediately available. Wait a few moments, and it should become available.

1. **In the [Form control](/power-apps/maker/canvas-apps/controls/control-form-detail), you can't change data by using a custom card**.

     The stock custom card is missing the **[Update](/power-apps/maker/canvas-apps/controls/control-card)** property, which is required to write back changes. To work around this:

* Select the form control, and insert a card by using the right-hand pane based on the field that you want the card to show.
* Unlock the card, as described in [Understanding data cards](/power-apps/maker/canvas-apps/working-with-cards#unlock-a-card).
* Remove or rearrange controls within the card as you see fit, just as you would with the custom card.

1. **Card gallery is deprecated**.

     Existing apps that use this feature will continue to run for the time being, but you can't add a card gallery. Replace card galleries with the new **[Edit form](/power-apps/maker/canvas-apps/controls/control-form-detail)** and **[Display form](/power-apps/maker/canvas-apps/controls/control-form-detail)** controls.

### Browser

1. **Black box covering part of embedded canvas app** (June 11, 2020)

   When you use embedded canvas apps such as SharePoint forms, SharePoint web parts, or model driven forms, your users may see a black box when scrolling covering part of the app. This issue happens with chromium-based browsers starting with version 83. There isn't a workaround at this time. The team is actively investigating to find a fix and workaround. **A workaround in Power Apps was deployed in the week of 6/21/2020. In addition, the issue is fixed for Microsoft Edge based on Chromium version 85.**

2. **Browser running out of memory** (July 23, 2018)

    If you run out of memory while using Power Apps, consider downloading a 64-bit version of Google Chrome or Microsoft Edge.

3. **Running an app on Windows 8.1**

    If you install [this update for Windows 8.1](/security-updates/SecurityBulletins/2016/ms16-118), you can't run apps that you open in Power Apps Studio on that operating system. However, you can still run apps that you open in [powerapps.com](https://make.powerapps.com?utm_source=padocs&utm_medium=linkinadoc&utm_campaign=referralsfromdoc) or using Power Apps Mobile.

### Power Apps for Windows

1. **Power Apps mobile app for Windows platform doesn't support Dropbox connector.** (December 15, 2020)

   A pop-up dialog shows the following message in this situation:

   ` We can't connect to the service you need right now. Check your network connection or try again later `

   When this issue happens, consider using web player on Windows platform.

1. **Microsoft Entra Conditional Access with the policy "Require device to be marked as compliant" does not work in Power Apps for Windows** (July 30, 2020)

   When setting the conditional access policy "Require device to be marked as compliant" in Microsoft Entra ID, users will face login errors.  They will seethe message "The application contains sensitive information and can only be accessed from devices or client applications that meet your enterprise management compliance policy." Consequently, they won't be able to access their Power Apps. As a workaround, use your browser.

## Next steps

If your issue isn't listed in this article, you can [search for more support resources](https://powerapps.microsoft.com/support), or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support). For more information, [Get Help + Support](/power-platform/admin/get-help-support).
