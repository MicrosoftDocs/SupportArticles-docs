---
title: Calling OpenMsgStore opens the archive mailbox instead of the primary mailbox
description: The Autodiscover service returns the primary SMTP address in the AutoDiscoverSMTPAddress XML element for both the primary mailbox and the archive mailbox. Calling OpenMsgStore to open the primary mailbox may open the archive mailbox instead.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - MET150
ms.custom: 
  - Outlook for Windows
  - CI 106387
  - CSSTroubleshoot
ms.reviewer: Andrei.Ghita
appliesto: 
  - Outlook 2016
  - Outlook 2019
  - Outlook Development
ms.date: 10/30/2023
---

# Calling OpenMsgStore in Outlook opens the archive mailbox instead of the primary mailbox

## Symptoms

Consider the following scenario:

- An Extended MAPI application calls OpenMsgStore to open the primary mailbox for a user.
- The same application then calls OpenMsgStore to open the archive mailbox for the same user.

In this scenario, all subsequent OpenMsgStore calls to open the primary mailbox will open the archive mailbox instead.

## Cause

This issue occurs because the Autodiscover service returns the primary SMTP address in the AutoDiscoverSMTPAddress XML element for both the primary mailbox and the archive mailbox.

## Workaround

To work around this issue, clear the contents of the **%localappdata%\Microsoft\Outlook\16** folder when the OpenMsgStore call is completed.

## More Information

The Outlook client performs an Autodiscover lookup when OpenMsgStore is called. The Autodiscover results are saved in the local file system for future use by Outlook and Extended MAPI clients.

The name of the cached Autodiscover results file contains the AutoDiscoverSMTPAddress XML element value. This value is returned by the Autodiscover service.

For both the primary mailbox and the archive mailbox, the Autodiscover service returns the primary SMTP address in the AutoDiscoverSMTPAddress XML element.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).