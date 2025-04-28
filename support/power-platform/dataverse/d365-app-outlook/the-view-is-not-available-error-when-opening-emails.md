---
title: The view is not available error when opening an email
description: The view is not available error occurs when you try to open an email in Microsoft Dynamics 365 App for Outlook. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Dynamics 365 App for Outlook Add-In
---
# The view is not available error when opening an email in Microsoft Dynamics 365 App for Outlook

This article provides a resolution to solve the **The view is not available** error that occurs when you try to open an email in Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Dynamics 365 App for Outlook  
_Original KB number:_ &nbsp; 4338690

## Symptoms

When opening an email in the Microsoft Dynamics 365 App for Outlook, you see the following error:

> "The view is not available. Please contact your system administrator."

## Cause

This error can appear if you deactivated one of the views used by the Microsoft Dynamics 365 App for Outlook. The Microsoft Dynamics 365 App for Outlook uses a special form to display Lead (App for Outlook Lead Quick View) or Contact (App for Outlook Contact Quick View) information. Each of these forms includes lists that reference specific views. If one of these views is deactivated, you may see a **view is not available** error.

## Resolution

Make sure the views used by the App for Outlook Lead Quick View form and App for Outlook Contact Quick View form are not deactivated. When you are viewing an email in the Microsoft Dynamics 365 App for Outlook, the form used depends on if the email is from a Lead or a Contact. If you are only seeing this error when an email is from a Contact, you may only need to fix the views used by the contact form. If you only see the error when the email is from a Lead, you may only need to fix the views used by the lead form. In the example below, we will verify the default views used by the App for Outlook Contact Quick View form are activated. You can use similar steps for the App for Outlook Lead Quick View form that is found under the Lead entity instead of the Contact entity:

1. As a user with the System Administrator or System Customizer security role, open the Microsoft Dynamics 365 web application.
2. Navigate to **Settings** and then select **Customizations**.
3. Select **Customize the System**. This will open the **Default Solution** dialog.
4. Select **Entities**, select **Contact**, and then select **Forms**.
5. Open the **App for Outlook Contact Quick View** form. By default this form includes two lists for activities, a list for opportunities, and a list for cases. The tables below shows the default names of the lists as well as the default view used for the list.
6. You can use these tables as a reference for reactivating the default view.
7. In this example, we will look at the first two lists that are from the Activity entity. You can repeat the same steps for the other mentioned entities.
8. Switch back to the **Default Solution** dialog, select **Activity**, and then select **Views**.
9. Select the **View** dropdown list and select **Inactive Public Views**.
10. Verify the Next Activity and Last Activity views do not appear in the Inactive Public Views list. If any of these views are deactivated, select them and then select **Activate**.
11. After using the same steps to verify the other views are active, select **Publish All Customizations**.
12. You may need to close and reopen Outlook and possibly clear your browser cache.

### App for Outlook Contact Quick View

|List Name| Default View| Entity |
|---|---|---|
| Next Activity| Next Activity|Activity|
| Last Activity| Last Activity|Activity|
| Recent Opportunities| Recent Opportunities for Interaction Centric Form|Opportunity|
| Recent Cases|My Active Cases|Case|

### App for Outlook Lead Quick View form

|List Name|Default View|Entity|
|---|---|---|
| Next Activity| Next Activity|Activity|
| Last Activity| Last Activity|Activity|
| Stakeholders| All Stakeholders|Connection|
| Competitors|All Competitors (summary)|Competitor|

> [!NOTE]
> If you want to change which views are used by these forms instead of activating the default views, you can open the properties of the list section on the form to change the selected view. If you have deactivated one of the default views, you won't actually be able to see it referenced by the list even though it is currently still referencing that default view. Instead it will show some other view name that is active. You may need to first change it to another view and then change it to the view you want selected for the change to take effect.
>
> Microsoft is aware of an issue where you may encounter an error trying to change the views. You can change the Next Activity and Last Activity Views but when trying to change the other views, you encounter an error (**An error has occurred. Please return to the home page and try again**). Microsoft is investigating a protection solution to this issue.
