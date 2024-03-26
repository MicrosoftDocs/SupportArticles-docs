---
title: Another account from your organization is already signed in on this computer
description: Fixes an error that occurs when you try to sign in to an Office 2016 for Mac app by using Microsoft 365 credentials.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Office 2016 for Mac
ms.date: 03/31/2022
---

# Can't sign in to an Office 2016 for Mac app

## Problem

When you try to sign in to an Office 2016 for Mac app by using your Microsoft 365 user ID and password, you receive the following error message:

> Sorry, another account from your organization is already signed in on this computer.

## Solution

To resolve this issue, use the Keychain Access app to delete any password entries that contain "Office." To do this, follow these steps:

1. Start the Keychain Access app.
1. In the Search field, type Office.
1. Delete any entries that are found.
   > [!NOTE]
   > You should find between two and six entries.
1. Exit the Keychain Access app, and then try to sign in to Office 2016 for Mac again.

## More information

This behavior is expected. It occurs if you're already signed in to Office 2016 for Mac through a different Microsoft 365 user account in the same organization.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Sign out of the first account that signed in, then restart that computer. If this solution does not resolve the issue, try the workaround below.
