---
title: You'll need a new app to open this osf-roaming.16 message
description: You'll need a new app to open this osf-roaming.16 this message occurs when starting Outlook 2016.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016
  - Application Virtualization for Windows Desktops
  - App-V 5.0 for Windows Desktops
search.appverid: MET150
ms.date: 10/30/2023
---
# You'll need a new app to open this osf-roaming.16 message when starting Outlook 2016

_Original KB number:_ &nbsp; 4230296

## Symptoms

When you try to start Outlook 2016, you receive a **Do you want to allow this website to open an app on your computer?** message.

:::image type="content" source="media/you-ll-need-a-new-app-to-open-this-osf-roaming-16/message-1.png" alt-text="Screenshot of message: Do you want to allow this website to open an app on your computer.":::

If you select **Allow**, you receive a **You'll need a new app to open this osf-roaming.16** message.

:::image type="content" source="media/you-ll-need-a-new-app-to-open-this-osf-roaming-16/message-2.png" alt-text="Screenshot of message: you'll need a new app to open this osf-roaming.16.":::

## Cause

This issue occurs when the Click-to-Run version of Microsoft Office Professional Plus is installed on the system together with the App-V version of Microsoft Visio or Microsoft Project.

## Resolution

To resolve this issue, deploy the Click-to-Run or MSI version of Visio 2016 or Project 2016.

For more information about how to deploy Visio 2016 or Project 2016, see [Deploying Microsoft Office 2016 by Using App-V](/microsoft-desktop-optimization-pack/appv-v5/deploying-microsoft-office-2016-by-using-app-v).
