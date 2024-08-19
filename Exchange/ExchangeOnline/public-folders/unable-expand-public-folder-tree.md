---
title: Error "Your server administrator has limited the number of items you can open simultaneously" when you expand public folders in Outlook
description: Provide solutions to an issue in which you can't expand public folders in Outlook or OWA. 
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CI 125992
  - CSSTroubleshoot
ms.reviewer: haembab, batre, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
  - Microsoft Outlook 2016
  - Microsoft Outlook 2013
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# "Your server administrator has limited the number of items you can open simultaneously" error and you can't expand public folders in Outlook

## Symptoms

Users who have sufficient permissions to public folders receive the following error message when they expand a public folder tree in Microsoft Outlook or Outlook on the Web (OWA):

> Your server administrator has limited the number of items you can open simultaneously. Try closing messages you have opened or removing attachments and images from unsent messages you are composing.

## Cause

The following conditions can cause this problem to occur:

- You're using an outdated version of Microsoft Outlook 2016 or 2013.
- The default public folder mailbox resources are exhausted from servicing  the public folder hierarchy. However, the threshold at which Exchange can provision a new public folder mailbox (through [Auto-split](https://techcommunity.microsoft.com/t5/exchange-team-blog/how-exchange-online-automatically-cares-for-your-public-folder/ba-p/2050019)) hasn't been reached.

## Resolution

If the problem occurs in only Microsoft Outlook 2016, install the [April 5, 2016, update for Outlook 2016](https://support.microsoft.com/help/3114972).

If the problem occurs in only Microsoft Outlook 2013, install the [April 5, 2016, update for Outlook 2013](https://support.microsoft.com/help/3114941).

If several users report the problem in both Outlook and OWA, follow the instructions for the relevant scenario.

### Scenario 1

You're using the **DefaultPublicFolderMailbox** property to predefine a hierarchy for servicing a public folder mailbox. For example, you may have predefined the default public folder mailbox for user mailboxes in a remote site so that users can connect to the specified public folder mailbox based on their geographical location. The problem occurs if there are user traffic spikes on the default public folder mailbox.

To resolve this problem, create a new public folder mailbox, and manually update the public folder mailbox hierarchy to be ready to use that public folder mailbox to service the public folder hierarchy for some of the affected users. Here's how to change the **DefaultPublicFolderMailbox** property for these user mailboxes.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command to create a public folder mailbox:

    ```powershell
    New-Mailbox -Name "<New public folder mailbox name>" -PublicFolder 
    ```

3. Run the following command to update the public folder hierarchy for the public folder mailbox

    ```powershell
    Update-PublicFolderMailbox -InvokeSynchronizer -Identity "<New public folder mailbox name>" 
    ```

4. Run the following command to find the user mailboxes whose **DefaultPublicFolderMailbox** property is set to the predefined public folder mailbox:

    ```powershell
    Get-Mailbox | where DefaultPublicFolderMailbox -like "*<Public folder mailbox name>*" 
    ```

    In the result, note the value of the \<User mailbox name> parameter.

5. Run the following command to set the **DefaultPublicFolderMailbox** property to the new public folder mailbox for the user mailbox that you noted:

    ```powershell
    Set-Mailbox -identity "<User mailbox name>" -DefaultPublicFolderMailbox "<New public folder mailbox name>"
    ```

### Scenario 2

You're using the **DefaultPublicFolderMailbox** property to predefine a hierarchy for servicing a public folder mailbox. There are other public folder mailboxes that are ready to service the hierarchy for users and that have no special configuration. This is the case if all users are in the same geographical location.

In this scenario, find the user mailboxes whose **DefaultPublicFolderMailbox** property is set to non-null values, and set the property to **null**. This will redirect users to a relatively low-load public folder mailbox.

Here's how to change the property:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command to find the user mailboxes whose **DefaultPublicFolderMailbox** property is set to non-null values:

    ```powershell
    $users = Get-Mailbox | where DefaultPublicFolderMailbox -ne $null 
    $users | ft name, *effective**public*, *default**public* 
    ```

    In the result, note the value of the \<User mailbox name> parameter.

3. Run the following command to set the **DefaultPublicFolderMailbox** property for these user mailboxes to **null**:

    ```powershell
    $users | Set-Mailbox -DefaultPublicFolderMailbox $null 
    ```

4. Run the following command to verify that the value is set successfully:

    ```powershell
    Get-Mailbox <User mailbox name> | fl name, *effective**public*, *default**public*
    ```
