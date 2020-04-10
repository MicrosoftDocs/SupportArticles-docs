---
title: Search doesn't provide results from another language
description: This article describes an issue where Search doesn't provide results from another language in SharePoint Online or OneDrive for Business, and provides solutions.
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
- OneDrive for Business
---

# Search doesn't provide results from another language in SharePoint Online or OneDrive for Business

## Problem

Consider the following scenario.

- In SharePoint Online or OneDrive for Business, you have files, folders, or items that contain characters such as an accent mark in a language other than the language that the search was performed in.

- You perform a search, and the item that contains the special character isn't returned in the results.

> [!NOTE]
> This problem occurs most frequently in a multilanguage environment.

## Solution

To resolve this issue, specify your **Language and Region** settings, and then select the affected language during a search query. To do this, follow these steps:

1. Browse to a SharePoint Online site.

1. Click your profile image in the upper-right corner of the page, and then click **About me**.

1. Click **Edit Profile**.

1. Click the ellipsis (…), and then click **Language and Region**.

1. In the **Language Preferences** section, select and add more languages where the characters exist, as needed.

    For more information about this setting, go to [Change your language and region settings](https://support.office.com/article/change-your-language-and-region-settings-caa1fccc-bcdb-42f3-9e5b-45957647ffd7).
    
    The language that you specify as the first language will be the default language that's used for search queries. Depending on your site collection settings, it may also change the language in which the site collection is displayed.

1. After you make this change, you'll be able to select additional languages in search. On the search page, click the drop-down arrow for **Preference for results in**, and then select the language for your specific scenario.

## More information

This issue occurs because in a multilanguage environment, the normalization of some of characters or keywords for some words might differ for each language. 

For more information about the language for the site interface, see [Choose the languages you want to make available for a site's user interface](https://support.office.com/article/choose-the-languages-you-want-to-make-available-for-a-site-s-user-interface-16d3a83c-05ab-4b50-8fbb-ff576a3351e8?correlationid=397c322a-25a2-4c7a-a391-2aae4b0b4509).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
