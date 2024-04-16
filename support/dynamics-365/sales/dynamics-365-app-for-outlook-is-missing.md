---
title: Dynamics 365 App for Outlook is missing
description: Provides a solution to an issue where Microsoft Dynamics 365 App for Outlook is missing from Microsoft Dynamics 365 navigation.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Microsoft Dynamics 365 App for Outlook is missing from Microsoft Dynamics 365 navigation

This article provides a solution to an issue where Microsoft Dynamics 365 App for Outlook is missing from Microsoft Dynamics 365 navigation.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4339287

## Symptoms

You're unable to find the Dynamics 365 App for Outlook option under **Settings** in your Dynamics 365 organization.

## Cause

It can be the result of customization to your navigation menu (sitemap). A customization can be applied from a solution or an administrator could have explicitly edited the sitemap xml, or used the sitemap designer to remove it.

## Resolution

You can add the Dynamics 365 App for Outlook option under **Settings** by editing the sitemap within the sitemap designer:

1. Access your Dynamics 365 organization as a user with the System Administrator or System Customer role.
2. Navigate to **Settings**, **Customization**, and then select **Customize the System.**  
3. Select **Client Extensions**, select **Sitemap**, and then select **Edit**.
4. Select the **Settings** area.
5. Select the **System** group.
6. Select **+ Add** and then select **Subarea**.
7. Select the **Type** dropdown and select **URL**.
8. Copy and paste the following value into the **URL** field:  
    `/tools/appsforcrm/AppForOutlookAdminSettings.aspx`
9. In the **Title** field, type **Dynamics 365 App for Outlook**.
10. For the **Icon** option, select the following option if it's available or select the default icon or any other icon:  
    `/_imgs/area/crm_apps_16x16.png`
11. Use the following value for the **ID** value: **crmapp_outlook**
12. Select **Save** and then select **Publish.**  
13. Close the sitemap designer
14. Within the **Solution** dialog, select **Publish All Customizations**.
15. Sign out and log back into the organization.

## More information

To directly access the Dynamics 365 App for Outlook page used for deploying the app, append the following text to your Dynamics 365 URL:  
`/tools/appsforcrm/AppForOutlookAdminSettings.aspx`

For example:  
`https://contoso.crm.dynamics.com/tools/appsforcrm/AppForOutlookAdminSettings.aspx`
