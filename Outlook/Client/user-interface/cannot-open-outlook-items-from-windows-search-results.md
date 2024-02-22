---
title: Can't open Outlook items from Windows Search results
description: Fixes an issue in which you can't open Outlook items from Windows Search results after installing Lync 2013.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, aruiz
appliesto: 
  - Microsoft Outlook 2010
  - Microsoft Lync 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# Unable to open Outlook items from Windows Search results after installing Lync 2013

_Original KB number:_ &nbsp; 2823902

## Symptoms

When you use Microsoft Outlook 2010 and Windows Desktop Search (WDS) is configured to index Outlook data, the search results include Outlook items such as email, contacts, and so on.

However, after you install Lync 2013, you are no longer able to open the Outlook 2010 items that are listed in the Windows Search results. Additionally, you may notice that the Outlook items that are listed in the Windows Search results are displayed with the new Outlook 2013 icon.

## Cause

By default, Outlook 2013 data is not displayed in Windows Search results. Although you don't have Outlook 2013 installed, having Lync 2013 installed in a mixed environment that has Outlook 2010 results in unexpected behavior. Outlook 2010 items are displayed in the Windows Search results. However, you cannot open them.

## Workaround

To work around this issue, use one of the following methods:

- After you install Lync 2013, repair Office 2010. An administrator can automate this process so that Office 2010 is repaired silently.
- Upgrade Outlook 2010 to Outlook 2013. With Outlook 2013 installed, Windows Search results don't include Outlook items. This avoids giving the impression that they can be opened.
