---
title: It is not possible to expand the folder error
description: Describes an issue that occurs when you try to access Exchange public folders in Exchange Online. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jmartin, dpaul, v-six
appliesto: 
  - Exchange Online
  - Outlook 2016
  - Outlook 2013
search.appverid: MET150
ms.date: 01/24/2024
---
# It is not possible to expand the folder error when accessing public folders in Exchange Online

_Original KB number:_ &nbsp; 3027606

## Symptoms

When you use Microsoft Outlook 2013 or Outlook 2016 to access Microsoft Exchange Server public folders in Microsoft Exchange Online, you receive the following error message:

> It is not possible to expand the folder. It is not possible to open folders. Microsoft Exchange is not available due to network issues or Exchange Server is disabled for maintenance

## Resolution

To resolve this issue, follow the steps that are listed in [Configure legacy on-premises public folders for a hybrid deployment](/exchange/collaboration-exo/public-folders/set-up-legacy-hybrid-public-folders).

## More information

This issue occurs because the Exchange mailbox that holds the public folder doesn't have the Client Access Server (CAS) role enabled.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
