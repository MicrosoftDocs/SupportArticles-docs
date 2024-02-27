---
title: Add a shared mailbox as an additional account in Outlook Desktop
description: Describes how to add a shared or regular mailbox as an additional account in Outlook for improved mailbox functionality, such as event reminders.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: hugopanao, gbratton, meerak, v-trisshores
appliesto: 
  - Outlook for Microsoft 365
  - Outlook LTSC 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 01/30/2024
---

# Add a shared mailbox as an additional account in Outlook Desktop

You can include a shared mailbox in your Microsoft Outlook profile as an automapped mailbox, an additional mailbox, or an additional account. This article discusses how to add a shared mailbox to your profile as an additional account.

> [!NOTE]
> The following procedure applies to either a shared or regular mailbox.

1. If the shared mailbox is already included in your profile as an automapped or additional mailbox, remove it by using the applicable procedure:

   - For an automapped mailbox, [disable automapping](/outlook/troubleshoot/profiles-and-accounts/remove-automapping-for-shared-mailbox). After automapping is disabled, you might have to wait up to one hour for Microsoft Exchange to remove the automapped mailbox from your Outlook profile.

     **Note:** Only an Exchange admin can disable automapping.

   - For an additional mailbox, [remove the mailbox from the list of additional mailboxes in your Outlook profile](https://support.microsoft.com/office/remove-another-person-s-mailbox-from-your-profile-7263428e-c187-47c8-9af1-75de4df5cfcd).

   This step makes sure that you don't add a second instance of the same mailbox to your Outlook profile in step 2.

2. Add the Exchange account for the shared mailbox to your Outlook profile as an additional account:

   1. Open Outlook, and then select **File** \> **Add Account**.

   2. Enter the email address of the mailbox, and then select **Connect**.

   3. When you're prompted to sign in, enter your email address instead of the email address of the shared mailbox, and then select **Next**.

      Note: If the sign-in prompt doesn't let you change the email address, select **Sign in with another account** to open a new sign-in prompt, and then enter your email address instead of the email address of the shared mailbox.

   4. After you successfully authenticate, restart Outlook.

## Display event reminders for a shared mailbox

One reason that you might want to add a mailbox as an additional account is that Outlook doesn't show event reminders for a mailbox that is automapped or added as an additional mailbox. Outlook supports event reminders for a shared or regular mailbox only if you add the mailbox to your Outlook profile as an additional account.
