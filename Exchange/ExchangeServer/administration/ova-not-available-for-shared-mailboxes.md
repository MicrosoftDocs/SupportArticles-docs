---
title: OVA not available for a shared mailbox
description: Works around an issue in which Outlook Voice Access (OVA) is not available when a user tries to call from a shared mailbox.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with OWA
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, corbinm, excontent, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Outlook Voice Access (OVA) is not available when you call from a shared mailbox

_Original KB number:_ &nbsp; 3078440

## Symptoms

Consider the following scenario:

- A user accesses a shared mailbox (Mailbox_999).
- The phone extension for Mailbox_999 is ext. 12345.
- The user dials the Subscriber Access number from phone ext. 12345 and then enters the extension and PIN.

In this scenario, the Unified Messaging (UM) server responds with an **Invalid Mailbox Extension** error message.

## Workaround

Users can still use Outlook Voice Access (OVA) to access a shared mailbox. However, they must call from an extension of a non-shared mailbox. To work around this issue, the user must dial the Subscriber Access number from a different phone extension, such as ext. 78900. Then, enter ext. 12345 and the correct PIN. OVA can now successfully access Mailbox_999.
