---
title: Outlook doesn't show event reminders for automapped or additional mailboxes
description: Discusses an issue in which Outlook doesn't show event reminders for automapped or additional mailboxes.
author: v-trisshores
ms.author: v-trisshores
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton, hugopanao, kaushika, meerak, meshel, tylewis
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook LTSC 2021
search.appverid: MET150
ms.date: 11/08/2022
---

# Outlook doesn't show event reminders for automapped or additional mailboxes

## Symptoms

Microsoft Outlook doesn't show event reminders for an automapped or additional mailbox.

## Cause

Outlook supports event reminders for a mailbox only if you add the Microsoft Exchange account for the mailbox to your Outlook profile. You might not have added the mailbox account to your Outlook profile. Instead, the mailbox might be automapped or added as an additional mailbox to your Outlook profile.

## Workaround

To enable event reminders, follow these steps:

1. Remove the automapped or additional mailbox from your Outlook profile:

   - For an automapped mailbox, [disable automapping](/outlook/troubleshoot/profiles-and-accounts/remove-automapping-for-shared-mailbox). After automapping is disabled, you might have to wait up to one hour for Exchange to remove the automapped mailbox from your Outlook profile.

     > [!NOTE]
     > Only an Exchange admin can disable automapping. If you aren't an Exchange admin, ask an admin to disable automapping for you.

   - For an additional mailbox, [remove it from the list of additional mailboxes in your Outlook profile](https://support.microsoft.com/office/remove-another-person-s-mailbox-from-your-profile-7263428e-c187-47c8-9af1-75de4df5cfcd).

   This step makes sure that you don't add a second instance of the same mailbox to your Outlook profile when you complete step 2.

2. Add the Exchange account for the previously removed mailbox to your Outlook profile as a secondary account:

    1. Open Outlook, and select **File** \> **Add Account**.

    2. Enter the email address of the mailbox, and then select **Connect**.

    3. When you're prompted to sign in, enter your email address instead of the email address of the mailbox, and then select **Next**.

    4. After you successfully authenticate, Outlook will:

       1. Add the mailbox account to your Outlook profile as a secondary account.

       2. Start showing event reminders for the secondary account.
