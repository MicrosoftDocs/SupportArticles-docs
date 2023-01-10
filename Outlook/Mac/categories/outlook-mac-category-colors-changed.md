---
title: Category colors are changed after you migrate from Outlook for Mac 2011 to Outlook 2016 for Mac
description: Describes an issue in which category colors changed after you migrate to Outlook 2016 for Mac from Outlook for Mac 2011.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
search.appverid: MET150
ms.date: 3/31/2022
---
# Category colors are different after you migrate from Outlook for Mac 2011 to Outlook 2016 for Mac

_Original KB number:_ &nbsp;3009176

## Symptoms

After you migrate to Microsoft Outlook 2016 for Mac from Outlook for Mac 2011, you notice that the category colors that are assigned to your categories are changed.

## Cause

Outlook for Mac 2011 uses a local list of categories. The names of these categories are synchronized to the server that's running Microsoft Exchange Server when they're assigned to items. This makes the names visible on different clients and devices. However, the colors for these categories aren't synchronized to Exchange.

Outlook 2016 for Mac uses the Master Category List (MCL) that's stored on the Exchange server to synchronize the category names and colors.

So when you migrate from Outlook for Mac 2011 to Outlook 2016 for Mac, any local category names that are assigned to items are merged with the MCL. Random colors are assigned to these categories because the colors from Outlook for Mac 2011 aren't synchronized.

## Resolution

Update the colors that are assigned to categories in the MCL in Outlook 2016 for Mac. To do this, follow these steps:

1. On the **Home** ribbon, click **Categorize** > **Edit Categories**.
2. If you have more than one account that's added to Outlook 2016 for Mac, make sure that the correct Exchange account is selected.
3. For each category for which you want to change the color, click the color block, and then select the color that you want.
4. Make any additional changes that you want by changing the names of categories and by adding or removing categories, as appropriate.
5. Close the Categories window.

The changes that you make should be saved in the MCL and should be viewable from other clients and devices.

## More information

In Outlook for Mac 2011, thousands of colors can be assigned to local categories. In Outlook 2016 for Mac, 25 predefined colors can be assigned to MCL categories. These colors are predefined by the Exchange server MCL.

If you have an IMAP or POP account that's set up in Outlook 2016 for Mac, local categories are used. So you can select from thousands of colors for these categories.
