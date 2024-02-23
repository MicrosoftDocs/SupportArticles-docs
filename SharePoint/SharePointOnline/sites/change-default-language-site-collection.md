---
title: Can't change the default language for a site
description: This article provides a solution for an issue where you can't change the default language for a SharePoint Online site.
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

# You can't change the default language for a SharePoint Online site 

## Symptoms

You're unable to change the default language setting for a site (**Site Settings** > **Language Settings**) for one the following sites:

- My Site Host 
- OneDrive for Business personal site
- Search Center

## Cause

The default language setting cannot be changed using this method. 

## Resolution

To resolve this issue, enable the Multiple Language User Interface (MUI) for the affected site or sites. You can use the MUI feature to create sites in languages other than the default language for your SharePoint Online site or sites.

For more information about how to do this, see 
[Choose the languages for a SharePoint site user interface](https://support.office.com/article/choose-the-languages-you-want-to-make-available-for-a-site-s-user-interface-16d3a83c-05ab-4b50-8fbb-ff576a3351e8).

> [!NOTE]
> After you make this change, the UI for the affected site displays the language that you specified. However, on the OneDrive for Business personal site, the Shared with Everyone folder is not renamed. If you want this folder to use a name in the newly specified language, you must rename the folder by using the SharePoint Online UI.

## More information

This issue occurs because the default language for the My Site Host and Search Center site is defined by the following settings when you selected the link to create the subscription:

- The country/region that was selected on the office.microsoft.com page.
- The language preference that's specified by your browser settings.

For more information about multilingual features and about configuring your display language, go to the following Microsoft websites:

- [Overview of multilingual features in SharePoint](https://support.office.com/article/53411469-53e3-4570-95e2-3651f166174f)
- [Change your display language and time zone in Microsoft 365 for Business](https://support.office.com/article/6f238bff-5252-441e-b32b-655d5d85d15b)
- [Change your personal language and region settings](https://support.office.com/article/caa1fccc-bcdb-42f3-9e5b-45957647ffd7)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).