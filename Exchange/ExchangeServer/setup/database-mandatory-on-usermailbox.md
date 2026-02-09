---
title: Exchange Server Setup fails and returns "Database is mandatory on UserMailbox" error
description: Explains how to identify and correct a blank homeMDB attribute on essential mailboxes to ensure that Exchange Server Setup finishes successfully.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: batre, arindamt, v-kccross
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Setup Issues
  - Exchange Server
  - CSSTroubleshoot
  - CI 6980
appliesto: 
  - Exchange Server
ms.date: 02/09/2026
---

# "Database is mandatory on UserMailbox" error in Exchange Server Setup

## Summary

The article discusses a Microsoft Exchange Server Setup failure that occurs when essential mailboxes, such as arbitration or discovery mailboxes, have blank `homeMDB` attributes. You can resolve the Exchange Server Setup error by fixing the missing mailbox database assignment.

## Symptoms

When you run Exchange Server Setup, the application fails with an error message that resembles the following message:

 > [ERROR] Database is mandatory on `UserMailbox`

##  Cause

You receive this error message if the `homeMDB` attribute is blank on essential mailboxes such as the arbitration mailbox or the discovery mailbox. This problem can occur, for example, if the mailbox host server is incorrectly deleted.

## Resolution

Use the SetupAssist script to identify affected mailboxes. Then configure the `homeMDB` attribute for each mailbox.

### Identify affected mailboxes

On the server on which Setup failed, download and then run the [SetupAssist](https://microsoft.github.io/CSS-Exchange/Setup/SetupAssist/) script. The script returns information about mailboxes as shown in the following example.

:::image type="content" source="media/database-mandatory-on-usermailbox/setup-assist-result.png" alt-text="Screenshot of SetupAssist script output showing mailboxes with blank homeMDB attributes."

 In the example, the `homeMDB` attribute is blank for `DiscoverySearchMailbox`.

### Fix affected mailboxes

To set the `homeMDB` attribute for each mailbox in the output from the SetupAssist script, complete these steps:

1. [Open the Exchange Management Shell](/powershell/exchange/open-the-exchange-management-shell) or [connect to your Exchange server by using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).

1. Run the `[Get-MailboxDatabase](/powershell/module/exchangepowershell/get-mailboxdatabase)` cmdlet to get a list of available mailbox databases.

   ```powershell

   Get-MailboxDatabase

   ```

1. Run the `[Set-Mailbox](/powershell/module/exchangepowershell/set-mailbox)` cmdlet to set the `homeMDB` attribute one time for each mailbox in the output from the  SetupAssist script. For each confirmation message that displays, select **Yes**. When you run the cmdlet, use a value that uniquely identifies the database, such as the distinguished name (DN), the GUID, or its name.

   ```powershell

   Set-Mailbox “\<*mailbox DN*\>” -Database “\<*database name*\> “

   ```

   Example:

   ```powershell

   Set-Mailbox "CN=DiscoverySearchMailbox {D919BA05-46A6-415f-80AD-7E09334BB852},CN=Users,DC=contoso,DC=lab" -Database "Mailbox Database 1923094126" 

   ```

1. Close the Exchange Management Shell or PowerShell session.

1. Run Exchange Server Setup again.
