---
title: Autocomplete or suggestions don't work for internal recipients
description: Fixes an issue in which a recipient's address isn't autocompleted or suggested when a user who has an address book policy assigned tries to send an email message to the recipient.
author: MaryQiu1987
ms.author: v-maqiu
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
  - Outlook for Office 365
  - Outlook 2019 for Mac
  - Outlook 2019
  - Outlook 2016
  - Outlook 2016 for Mac
search.appverid: MET150
ms.date: 4/19/2022
---
# Internal recipient's address isn't autocompleted or suggested

## Symptoms

Consider the following scenario:

- You have implemented global address list (GAL) segmentation, address lists, and address book policies (ABPs) similar to what is described [here](/exchange/address-books/address-book-policies/address-book-policies).
- You have assigned an address book policy to a user's Exchange Online account.

In this scenario, when the user who is assigned an ABP tries to send an email message to a recipient in the same organization who is not part of any of the address lists that are included in the assigned ABP, the recipient's address isn't autocompleted or suggested in Outlook or Outlook on the web. Even if the user sends multiple email messages to that recipient, the address will still not be autocompleted or suggested for subsequent new email messages.

## Cause

This issue is due to the address book policy that's applied to the user and the GAL segmentation. The address book policy doesn't allow the sender to see this internal recipient in the GAL. When the user sends email messages to the recipient, if the recipient's address is autocompleted or suggested, the purpose of the GAL segmentation that's firstly implemented fails. This behavior is by design.

## Resolution

To have the recipient's address autocompleted or suggested, use one of the following options:

- Option 1: [Remove the address book policy](/exchange/address-books/address-book-policies/remove-an-address-book-policy) that's applied on the user's account in Exchange Online.
- Option 2: Ask the user to add the recipient's address as a personal contact in Outlook or in Outlook on the web, and then autocomplete and suggestions will work.
