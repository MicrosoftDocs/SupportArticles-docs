---
title: ErrorItemNotFound when add-ins make REST calls
description: Describes the ErrorItemNotFound error that occurs when Office add-ins make REST calls against an item ID when Outlook is in Cached Exchange Mode.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - CI 162281
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# ErrorItemNotFound error when Office add-ins make REST calls against an Outlook item ID

_Original KB number:_ &nbsp; 4483878

## Symptoms

Consider the following scenario:

- You use an Office add-in.
- The add-in makes Exchange Web Services (EWS) or Representational State Transfer (REST) calls against the item ID of an Outlook item.
- The calls can be made from either the Office front-end application or back end.

In this scenario, the transfer calls fail, and Outlook generates an **ErrorItemNotFound** error.

## Cause

When Outlook is in Cached Exchange Mode, the item ID that's provided through the Office JavaScript API [Office.context.mailbox.item.itemId](/javascript/api/requirement-sets/outlook/requirement-set-1.6/office.context.mailbox.item) is either outdated or not yet updated on the server.

## More information

This issue occurs in the following scenarios:

- While an email message is open in a separate Outlook desktop window, you move the message to a different folder in another Outlook application. For example, you move the message to Outlook Web Access (OWA) or Microsoft Outlook for iOS and Android. Then, you return to the Outlook desktop application and use an Office add-in that uses an `ItemID` API.

  In this case, the original item ID is no longer valid. Therefore, when the Office add-in tries to access the email message through Web Services, you receive an **ErrorItemNotFound** error message that states that the operation can't be completed because the message was moved or deleted.

- An email message is archived, deleted, or moved to another folder. A short time later, you use an Office add-in that uses an `ItemID` API in Outlook.

  In this case, Outlook provides the updated item ID. However, the server may not have the ID until Outlook synchronizes with the server. When Outlook works online, synchronization is typically quick. But it can take longer for the process to finish in some cases.
  
  > [!NOTE]
  > Creating inbox rules in Outlook may also contribute to this scenario.

For more information about how the Web Services item ID changes when an email message is moved, see the **Working with identifiers** section in [EWS Identifiers in Exchange](/exchange/client-developer/exchange-web-services/ews-identifiers-in-exchange#working-with-identifiers).
