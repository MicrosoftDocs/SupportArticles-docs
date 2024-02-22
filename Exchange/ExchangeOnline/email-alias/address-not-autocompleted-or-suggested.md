---
title: Autocomplete and suggestions don't work for internal recipients
description: Fixes an issue in which a recipient's address isn't autocompleted or suggested for a user who has an address book policy assigned.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 162284
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: alexaca
appliesto: 
  - Exchange Online
  - Outlook on the web
  - Outlook for Microsoft 365
  - Outlook 2019 for Mac
  - Outlook 2019
  - Outlook 2016
  - Outlook 2016 for Mac
search.appverid: MET150
ms.date: 01/24/2024
---
# Internal recipient's address isn't autocompleted or suggested

## Symptoms

Consider the following scenario:

- You have implemented global address list (GAL) segmentation, address lists, and [address book policies (ABPs)](/exchange/address-books/address-book-policies/address-book-policies) in your organization.
- You have assigned an address book policy to a user's Exchange Online account.
- The user who is assigned an ABP tries to send an email message to a recipient in the same organization.
- That recipient is not part of any of the address lists that are included in the assigned ABP.

In this scenario, the recipient's address isn't autocompleted or suggested in Outlook or Outlook on the web (OWA). Even if the user sends multiple email messages to that recipient, the recipient's address is still not autocompleted or suggested for subsequent email messages.

## Cause

This issue occurs because the address book policy that's applied to the sender doesn't allow them to see that internal recipient in the GAL. To maintain the GAL segmentation that's first implemented, the address book policy prevents the recipient's address from being autocompleted or suggested.

## Workaround

To have the recipient's address be autocompleted or suggested, use one of the following methods:

- Method 1: Ask the user to add the recipient's address as a personal contact in Outlook or in OWA.
- Method 2: If the address book policy that's applied on the user's account is no longer necessary, [remove the address book policy](/exchange/address-books/address-book-policies/remove-an-address-book-policy) in Exchange Online.
