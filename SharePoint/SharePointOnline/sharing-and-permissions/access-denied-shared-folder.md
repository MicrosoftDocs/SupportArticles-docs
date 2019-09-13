---
title: Can't access a shared folder
description: This article describes Access Denied or Sorry, you don't have access to this page error that occurs when users access a shared folder, and provides a solution.
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

# "Access Denied" or "Sorry, you don't have access to this page" when users access a shared folder

## Problem

Consider the following scenario:

- You have a SharePoint Online site that's using the **Team Site** template.

- In the Team Site, you have a Document Library. The **Versioning Settings** options under **Library Settings** are configured as follows:

    - **Content Approval** is set to **Yes**.
    
    - **Document Version History** is set to **Create major and minor (draft) versions**.

- The SharePoint Server Publishing Infrastructure feature is set to **Active** for the affected site collection.

- A user is granted permissions to access a folder in the library.

When the user browses to the folder that they were granted access to, they receive one of the following error messages and then can't access the folder:

- **Access Denied**

- **Sorry, you don't have access to this page.**

## Solution

To work around this issue, do one of the following, as appropriate for your situation:

- Grant access to the whole Document Library instead of to just the folder. Or, use a different Document Library instead of a folder.

- Set **Content Approval** to **No**. 

- Set **Document Version History** to something other than **Create major and minor (draft) versions**. 

## More information

This behavior is by design. This issue occurs because publishing sites require users to have access to the site by using the **Open** permission level.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
