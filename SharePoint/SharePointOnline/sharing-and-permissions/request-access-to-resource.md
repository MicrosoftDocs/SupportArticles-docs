---
title: Users without permissions to a SharePoint Online resource can't request access
description: Describes an issue in which users without permissions to a SharePoint Online resource don't receive the option to request access to the resource, and provides a solution.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sharing\Access requests
  - CSSTroubleshoot
ms.author: meerak
ms.reviewer: prbalusu, nirupme
appliesto: 
  - SharePoint Online
ms.date: 12/04/2025
---

# Users without permissions to a SharePoint Online resource can't request access

## Symptoms

When existing users in an organization try to access a SharePoint Online resource, but they don't have permissions to the resource, they receive one of the following error messages:

- Sorry, this site hasn't been shared with you.
- Error: Access Denied.
- You can't access this item.
- You don't have permission to access this item.

These error messages are expected. However, in this scenario, users don't have an option to request access to the resource. 

# Cause

The errors occur because access requests aren't enabled for the site collection that's associated with the resource.

## Resolution

To resolve the errors, enable access requests for the affected site collection. You must be a site collection administrator to enable this feature. 

As a site collection administrator, use the following steps to enable access requests:

1. On the affected SharePoint Online site collection, select **Settings** > **Site Settings**.

1. On the **Site Settings** page, under **Users and Permissions**, select **Site permissions**.

1. Select **Access Request Settings**.

1. Select the **Allow Access Requests** check box.

1. In the **Send all requests for access to the following email address**, enter the email address of the user acount that approves access requests, and then select **OK**.

Now users who don't have permission to a SharePoint Online resource are directed to a page where they can request access. Requests for access are sent to the email address that's specified in step 5.
