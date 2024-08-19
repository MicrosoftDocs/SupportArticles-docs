---
title: NDR error 550 5.1.1 RESOLVER.ADR.ExRecipNotFound
description: Describes an issue that occurs when you send email messages by using Outlook in Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - 'Associated content asset: 4555312'
  - CI 167832
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Online
  - Microsoft 365 Apps for enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# "550 5.1.1 RESOLVER.ADR.ExRecipNotFound" when sending emails by using Outlook in Microsoft 365

_Original KB number:_ &nbsp; 2784785

## Problem

When you send email messages by using Microsoft Outlook in Microsoft 365, you may experience one or both of the following issues:

### Symptom 1: You receive non-delivery reports (NDRs)

Email messages or meeting invitations aren't delivered successfully. For example, you receive an NDR that resembles the following example:

> Generating server: \<server name\>.local
>
>IMCEAEX-_O=CONTOSO_ou=first+20administrative+20group_cn=Recipients_cn=\<username\>@\<server name\>.local
>
> #550 5.1.1 RESOLVER.ADR.ExRecipNotFound; not found ##

### Symptom 2: The AutoComplete feature in Outlook doesn't work as expected

When you create a new email message and then type a name in the **To** line, the user's name is auto-populated. However, when you double-click the name, you experience one of the following issues:

- The dialog box information isn't displayed correctly.
- Information is missing from the dialog box.

## Cause

These issues may occur if one of the following conditions is true:

- You reply to messages that were migrated from personal folders (.pst) files or were migrated by using a third-party migration tool.
- The Outlook nickname cache (AutoComplete) contains a bad entry.
- The OfflineAddressBook isn't updated or can't be downloaded.

## Solution

To resolve these issues, follow these steps:

1. Reset the nickname and the autocomplete caches in Outlook. For more information about how to do so, see [Information about the Outlook AutoComplete list](/outlook/troubleshoot/contacts/information-about-the-outlook-autocomplete-list).
1. If you reply to a migrated message, type the whole email address of the recipient again. If the Autocomplete feature tries to input the recipient name or address for you, select the 'X' to delete the entry, and then manually type the whole email address again.

   :::image type="content" source="media/exrecipnotfound-ndr/delete-entry.png" alt-text="Screenshot of the To line showing the auto-populated address.":::

1. Make sure that the Offline Address Book is operating correctly. For more information about how to troubleshoot the Offline Address Book, see [How to troubleshoot the Outlook Offline Address Book in a Microsoft 365 environment](https://support.microsoft.com/office/how-to-troubleshoot-the-outlook-offline-address-book-in-a-microsoft-365-environment-af66162b-92ad-4e41-bf08-2b597c34d7a8).

## More information

This issue most frequently occurs when messages are migrated by using a method that doesn't correctly update the underlying X.500 distinguished name information for the original recipients of the message. The most common culprits in this scenario are .pst migrations.

For more information, see the following resources:

- [What are Exchange NDRs in Exchange Online and Microsoft 365](https://support.office.com/article/what-are-exchange-ndrs-in-exchange-online-and-office-365-51daa6b9-2e35-49c4-a0c9-df85bf8533c3)
- [Error code 5.1.1 through 5.1.20 in Exchange Online and Microsoft 365](https://support.office.com/article/error-code-5-1-1-through-5-1-20-in-exchange-online-and-office-365-79e91ade-5c83-405b-a37d-d99c7d069b13)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
