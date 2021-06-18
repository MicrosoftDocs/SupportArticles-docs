---
title: You may have already signed in to Outlook Web App error
description: Describes an issue in which you receive a You may have already signed in to Outlook Web App error message when you try to open Outlook Web App in Office 365. Provides a workaround.
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
ms.reviewer: dahans
appliesto:
- Exchange Online
search.appverid: MET150
---
# You may have already signed in to Outlook Web App error when you try to open Outlook Web App in Office 365

_Original KB number:_ &nbsp; 2798988

## Symptoms

When you try to open Outlook Web App in Microsoft Office 365, you receive the following error message:

> There was a problem opening your mailbox. You may have already signed in to Outlook Web App on a different browser tab. If so, close this tab and return to the other tab. If that doesn't work, you can try:
>
> - Closing your browser window and signing in again.
> - Deleting cookies from your browser and signing in again.

## Cause

This issue occurs when the following conditions are true:

- You try to open an Office 365 Outlook Web App session and an Outlook.com-based Outlook Web App session at the same time.
- The Office 365 Outlook Web App session and the Outlook.com-based Outlook Web App session share the same Outlook Web App server endpoint.

The same Outlook Web App server endpoint can't be accessed through a single browser session.

## Workaround

Use one of the following methods, as appropriate for your situation.

- Set up CNAME records in the external Domain Name System (DNS) server, and set up custom Outlook Web App URLs.
- Access the second instance of Outlook Web App by using an InPrivate Browsing session in the browser.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
