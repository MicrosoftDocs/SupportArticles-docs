---
title: How to change your user photo
description: Describes how to change your user photo that's used in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Microsoft 365
search.appverid: MET150
ms.date: 01/24/2024
---
# How to change your user photo in Microsoft 365

_Original KB number:_ &nbsp; 2986893

## Summary

To update your user photo in Microsoft 365, follow these steps:

1. Sign in to [Microsoft 365](https://go.microsoft.com/fwlink/?linkid=841641), or [Outlook on the web](https://outlook.office.com).
2. Select the circle in the upper-right corner of the page that shows your initials or an icon of a person.
3. In the **My accounts** window, select the circle that shows your initials or an icon of a person.
4. In the **Change your photo** pop-up window, select **Upload a new photo**, and then select and upload your photo.
5. Select **Apply** to set your user photo.

## More information

In Microsoft 365, user photos are stored in the following locations:

- A low-resolution photo (less than 100 KB) is stored in the user's `ThumbnailPhoto` attribute in Active Directory. This is the photo that's synchronized to Microsoft 365 in a hybrid environment. Low-resolution photos are used by Lync 2010.
- A high-resolution photo is stored in the root directory of the user's Exchange Online mailbox. High-resolution photos are displayed in Exchange Online, Lync 2013, Skype for Business and Teams.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
