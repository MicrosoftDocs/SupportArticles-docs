---
title: Use custom fonts with Office Online Server (OOS)
description: Describes how to use custom fonts with Microsoft Office Online Server (OOS).
author: helenclu
ms.author: luche
ms.reviewer: thempel
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Office Online Server
ms.date: 03/31/2022
---

# Use custom fonts with Office Online Server (OOS)

This article was written by [Taylor Hempel](https://social.technet.microsoft.com/profile/Taylor+H+-+MSFT), Premier Field Engineer.

You can use custom fonts with Microsoft Office Online Server (OOS) by using ".otf" files. Font files must be ".otf" files. The .ttf files don't work with OOS.

To apply custom fonts in web apps, install the ".otf" file on your local computers and every OOS server in the farm.
The font file must be installed by an administrator, and it must be installed by right-clicking the font file and clicking **Install**. You may not just drag the font file into the fonts folder.

OOS uses the Windows Font Cache for its fonts. After the font file is installed, each Office Web Apps machine in the farm will have to be fully restarted before the font takes effect in the web apps.

## More information

If you are viewing a document in the web apps that already has the custom font, the custom font will show in preview, view, and edit mode in the browser. Additionally, the custom font will show in the font drop-down menu within the web app.

When you create a new document in the web apps, the custom font won't show in the default list of fonts.  However, you can search for the font by using the search feature within the font drop-down menu.  

> [!NOTE]
> You must spell the font name exactly as it appears, or the font won't be used.  For example, if the actual custom font name is "Fonts", and the user searches for "Font", the custom won't be used.

Office Online Server 2013 and Office Online Server don't officially support custom fonts. It is the best chance for you to use custom fonts with Office Online Server 2013 by using the previous method.
