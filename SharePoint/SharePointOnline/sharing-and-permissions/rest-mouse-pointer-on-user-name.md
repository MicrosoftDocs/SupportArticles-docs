---
title: Credential prompt after you rest the mouse pointer over the name of a user
description: This article describes an issue where Credential prompt after you rest the mouse pointer over the name of a user in SharePoint Online or OneDrive for Business, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - OneDrive for Business
ms.date: 12/17/2023
---

# Credential prompt after you rest the mouse pointer over the name of a user in SharePoint Online

## Problem

Consider the following scenario:

- You're using Microsoft Office 2016 Click-to-Run.

- You're using a Microsoft 365 Exchange Online mailbox, with Modern Authentication enabled.

In this scenario, you may be prompted for credentials intermittently and multiple times in SharePoint Online. This behavior may start to occur when you browse to a SharePoint Online or OneDrive for Business library, and you rest the mouse pointer on the name of a user (such as the **Modified By** user).

## Solution/Workaround

To work around this issue, disable the **NameCtrl Class** add-on in Internet Explorer. To do this, following these steps:

1. Open Internet Explorer, click the **Settings** icon, and then click **Manage add-ons**.

1. Under **Add-on Types**, select **Toolbars and Extensions**.

1. Under **Show**, select **All add-ons**.

1. Under the **Microsoft Corporation** section, select the **NameCtrl Class** add-on, and then click **Disable**.

1. Click **Close**.

## More information

Microsoft Office Contact Retriever tries to retrieve the contact when you rest the mouse pointer on the name of a user in SharePoint Online or OneDrive for Business. However, the Microsoft Office Contact Retriever doesn't support Modern Authentication.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
