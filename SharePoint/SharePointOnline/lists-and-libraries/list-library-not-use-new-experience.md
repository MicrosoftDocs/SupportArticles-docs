---
title: SharePoint Online list or library doesn't use the new experience
description: This article describes an issue where SharePoint Online list or library doesn't use the new experience as expected, and provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# SharePoint Online list or library doesn't use the new experience as expected

## Problem

Consider the following scenario:

1. You have a SharePoint Online list or library, and the List experience option is set to one of the following:

    - **New experience**
    - **Default experience set by my administrator**

    > [!NOTE]
    > In this scenario, the administrator has set the **SharePoint Lists and Libraries experience** setting in the SharePoint admin center to **New experience (auto detect)**.

1. There are no visible customizations on the page for the document library.

When you browse to the document library page in this scenario, the page uses the classic experience and not the new experience.

## Solution

To resolve this issue, remove any hidden web parts from the affected document library page. To do this, follow these steps:

1. Browse to the affected document library page.

1. In your browser's address bar, delete everything in the URL after **.aspx**. Then, add ?=contents=1 to the end of the URL and press Enter.

1. A list or document library hidden web part will be displayed as **XsltListViewWebPart**. Locate any web part that isn't for the list or document library. Select the web part, and then press Delete.

1. Browse back to the document library page, and then view the new experience.

## More information

This is a known issue in SharePoint Online that occurs when there are hidden web parts other than XsltListViewWebPart on the page.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
