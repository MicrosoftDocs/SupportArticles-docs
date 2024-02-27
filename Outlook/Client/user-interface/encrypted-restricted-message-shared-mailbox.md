---
title: Can't read encrypted or restricted message sent to shared mailbox in Outlook
description: Provide two workarounds to an issue in which a user who was granted Full Access permission to a shared mailbox can't read encrypted or restricted message sent to the shared mailbox in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: kellybos
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 124859
appliesto: 
  - Exchange Online
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 01/30/2024
---
# Can't read encrypted or restricted message sent to shared mailbox in Outlook

## Symptoms

A user who is granted full access permissions to a shared mailbox can't read encrypted or restricted email messages that are sent to the shared mailbox in Microsoft Outlook. The user may receive a redirection message in the Outlook client that points to Outlook on the Web (OWA). However, OWA can't successfully load the messages.

> [!NOTE]
> Users who are included as recipients in encrypted or restricted email messages can read the messages from their mailbox in Outlook.

## Cause

Outlook and the Azure Information Protection unified labeling client require the user to have full access permissions and have automapping enabled. However, automapping isn't enabled for users who are granted the full access permissions through a security group.

For more information, see the “Can I open encrypted messages sent to a shared mailbox?” section of [Message encryption FAQ](/microsoft-365/compliance/ome-faq?view=o365-worldwide&preserve-view=true#can-i-open-encrypted-messages-sent-to-a-shared-mailbox).

## Workaround

To fix this issue, use either of the following workarounds:

- Use the **Open another mailbox** option to open the message in OWA.
- Enable automapping by granting full access permissions directly to the user.
