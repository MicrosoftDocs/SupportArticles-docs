---
title: Cannot saving a project from Project client to Project Web App
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro 
ms.custom: CSSTroubleshoot
ms.topic: article
ms.service: o365-solutions
search.appverid: 
- MET150
description: Unable to save a project from a Project client to PWA with the error ID 12005(0xEE5)
appliesto:
- Project Online
- Project Professional 2016
- Project Pro for Office 365
---

# You can't save a project from a Project client to Project Web App

## Symptoms

When you try to save a project from a Project client to Project Web App (PWA), you receive the following error message:

**The following job failed to complete.**
**Job Type: Save**
**Error ID: 12005(0xEE5)**
**Error: Queue failed to process the message.**

## Cause

This issue occurs because of outdated credentials for the user account that you use to connect to PWA from a Project client.

## Resolution

To resolve this issue, follow these steps:
1. Open **Control Panel**.
2. Click **User Accounts** -> **Credentials Manager** -> **Windows Credentials** in the **Manage your credentials** window, and then remove any credentials that are stored in the **Credential Manager** window.

   ![Removing credentials in the Credential Manager window](./media/cant-save-project-client-to-web-app/credentials.png)
3. Open the Project client and then connect to PWA.
4. Save the project again to check the behavior.
