---
title: IgnoreLegalHold isn't available or functional for Exchange Online user objects
description: IgnoreLegalHold isn't available or functional for Disable-Mailbox, Remove-Mailbox, Disable-Mailuser, and Remove-Mailuser commands in Exchange Online
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Litigation Hold
  - CI 121741
  - CSSTroubleshoot
ms.reviewer: lindabr
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 06/24/2024
---
# IgnoreLegalHold isn't available or functional for Exchange Online user objects

The **IgnoreLegalHold** switch specifies whether to ignore a user's legal hold status. This parameter isn't available for these commands:

- Disable-Mailbox
- Remove-Mailbox
- Disable-Mailuser
- Remove-Mailuser
  
To permanently remove or disable a mailbox on hold, remove the mailbox from the hold. Before you do so, contact your compliance officer, records management team or legal department to understand your organization's policies and requirements regarding holds. For more information on hold identification, see [Identify a hold on an Exchange mailbox](/microsoft-365/compliance/identify-a-hold-on-an-exchange-online-mailbox?preserve-view=true&view=o365-worldwide).
