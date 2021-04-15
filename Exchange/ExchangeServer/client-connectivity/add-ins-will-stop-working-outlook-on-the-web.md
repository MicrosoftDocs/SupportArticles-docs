---
title: Add-ins will stop working in Outlook on the web
description: Provides the information that the user won't be able to launch add-ins in Outlook on the web that's running on Exchange Server 2016 RTM from May 3, 2021.
author: v-lianna
ms.author: v-lianna
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
- CI 147160
ms.reviewer: mhaque
appliesto:
- Outlook on the web
- Exchange Server 2016 RTM
search.appverid: MET150
---
# Add-ins will stop working in Outlook on the web for Exchange Server 2016 RTM

From May 3, 2021, you won't be able to start add-ins in Outlook on the web that's running on Exchange Server 2016 RTM. The [Outlook add-ins use the Office JavaScript APIs](/office/dev/add-ins/outlook/apis) that are accessed via the Office JS (Office.js) Content Delivery Network (CDN) to [interact with content](/office/dev/add-ins/develop/develop-overview#interacting-with-content-in-an-office-document) in Outlook on the web. These JavaScript APIs are being deprecated for Exchange Server 2016 RTM.

When you try to launch an add-in in Outlook on the web, you'll see the following error message:

:::image type="content" source="./media/add-ins-will-stop-working-outlook-on-the-web/add-in-disabled-error-message.png" alt-text="The add-in has been disabled error message":::

To resolve this issue, upgrade the Exchange server to the latest [Cumulative Update](/exchange/plan-and-deploy/install-cumulative-updates).
