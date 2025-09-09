---
title: The SharePoint Online Modern admin center does not display (Advanced) and (API access)
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:SharePoint Admin Center\API Access
  - CI 124612
  - CSSTroubleshoot
ms.reviewer: najagdis
description: How to resolve an issue where API access and the Advanced tab don't appear in the Modern admin center.
---

# (Advanced) and (API access) do not appear in the SharePoint Online Modern admin center

## Symptoms

The **Advanced** and **API Access** options don't appear in the navigation pane of the SharePoint Online Modern admin center. 

:::image type="content" source="media/api-access-does-not-appear/advanced-api-access-options.png" alt-text="Screenshot of SharePoint admin center showing Advanced and API Access options." border="false":::

## Cause

These options may not be available if an app catalog site isn't created or is incorrectly registered on the tenant.

## Resolution

To resolve this issue, follow these steps:
1.	Go to the admin center, and select **More features**.
2.	Under **Apps**, select **Open**. 

    :::image type="content" source="media/api-access-does-not-appear/open-apps.png" alt-text="Screenshot of SharePoint admin center. Select More features and select Open under Apps.":::
3.	Select **App Catalog**, and then select **Create a new app catalog site**. Enter the necessary information, including title, URL, and administrator, as appropriate.

    :::image type="content" source="media/api-access-does-not-appear/create-new-app-catalog-site.png" alt-text="Screenshot of App Catalog Site, with the Create a new app catalog field selected.":::

    > [!note]
    > If you have already created an app catalog site, proceed to step 7. 
4.	Copy the URL of the app catalog site, and save it to a separate location (such as Notepad, a Word doc, or another program). 
5.	Wait for the site to finish provisioning.
Note: This process may take up to 10 minutes.
6.	After the site is provisioned, return to the Apps page, and then select **App Catalog**.
7.	Select **Enter a URL for an existing app catalog site**, and paste the URL of the app catalog site that you just created.

    > [!note]
    > The site may take up to 20 minutes to complete the registration process.

After the site is registered as an app catalog, return to the SharePoint Modern admin center. You can now see both the **Advanced** and  **API access** options.

## More information

For more information about the app catalog feature, see the following articles:

- [Use the App Catalog to make custom business apps available for your SharePoint environment](/sharepoint/use-app-catalog)
- [Manage access to Microsoft Entra ID-secured APIs](/sharepoint/api-access)


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
