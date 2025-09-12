---
title: My Apps area is missing
description: Provides a solution to an issue where the My Apps area is missing from Microsoft Dynamics 365 navigation.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Working with Solutions
---
# My Apps area is missing from Microsoft Dynamics 365 navigation (SiteMap)

This article provides a solution to an issue where the My Apps area is missing from Microsoft Dynamics 365 navigation.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4465235

## Symptoms

You're unable to find the **My Apps** option under **Settings** in your Dynamics 365 organization.

## Cause

It can be the result of customization to your navigation menu (sitemap). A customization can be applied from a solution or an administrator could have explicitly edited the sitemap xml, or used the sitemap designer to remove it.

## Resolution

You can add the **My Apps** option under **Settings** by editing the sitemap within the sitemap designer:

1. Access your Dynamics 365 organization as a user with the System Administrator or System Customer role.
2. Navigate to **Settings**, **Customization**, and then select **Customize the System.**  
3. Select **Client Extensions**, select **Sitemap**, and then select **Edit**.
4. Select the **Settings** area.
5. Select the **Application** group if it's available. If the Application group is missing, you can choose to create it or add this subarea to another existing group.
6. Select **+ Add** and then select **Subarea**.
7. Select the **Type** dropdown and select **URL**.
8. Copy and paste the following value into the **URL** field:  
    `/tools/AppModuleContainer/applandingtilepage.aspx`
9. In the **Title** field, type **My Apps**.
10. For the **Icon** option, select the following option if it's available or select the default icon or any other icon:  
    **AppModule_Default_Icon.png**.
11. Use the following value for the **ID** value: **nav_app_modules**
12. Select **Save** and then select **Publish**.
13. Close the sitemap designer.
14. Within the Solution dialog, select **Publish All Customizations**.
15. Sign out and log back into the organization.

## More information

To directly access the My Apps page, append the following text to your Dynamics 365 URL:  
`/apps`

For example:  
`https://contoso.crm.dynamics.com /apps`
