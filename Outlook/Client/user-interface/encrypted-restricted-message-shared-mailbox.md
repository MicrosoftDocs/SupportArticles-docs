---
title: Can't read encrypted or restricted message sent to shared mailbox in Outlook
description: Provide two workarounds to an issue in which a user who was granted Full Access permission to a shared mailbox can't read encrypted or restricted message sent to the shared mailbox in Outlook.
author: TobyTu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: kellybos
ms.custom: 
- CSSTroubleshoot
- CI 124859
appliesto:
- Exchange Online
- Outlook for Microsoft 365
- Outlook 2019
- Outlook 2016
- Outlook 2013
---
# Can't read encrypted or restricted message sent to shared mailbox in Outlook

## Symptoms

A user who was granted Full Access permission to a shared mailbox can't read encrypted or restricted email messages sent to the shared mailbox in Microsoft Outlook. A message redirecting to Outlook on the Web (OWA) may be displayed in the Outlook client, but OWA can't successfully load the email messages.

Notice that users included as recipients in encrypted or restricted email messages will be able to read the messages from their mailbox in Outlook.

## Cause

Outlook and the Azure Information Protection unified labeling client require the user to have Full Access permission with automapping enabled. However, automapping isn't enabled for users who gain the Full Access permission through a security group.

For more information, see [Message Encryption FAQ](https://docs.microsoft.com/microsoft-365/compliance/ome-faq?view=o365-worldwide&preserve-view=true#can-i-open-encrypted-messages-sent-to-a-shared-mailbox).

## Workaround

To fix this issue, use either of the following workarounds:

1. Use the **Open another mailbox** option to open the message in OWA.
2. Enable automapping by granting Full Access permissions directly to the user.
