---
title: Shared With column displays users who no longer have access to a document
description: This article explains an issue where the Shared With column displays users who no longer have access to a document in SharePoint Online.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# The "Shared With" column displays users who no longer have access to a document in SharePoint Online

## Problem

Consider the following scenario.

- In a SharePoint Online library, you add the **Shared With** column to the view for the library.

- You share a document with a user or group, and the user or group is then displayed in the **Shared With** column.

- You remove the permissions for the user or group with whom you previously shared the document. However, the user or group is still displayed in the **Shared With** column.

## Solution

This behavior is by design. The **Shared With** column displays any accounts that the document was previously shared with.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
