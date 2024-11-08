---
title: User without permission to resource can't receive the option to request access
description: This article describes an issue that users without permissions to a SharePoint Online resource don't receive the option to request access to the resource, and provides a solution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sharing\Access requests
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Users without permissions to a SharePoint Online resource don't receive the option to request access to the resource

## Problem

When an existing user in an organization tries to access a SharePoint Online resource in Microsoft 365 for enterprises and the user doesn't have permission to the resource, they receive one of the following error messages:

- **Sorry, this site hasn't been shared with you.**
- **Error: Access Denied**

This message is expected. However, in this scenario, users don't have an option to request access to the resource and you want users who receive the message to have an option to request access.

## Solution

This occurs if access requests aren't enabled for the affected site collection. If this feature is turned off, it must enabled by site collection admins.

To fix this issue, enable the access requests for the site collection. To do this, follow these steps:

1. On the affected SharePoint Online site collection, click the gear icon for the **Settings** menu, and then click **Site Settings**.

1. On the **Site Settings** page, under **Users and Permissions**, select **Site permissions**.

1. Select **Access Request Settings**.

1. Click to select the **Allow Access Requests** check box.

1. In the **Send all requests for access to the following email address**, type your email address, and then click **OK**.

After you follow these steps, users who don't have permission to a SharePoint Online resource are directed to a page where they can request access. Requests for access are sent to the email address that you specified in step 5.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
