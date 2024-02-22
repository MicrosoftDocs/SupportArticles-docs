---
title: Cannot create a new message from Outlook Web App
description: Describes an issue in which no message window appears when you select the OWA new message button in Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: sapadman, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# You can't create a new message from Outlook Web App in Microsoft 365

_Original KB number:_ &nbsp; 2949841

## Symptoms

When you select the **New** button to create a new message in Microsoft Outlook Web App (OWA) in Microsoft 365, no message window appears. However, you can respond to the existing email messages in OWA and can also open a new message window from the Outlook client.

## Cause

This issue can occur if there are special characters in the signature.

For example, notice the backslash character (\\) at the end of the address span in the following signature log:

```console
<span style=\"font-family:\'Arial\',\'sans-serif\'; font-size:8.5pt\"\>4567 Main St Buffalo, NY 98052\<\/span\>
<span style=\"font-family:\'MS Gothic\'; font-size:8.5pt\"\>\<\/span\>
```

## Resolution

To resolve this issue, follow these steps:

- Remove your signature, and then open the new mail message window.
- Keep your signature simple. Do no use special characters.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
