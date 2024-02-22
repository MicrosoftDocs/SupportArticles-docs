---
title: Sites.aspx page with My Task Web Part doesn't display content
description: This article describes an issue where sites.aspx page doesn't display content after you add the My Tasks Web Part, and provides a solution.
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
ms.date: 12/17/2023
---

# The SharePoint Online Sites.aspx page doesn't display content after you add the "My Tasks" Web Part

## Problem

Consider the following scenario:

- You browse to the Sites.aspx page in Microsoft SharePoint Online by clicking **Sites** in the Microsoft 365 admin center.

- You click your profile picture and then click **Personalize this Page**.

- You click **Add a Web Part**, select **My Tasks**, and then click **Add**. (After the Web Part is added to the page, you don't have the option to save your changes.)

- You browse to the Sites.aspx page.

In this scenario, the page doesn't display content.

## Solution

To resolve the issue, remove the **My Tasks** Web Part from the page. To do this, follow these steps:

1. Browse to the Sites.aspx page to which you added the **My Tasks** Web Part.

1. Add the following string to the end of the URL:

   **?contents=1**

1. Click to select the check box next to **My Tasks**, and then click **Delete**.

1. Click **OK**.

## More information

This issue occurs because editing the Sites.aspx page isn't supported.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
