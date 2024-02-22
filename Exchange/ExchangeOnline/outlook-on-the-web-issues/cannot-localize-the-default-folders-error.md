---
title: Cannot localize the default folders error
description: Describes an issue that prevents a user from changing the default folder names (such as Inbox) in Outlook on the web to the language that they specified on the Region and time zone settings page.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kunalsh, adipuli, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Cannot localize the default folders error when changing default folder names to another language in Outlook on the web

_Original KB number:_ &nbsp; 3196480

## Symptoms

A user discovers that they can't change the default folder names (such as Inbox and Sent Items) in Outlook on the web to another language. When the user specifies a language in the **Language** box and then selects the **Rename default folders so their names match the specified language** check box on the **Region and time settings** page in Outlook on the web, they receive the following error message:

> The localization operation of the default folders of mailbox "User@Contoso.com" failed: Cannot localize the default folders.

Additionally, you may have taken the following actions to try to reset default folder names to the new language, but this didn't resolve the issue:

- Run the Outlook.exe /ResetFolderNames command
- Run the following command:

  ```powershell
  Set-MailboxRegionalConfiguration -id <alias> -LocalizeDefaultFolderName:$true -Language <Language_code_to_switch_to> -DateFormat <your_preferred_DateFormat>
  ```

## Cause

The mailbox contains one or more folders whose name is the same as one or more default folder names in the new language. The default folders are Inbox, Sent Items, Drafts, Junk Email, RSS Subscriptions, and Deleted Items.

For example, the mailbox contains a folder named *Postvak In*, which is the Dutch name for Inbox. A user experiences this issue if they try to change the language of default folder names to Dutch because a folder named *Postvak In* already exists.

## Resolution

Rename the existing folders in the mailbox so that they have unique names. Then, specify a language and select the check box to rename default folders to match the specified language. ​

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
