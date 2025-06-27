---
title: Can't access a shared SharePoint app item by using a guest link
description: You can't click a guest link to a SharePoint Online app item when you publish the app to a SharePoint app catalog.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:App Bar and Navigation\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "Couldn't connect to the catalog server for this app" error when you click a guest link to a SharePoint Online item

## Problem

Consider the following scenario:

- You publish an app to a Microsoft SharePoint app catalog.
- An item (such as an Excel worksheet) that uses the app is shared to guest users by its URL.
- When you configured sharing, you cleared the **Require sign-in** check box.
- The recipient of the shared item clicks the guest link to open the shared resource.

In this scenario, the user receives the following error message:

**App Error We couldn't connect to the catalog server for this app.**

## Solution

To work around this issue, publish your app to the Office Store. Or, provide an account in the organization through which the user can access the content.

## More information

This error occurs because the guest user has access to the content that uses the app, but doesn't have access to the app catalog.

For more information about apps for Office and SharePoint, go to the [Getting Started with Office Development](https://developer.microsoft.com/office/docs).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
