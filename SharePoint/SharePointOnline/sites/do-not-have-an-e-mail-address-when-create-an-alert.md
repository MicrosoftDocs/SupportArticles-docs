---
title: Error when you create an alert in SharePoint Online
description: Describes an issue in which you receive an error when you create an alert in SharePoint Online.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Lists and Libraries\Alerts
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 08/13/2024
---

# Error when you create an alert in SharePoint Online

## Symptoms

When you create an alert in a SharePoint Online list or library, you receive the following error message:

> Sorry, something went wrong. You do not have an e-mail address.
> Alert has been created successfully but you will not receive notifications until valid e-mail or mobile address has been provided in your profile.

## Cause

This error occurs because there's no email address associated with the SharePoint Online user profile. The error occurs most frequently when the user doesn't have an Exchange Online license assigned to their account.

## Resolution

To resolve this issue, configure SharePoint Online to enable users to configure their email address within their My Site profile and replicate the changes to the sites. As a SharePoint administrator, follow these steps:

1. Browse to the Microsoft 365 portal at https://portal.office.com.

2. Select the **Admin** link at the top of the window, and then select **SharePoint**.

3. In the SharePoint admin center, select **User profiles**.

4. In the **People** section, select **Manage User Properties**.

5. Locate the **Work email** property name and rest the mouse pointer over the property.

6. Select the drop-down arrow, and then select **Edit**.

7. In the **Edit Settings** section, select the option next to the **Allow users to edit values for this property** setting.

8. In the **Policy Settings** section, select the check box next to **Replicable**.

   > [!NOTE]
   > The Replicable setting is necessary to make sure that the properties are propagated to all site collections within the organization.

9. Scroll to the bottom of the page, and then select **OK**.

Users can now edit their My Site profile to configure the **Work email** field as needed. SharePoint alerts for the user are sent to the address in this field.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
