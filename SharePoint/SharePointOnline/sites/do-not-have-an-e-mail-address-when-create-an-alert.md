---
title: You do not have an e-mail address when you create an alert in SharePoint Online
description: Describes an issue in which you receive You do not have an e-mail address error when you create an alert in SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "You do not have an e-mail address" error when you create an alert in SharePoint Online

## Problem

When you create an alert in a SharePoint Online list or library, you receive the following error message:

**Sorry, something went wrong**

**You do not have an e-mail address.**

**Alert has been created successfully but you will not receive notifications until valid e-mail or mobile address has been provided in your profile.**

## Solution

To resolve this issue, configure SharePoint Online to enable users to configure their email address within their My Site profile and configure the changes to replicate to the sites. As a Global Administrator for the Microsoft 365 service, follow these steps:

1. Browse to the Microsoft 365 portal at https://portal.office.com.

2. Click the Admin link at the top of the window, and then **SharePoint**.

3. In the SharePoint admin center, click **user profiles**.

4. Under the **People** section, click **Manage User Properties**.

5. Locate the **Work email** property name and rest the mouse pointer over the property.

6. Click the drop-down arrow, and then click **Edit**.

7. In the **Edit Settings** section, select the option next to the **Allow users to edit values for this property** setting.

8. In the **Policy Settings** section, click the check box next to **Replicable**.

   > [!NOTE]
   > The Replicable setting is necessary to make sure that the properties are propagated to all site collections within the organization.

9. Scroll to the bottom of the page, and then click **OK**.

Users can now edit their My Site profile to configure the **Work email** field as needed. This is the address where SharePoint alerts will be sent for the user.

## More information

This error occurs because there's no email address associated with the SharePoint Online user profile. This error occurs most frequently when the user doesn't have a Exchange Online license assigned to their account.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
