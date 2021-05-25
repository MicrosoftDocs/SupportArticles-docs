---
title: How to change your user photo
description: Describes how to change your user photo that's used in Exchange Online in Microsoft 365, Lync 2013, and Lync Web App.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: 
appliesto:
- Exchange Online
- Skype for Business Online
- Microsoft Lync 2013
- Lync Web App
search.appverid: MET150
---
# How to change your user photo in Microsoft 365

_Original KB number:_ &nbsp; 2986893

## Summary

To update your user photo in Exchange Online, Lync 2013, and Lync Web App, follow these steps:

1. Sign in to [Microsoft 365 portal](https://portal.office.com) or [Outlook on the web](https://outlook.office.com).
2. Select your user photo (or its placeholder) on the right side of your name.
3. In the **My accounts** window, select your user photo or placeholder again.
4. In the new **Account Information** window, select **Browse** to select and upload your photo.
5. Select **Save** to set your user photo.

## More information

In Microsoft 365, user photos are stored in the following locations:

- A low-resolution photo (less than 100 KB) is stored in the user's `ThumbnailPhoto` attribute in Active Directory. This is the photo that's synchronized to Microsoft 365 in a hybrid environment. Low-resolution photos are used by Lync 2010.
- A high-resolution photo is stored in the root directory of the user's Exchange Online mailbox. High-resolution photos are displayed in Exchange Online, Lync 2013, and Lync Web App.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
