---
title: Error 0x8004def4 when signing in to OneDrive
description: Fixes an issue in which you can't sign in to OneDrive and you receive error code 0x8004def4.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 167522
  - CSSTroubleshoot
ms.reviewer: salarson
appliesto: 
  - OneDrive for Business
search.appverid: 
  - MET150
ms.date: 9/29/2022
---
# Error 0x8004def4 when signing in to OneDrive

## Symptoms

You can't sign in to Microsoft OneDrive and receive the following error message:  

> Sorry, there was a problem with OneDrive. Please restart your computer. If the problem persists, please reinstall OneDrive. (Error Code: 0x8004def4)

## Cause

This issue may occur for different reasons, such as:

- Folder name conflict.
- Synchronizing an existing [OneNote notebook](https://support.microsoft.com/office/restrictions-and-limitations-in-onedrive-and-sharepoint-64883a5d-228e-48f5-b3d2-eb39e07630fa#onenotenotebooks) with the OneDrive sync app without going through the OneNote application.  

## Resolution

To fix issues caused by folder name conflicts or OneNote notebook synchronization, use Microsoft Support and Recovery Assistant.  

1. Download and install [Microsoft 365 Support and Recovery Assistant](https://aka.ms/SaRA-FirstScreen).
2. Select **OneDrive for Business** > **Next**.

    :::image type="content" source="media/sign-into-onedrive-error-0x8004def4/select-problematic-app.png" alt-text="Screenshot of which app are you having problems with, and OneDrive for Business is highlighted.":::

3. Select **I need help syncing my OneDrive files**, and then select **Next**.

    :::image type="content" source="media/sign-into-onedrive-error-0x8004def4/select-issue.png" alt-text="Screenshot of selecting the problem you're having page, and syncing my OneDrive files is highlighted.":::

If the Assistant can't resolve the issue, it may not be caused by sync conflicts. In this situation, try to [Reset OneDrive](https://support.microsoft.com/office/reset-onedrive-34701e00-bf7b-42db-b960-84905399050c#ID0EBH=Windows). If the issue persists, [uninstall OneDrive](https://support.microsoft.com/office/turn-off-disable-or-uninstall-onedrive-f32a17ce-3336-40fe-9c38-6efb09f944b0), and then [reinstall it](https://www.microsoft.com/microsoft-365/onedrive/download).
