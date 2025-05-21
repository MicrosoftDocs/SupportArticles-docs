---
title: Dynamics 365 App for Outlook option is missing from navigation
description: Solves an issue where Microsoft Dynamics 365 App for Outlook is missing from the Dynamics 365 navigation pane.
ms.reviewer: 
ms.date: 03/06/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# Dynamics 365 App for Outlook is missing from the navigation pane

This article provides a solution to an issue where Microsoft Dynamics 365 App for Outlook is missing from the Dynamics 365 navigation pane.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4339287

## Symptoms

You can't find the **Dynamics 365 App for Outlook** option under **Settings** in your Dynamics 365 organization.

## Cause

This issue might be due to customization of the navigation menu (site map). The customization could've been applied from a solution, or an administrator could have explicitly edited the site map XML or used the site map designer to remove the option.

## Resolution

You can add the **Dynamics 365 App for Outlook** option to **Settings** by editing the site map within the [site map designer](/dynamics365/customerengagement/on-premises/customize/create-site-map-app):

1. Access your Dynamics 365 organization as a user with the System Administrator or System Customer role.
2. Navigate to **Settings** > **Customization**, and then select **Customize the System**.
3. In the solution window, under **Components**, select **Client Extensions** > **Sitemap**, and then select **Edit**.
4. Select the **Settings** area and then select the **System** group.
5. Select **+ Add** and then select **Subarea**.
6. Select the **Type** dropdown and select **URL**.
7. Copy and paste the following value into the **URL** field:

    **/tools/appsforcrm/AppForOutlookAdminSettings.aspx**

8. In the **Title** field, type **Dynamics 365 App for Outlook**.

9. For the **Icon** field, select the following option if it's available or select the default icon or any other icon:

    **/_imgs/area/crm_apps_16x16.png**

10. Enter the **crmapp_outlook** value in the **ID** field.
11. Select **Save** > **Publish**.
12. Close the site map designer.
13. Within the **Solution** dialog, select **Publish All Customizations**.
14. Sign out and sign back in to the organization.

## More information

- [Deploy and install Dynamics 365 App for Outlook](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook)
- To directly access the Dynamics 365 App for Outlook page used for deploying the app, append the following text to your Dynamics 365 URL:

  `/tools/appsforcrm/AppForOutlookAdminSettings.aspx`

  For example:

  `https://contoso.crm.dynamics.com/tools/appsforcrm/AppForOutlookAdminSettings.aspx`
