---
title: Can't run In-Place eDiscovery search for Exchange Online mailbox in Exchange Server 2019 or 2016 by using EAC
description: When run In-Place eDiscovery search for Exchange Online mailbox in the on-premises server, it fails and you may receive an error message.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:eDiscovery
  - CI 111898
  - CSSTroubleshoot
ms.reviewer: lindabr, akashb
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: 
  - MET150
ms.date: 06/25/2024
---

# Can't run In-Place eDiscovery search for Exchange Online mailbox in Exchange Server 2019 or 2016 by using EAC

## Symptoms

In a Microsoft Exchange hybrid deployment environment, when you try to run In-Place eDiscovery searches in Microsoft Exchange Server 2019 or 2016 for cloud-based mailboxes by using Exchange admin center (EAC) in the on-premises server, you receive the following error message, depending on the scenario:

### Scenario 1

You're trying to search a remote mailbox that doesn't have an online archive enabled. In this scenario, you receive an error message that resembles the following example:

`Export failed with error type: 'FailedToSearchMailboxes'. Details: The underlying connection was closed: An unexpected error occurred on a receive. Endpoint: https://mail.contoso.com:444/EWS/Exchange.asmx`

### Scenario 2

You're trying to search a remote mailbox that has an online archive enabled. The estimate of search results succeeds. However, when you try to copy the results to a discovery mailbox, the attempt fails and returns an error message that resembles the example:

`Failed Search or Export, Mailbox:UserOne@contoso.com::Item:::DocumentId:::ItemId: with error: [FailedToGetRootFolders] Export failed with error type: 'FailedToGetRootFolders'. Message: ErrorNonExistentMailbox : No mailbox with such guid. Endpoint: https://mail.contoso.com:444/EWS/Exchange.asmx`

## Workarounds

It's a known issue in Exchange Server 2019 and 2016. To work around this issue, use either of the following methods:

### Method 1

Use the [Office 365 Security & Compliance Center](https://protection.office.com) to run the In-Place eDiscovery search for the Exchange Online mailboxes.

### Method 2

If you still have a server that is running Microsoft Exchange Server 2013 that is installed in your on-premises organization, move the discovery mailbox to the Exchange Server 2013 server, and then try the search again.
