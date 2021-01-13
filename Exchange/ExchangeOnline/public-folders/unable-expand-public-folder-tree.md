---
title: Can't expand public folders with error "Your server administrator has limited the number of items you can open simultaneously" 
description: Provide solutions to an issue in which you can't expand public folders in Outlook or OWA with error "Your server administrator has limited the number of items you can open simultaneously". 
author: TobyTu
ms.author: haembab
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 125992
- CSSTroubleshoot
ms.reviewer: haembab,batre
appliesto:
- Exchange Online
- Exchange Server 2019
- Exchange Server 2016
- Exchange Server 2013
- Microsoft Outlook 2016
- Microsoft Outlook 2013
search.appverid: 
- MET150
---

# Can't expand public folders with error "Your server administrator has limited the number of items you can open simultaneously"

## Symptoms

Users who have sufficient permissions over public folders receive the following error message when they expand a public folder tree in Microsoft Outlook or Outlook on the Web (OWA):

> Your server administrator has limited the number of items you can open simultaneously. Try closing messages you have opened or removing attachments and images from unsent messages you are composing.

## Cause

There are two possible causes:

- You're using an outdated version of Microsoft Outlook 2016 or 2013.
- The default public folder mailbox resource(s) are exhausted serving public folder hierarchy but still the threshold where Exchange ([Auto-split](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-exchange-online-automatically-cares-for-your-public-folder/ba-p/2050019)) can provision a new public folder mailbox hasn't been reached.

## Resolution

If the issue occurs only in Microsoft Outlook 2016, install [April 5, 2016, update for Outlook 2016](https://support.microsoft.com/help/3114972).

If the issue occurs only in Microsoft Outlook 2013, install [April 5, 2016, update for Outlook 2013](https://support.microsoft.com/help/3114941).

If several users report the issue on both Outlook and OWA, follow the instructions relevant to your scenario:

### Scenario 1

You're using the *DefaultPublicFolderMailbox* property to predefine a hierarchy serving public folder mailbox. For example, you may have predefined the default public folder mailbox for users' mailboxes in a remote site so that they can connect to the specified public folder mailbox based on their geographical location. The issue occurs if there are user traffic spikes on the default public folder mailbox.

To resolve this issue, create a new public folder mailbox, manually update the public folder mailbox hierarchy to be ready to use that public folder mailbox to serve public folder hierarchy for some of the affected users. Here's how to change the *DefaultPublicFolderMailbox* property for these users' mailboxes.

1. [Connect to Exchange Online PowerShell](https://docs.microsoft.com/powershell/exchange/connect-to-exchange-online-powershell).
2. Run this command to create a new public folder mailbox:

    ```powershell
    New-Mailbox -<Public folder name> -Name "<New public folder mailbox name>"  
    ```

3. Run this command to update the public folder hierarchy for the public folder mailbox:

    ```powershell
    Update-PublicFolderMailbox -InvokeSynchronizer -Identity "<New public folder mailbox name>" 
    ```

4. Run this command to find the users' mailboxes whose *DefaultPublicFolderMailbox* property is set to the predefined public folder mailbox.

    ```powershell
    Get-Mailbox | where DefaultPublicFolderMailbox -like "*<Public folder mailbox name>*" 
    ```

    In the result, note \<User mailbox name>.

5. Run this command to set the *DefaultPublicFolderMailbox* to the new public folder mailbox for the user mailbox you noted.

    ```powershell
    Set-Mailbox -identity "<User mailbox name>" -DefaultPublicFolderMailbox "<New public folder mailbox name>"
    ```

### Scenario 2

You're using the *DefaultPublicFolderMailbox* property to predefine a hierarchy serving public folder mailbox. There are other public folder mailboxes ready to serve hierarchy for users with no special configuration. That's the case when all users are in the same geographical location.  

In this scenario, find the users' mailboxes whose *DefaultPublicFolderMailbox* property is set to non-null values and set the property to **null**. This will redirect users to a relatively low-load public folder mailbox.

Here's how to change the property:

1. [Connect to Exchange Online PowerShell](https://docs.microsoft.com/powershell/exchange/connect-to-exchange-online-powershell).
2. Run this command to find the users' mailboxes whose *DefaultPublicFolderMailbox* property is set to non-null values:

    ```powershell
    $users = Get-Mailbox | where DefaultPublicFolderMailbox -ne $null 
    $users | ft name, *effective**public*, *default**public* 
    ```

    In the result, note \<User mailbox name>.

3. Run this command to set the *DefaultPublicFolderMailbox* property for these users' mailboxes to **null**:

    ```powershell
    $users | Set-Mailbox -DefaultPublicFolderMailbox $null 
    ```

4. Run this command to verify that the value is set successfully:

    ```powershell
    Get-Mailbox <User mailbox name> | fl name, *effective**public*, *default**public*
    ```
