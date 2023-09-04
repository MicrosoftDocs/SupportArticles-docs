---
title: Add-ins will stop working in Outlook on the web
description: Provides the information that users won't be able to launch add-ins in Outlook on the web that's running on Exchange Server 2016 RTM from May 3, 2021.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
  - CI 147160
ms.reviewer: mhaque, v-lianna
appliesto: 
  - Outlook on the web
  - Exchange Server 2016 RTM
search.appverid: MET150
ms.date: 03/31/2022
---
# Add-ins will stop working in Outlook on the web for Exchange Server 2016 RTM

Starting on May 3, 2021, you will no longer be able to start add-ins in an instance of Outlook on the web that's running on Microsoft Exchange Server 2016 RTM.

This change will occur because the [Outlook add-ins use the Office JavaScript APIs](/office/dev/add-ins/outlook/apis) that are accessed through the Office JS (Office.js) Content Delivery Network (CDN) to [interact with content](/office/dev/add-ins/develop/develop-overview#interacting-with-content-in-an-office-document) in Outlook on the web. These JavaScript APIs will be deprecated for Exchange Server 2016 RTM.

After this change is made, you will receive the following error message when you try to open an add-in in Outlook on the web:

> This add-in has been disabled to help keep you safe.

:::image type="content" source="media/add-ins-will-stop-working-outlook-on-the-web/add-in-disabled-error-message.png" alt-text="Screenshot of an error message - this add-in has been disabled to help you keep safe.":::

To resolve this issue, upgrade the Exchange-based server to the latest [cumulative update](/exchange/plan-and-deploy/install-cumulative-updates).
