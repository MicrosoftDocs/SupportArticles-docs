---
title: Can’t view embedded Stream video in Teams app
description: Fix an issue in which you receive a To see this content, sign in to Microsoft Stream error message when you try to view an embedded video in the Teams app.
author: helenclu
ms.reviewer: salarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Video\Stream
  - CSSTroubleshoot
  - CI 149683
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Can’t view embedded Stream video in Teams app

If a Microsoft Stream video is embedded in a SharePoint site, and that page is added as a tab in Microsoft Teams, you can’t view the video within the Teams app. In this situation, you might receive the following error message:

> To see this content, sign in to Microsoft Stream.

This problem occurs because Stream can't authenticate if you’re viewing the video in the Teams app. We're working to fix this problem and will post more information in this article when the information becomes available.

In the meantime, you can work around this problem by opening the SharePoint site in a new window and viewing the video there. Or, you can access Teams in your web browser instead of using the app.

You can also resolve this problem by adding your work account in Windows settings (**Settings** > **Accounts** > **Access work or school**). Stream will then be able to authenticate and play the video. For instructions to add your work account, see [Add or remove accounts on your PC](https://support.microsoft.com/windows/add-or-remove-accounts-on-your-pc-104dc19f-6430-4b49-6a2b-e4dbd1dcdf32).
