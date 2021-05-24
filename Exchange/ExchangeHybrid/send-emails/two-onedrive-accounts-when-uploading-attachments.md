---
title: Two OneDrive accounts when uploading attachments
description: Fixes an issue in which users see two OneDrive accounts when they upload attachments from Outlook on the web.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CI 147728
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: mmason
appliesto: 
- OneDrive for Business
- Outlook on the web
- Exchange Server 2016
- Exchange Server 2019
search.appverid: MET150
---
# Two OneDrive accounts appear when uploading attachments from Outlook on the web

## Symptoms

When you try to upload attachments from Outlook on the web, the **Upload** menu displays two OneDrive accounts instead of one.

:::image type="content" source="media/two-onedrive-accounts-when-uploading-attachments/onedrive-accounts.png" alt-text="Screenshot of two OneDrive accounts in Upload menu.":::

## Cause

This issue occurs if you're in a hybrid Exchange environment that has a mailbox on Microsoft Exchange Server on-premises and a OneDrive for Business account in Microsoft 365, and if the OneDrive account was moved to a different geographical location. After the OneDrive move, the internal and external My Site Host URLs are not updated in the `OwaMailboxPolicy` setting.

## Resolution

To fix this issue, follow these steps.

### Step 1

Use either of the following methods.

#### Method 1: Update My Site Host URLs

Update the internal and external My Site Host URLs in the `OwaMailboxPolicy` setting to the values for the new geographical location of OneDrive. To do this, run the following cmdlet:

```powershell
Set-OwaMailboxPolicy Default -InternalSPMySiteHostURL <new_OneDrive_URL> -ExternalSPMySiteHostURL <new_OneDrive_URL>
```

#### Method 2: Set values to Null

Set the internal and external My Site Host URLs in the `OwaMailboxPolicy` setting to **Null**. To do this, run the following cmdlet:

```powershell
Set-OwaMailboxPolicy Default -InternalSPMySiteHostURL $Null -ExternalSPMySiteHostURL $Null
```

### Step 2

Create a new Outlook profile to use the updated values that are set for `OwaMailboxPolicy`. This is necessary because the previous `OwaMailboxPolicy` settings are cached in your current Outlook profile, and they can't be updated.

For more information about the `OwaMailboxPolicy` setting, see [Configure document collaboration with OneDrive for Business and Exchange 2016 on-premises](/exchange/hybrid-deployment/set-up-document-collaboration).
