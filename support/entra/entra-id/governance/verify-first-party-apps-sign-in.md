---
title: Verify first-party Microsoft applications in sign-in reports
description: Describes how to verify first-party Microsoft applications in sign-in reports.
ms.date: 05/30/2025
ms.reviewer: bernaw, domooney, grtaylor, v-six, v-weizhu
ms.service: entra-id
ms.custom: sap:Sign-In Activity Reports, no-azure-ad-ps-ref
---
# Verify first-party Microsoft applications in sign-in reports

[!INCLUDE [Feedback](../../../includes/feedback.md)]

When you review your sign-in reports, you might see an application in your sign-in report that you don't own and want to identify. You also might wonder how you signed in to that app, if you don't remember accessing the app.

Here's an example sign-in report:

:::image type="content" source="media/verify-first-party-apps-sign-in/sign-in-report.png" alt-text="Screenshot of a sign-in report in Microsoft Entra ID.":::

For example, when you access `learn.microsoft.com`, the application that's shown in the sign-in log may show `dev-rel-auth-prod`, but this isn't descriptive of `learn.microsoft.com`.

Although the apps that are listed in sign-in reports are owned by Microsoft and aren't suspicious applications, you can determine whether Microsoft owns a Microsoft Entra service principal that's found in your Microsoft Entra logs.

> [!NOTE]
> First-party Microsoft applications don't always result in a service principal that's created in your tenant. In this case, you'll likely continue to see the applications in your sign-in reports.

<a name='verify-a-first-party-microsoft-service-principal-in-your-azure-ad-tenant'></a>

## Verify a first-party Microsoft service principal in your Microsoft Entra tenant

1. Open the [list of enterprise applications in Microsoft Entra ID](https://portal.azure.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/AllApps/menuId/).

2. In the navigation pane, select **All applications**.

3. In the **Application Type** drop-down list, select **Microsoft Applications**, and then select **Apply**. All applications that are listed here are owned by Microsoft.

    :::image type="content" source="media/verify-first-party-apps-sign-in/microsoft-applications-in-application-type-menu.png" alt-text="Screenshot of the Application Type drop-down menu where Microsoft Applications are selected.":::

4. In the search box below the drop-down lists, filter the Microsoft application list by adding a specific **Display Name** or **Application ID**.

    :::image type="content" source="media/verify-first-party-apps-sign-in/add-display-name-in-searchbox.png" alt-text="Screenshot of the search box where a display name is entered.":::

5. Select the desired app, and then select **Properties** in the navigation pane to view the listed app's properties. Verify that you see the following error message:

   ```output
   You can't delete this application because it's a Microsoft first party application.
   ```

    :::image type="content" source="media/verify-first-party-apps-sign-in/you-cant-delete-this-application.png" alt-text="Screenshot of the message that displays the statement you can't delete this application because it's a Microsoft first-party application.":::

## Verify a first-party Microsoft service principal through PowerShell

### Using Microsoft Graph PowerShell SDK

1. Open PowerShell, import Microsoft Graph PowerShell SDK and then connect to Microsoft Entra ID:

   ```cmd
   Import-Module Microsoft.Graph.Applications
   Connect-MgGraph
   ```

2. In the PowerShell command-line, enter the display name of the application and run the following cmdlet:

   ```cmd
   $appDisplayName = '<display name>'
   Get-MgServicePrincipal -Filter "DisplayName eq '$appDisplayName'" | Select-Object Id, DisplayName, SignInAudience, AppOwnerOrganizationId
   ```
   
3. Review the `AppOwnerTenantId` value in the output.

    :::image type="content" source="media/verify-first-party-apps-sign-in/review-the-app-owner-tenant-id-microsoft-graph.png" alt-text="Screenshot of the output of a request to show the Microsoft Entra service principal via Microsoft Graph PowerShell SDK.":::

   In the screenshot, `f8cdef31-a31e-4b4a-93e4-5f571e91255a` is the Microsoft Service's Microsoft Entra tenant ID.

### Using Microsoft Entra PowerShell

1. Open PowerShell, import Microsoft Graph PowerShell SDK and connect to Microsoft Entra ID:

   ```cmd
   Import-Module Microsoft.Entra
   Connect-Entra
   ```

2. In the PowerShell command-line, enter the display name of the application and run the following cmdlet:

   ```cmd
   $appDisplayName = '<display name>'
   Get-EntraServicePrincipal -SearchString $appDisplayName | Select-Object Id, DisplayName, SignInAudience, AppOwnerOrganizationId
   ```
   
3. Review the result's `AppOwnerTenantId`.

    :::image type="content" source="media/verify-first-party-apps-sign-in/review-the-app-owner-tenant-id-microsoft-entra.png" alt-text="Screenshot of the output of a request to show the Microsoft Entra service principal via Microsoft Entra PowerShell.":::

   In the screenshot, `f8cdef31-a31e-4b4a-93e4-5f571e91255a` is the Microsoft Service's Microsoft Entra tenant ID.

## Application IDs of Microsoft tenant-owned applications

The following table lists some, but not all, Microsoft tenant-owned applications (tenant ID: 72f988bf-86f1-41af-91ab-2d7cd011db47).

|Application Name|Application IDs|
|--|--|
|Graph Explorer|de8bc8b5-d9f9-48b1-a8ad-b748da725064|
|Microsoft Graph Command Line Tools|14d82eec-204b-4c2f-b7e8-296a70dab67e|
|OutlookUserSettingsConsumer|7ae974c5-1af7-4923-af3a-fb1fd14dcb7e|
|Vortex [wsfed enabled]|5572c4c0-d078-44ce-b81c-6cbf8d3ed39e|

## More information

For more information, see [Sign-in activity reports in the Microsoft Entra admin center](/azure/active-directory/reports-monitoring/concept-sign-ins#sign-ins-report).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
