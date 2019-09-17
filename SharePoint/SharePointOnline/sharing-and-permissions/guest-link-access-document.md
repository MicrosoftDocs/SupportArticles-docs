---
title: Sorry, you cannot access this document error 
description: This article describes an issue where Sorry, you cannot access this document error when a guest link is used to access a SharePoint Online document, and provides solutions.
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

# "Sorry, you cannot access this document" when a guest link is used to access a document

## Problem

Consider the following scenario:

- In a Microsoft SharePoint Online library, you click **Library Settings** and then click **Versioning settings**.

- For the **Document Version History** setting, you select **Create major and minor (draft) versions**.

- For the **Draft Item Security** setting, you select **Only users who can edit items**.

- You click **SHARE**, click **Get a link** for a document in the library, and then click **View link - no sign-in required**.

- You share the link with a user, and the user browses to the URL for the shared document.

In this scenario, the user receives the following message: 

```adoc
Sorry, something went wrong

Sorry, you cannot access this document. Please contact the person who shared it with you.
```

## Solution

To work around this issue, take one of the following actions:

- Publish the affected document.

- Change the **Draft Item Security** setting to **Any user who can read items** for the affected library.

For more information about versioning and versioning settings, go to [Enable and configure versioning for a list or library](https://support.office.com/article/enable-and-configure-versioning-for-a-list-or-library-1555d642-23ee-446a-990a-bcab618c7a37?ocmsassetID=HA102772148&CorrelationId=73c0dfe2-5433-4c0d-bf42-566930455059).

## More information

This issue occurs when you provide read access to a document that uses draft item security. With this kind of security, only users who have edit abilities can access the document.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
