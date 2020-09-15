---
title: Another account from your organization is already signed in on this computer
description: Discusses an error message that a user receives when he or she tries to sign in to an Office 2013 app by using Office 365 credentials.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Office 2016 for Mac
---

# Can't sign in to an Office 2016 for Mac app

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

When you try to sign in to an Office 2016 for Mac app by using your Office 365 user ID and password, you receive the following error message:

**Sorry, another account from your organization is already signed in on this computer.**

## Solution

To resolve this issue, use the Keychain Access app to delete any password entries that contain "Office." To do this, follow these steps:

1. Start the Keychain Access app.
1. In the Search field, type Office.
1. Delete any entries that are found.
   > [!NOTE]
   > You should find between two and six entries.
1. Exit the Keychain Access app, and then try to sign in to Office 2016 for Mac again.

## More information

This behavior is expected. It occurs if you're already signed in to Office 2016 for Mac through a different Office 365 user account in the same organization. 

### Third-party information disclaimer

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
Sign out of the first account that signed in, then restart that computer. If this solution does not resolve the issue, try the workaround below. 