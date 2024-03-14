---
title: Unable to create documents in Microsoft 365 portal
description: List '|0' does not exist at site with URL '|1' when trying to create documents in the Microsoft 365 portal.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "List '|0' does not exist at site with URL '|1'" error when you try to create documents in the Microsoft 365 portal

## Problem

When you try to create documents in the Microsoft 365 portal in Microsoft 365 Small Business, you receive the following error message:

**Error: List '|0' does not exist at site with URL '|1'**

## Solution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Method 1: Restore the Documents library from the Recycle Bin

To restore the Documents library from the Recycle Bin, follow these steps:

1. Browse to your Team Site at http://*YourDomain*.sharepoint.com/teamsite, where *YourDomain* is the domain for your organization.
1. In Quick Launch on the left side of the page, click **Recycle Bin**.
1. Locate the library named Documents, click to select the check box, and then click **Restore Selection**.
1. Return to the Microsoft 365 portal, and then create a document.

### Method 2: Create a "Documents" list on your Team Site

If you're unable to restore the Documents library from the Recycle Bin, create a "Documents" list on your Team Site. To do this, follow these steps:

1. Browse to your Team Site at http://*YourDomain*.sharepoint.com/teamsite, where *YourDomain* is the domain for your organization.
1. In Quick Launch on the left side of the page, click **All Site Content**.
1. Near the top of the page, click **Create**, and then click **Document Library** in the list that is generated.
1. In the **Document Library** box, type **Documents**, and then click **Create**.
1. Return to the Microsoft 365 portal, and then create a document.

## More information

This issue occurs because a list that is named "Documents" doesn't exist on your Microsoft SharePoint Online Team Site.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
