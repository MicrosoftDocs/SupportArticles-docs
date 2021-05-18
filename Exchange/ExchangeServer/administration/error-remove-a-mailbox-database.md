---
title: Error when you remove a mailbox database
description: Fixes an issue that prevents you from removing a mailbox database in Exchange Server 2016.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
search.appverid:
- MET150
appliesto:
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
---
# Error when you try to remove a mailbox database in Exchange Server 2016

_Original KB number:_ &nbsp; 3093175

## Symptoms

Even if you've already moved or disabled all users, public folders, and arbitration mailboxes, you receive one of the following error messages when running the `Remove-MailboxDatabase` cmdlet. This message states there are still mailboxes left on a Microsoft Exchange Server 2016 database.

> This mailbox database contains one or more mailboxes, mailbox plans, archive mailboxes, public folder mailboxes or
arbitration mailboxes. To get a list of all mailboxes in this database, run the command Get-Mailbox -Database **Database ID**. To get a list of all mailbox plans in this database, run the command Get-MailboxPlan. To get a list of archive mailboxes in this database, run the command Get-Mailbox -Database **Database ID** -Archive. To get a list of all public folder mailboxes in this database, run the command Get-Mailbox -Database **Database ID** -PublicFolder. To get a list of all arbitration mailboxes in this database, run the command Get-Mailbox -Database **Database ID** -Arbitration.  
> To disable a non-arbitration mailbox so that you can delete the mailbox database, run the command Disable-Mailbox **Mailbox ID**. To disable an archive mailbox so you can delete the mailbox database, run the command Disable-Mailbox **Mailbox ID** -Archive. To disable a public folder mailbox so that you can delete the mailbox database, run the command Disable-Mailbox **Mailbox ID** -PublicFolder. Arbitration mailboxes should be moved to another server; to do this, run the command New-MoveRequest **Parameters**. If this is the last server in the organization, run the command Disable-Mailbox **Mailbox ID** -Arbitration -DisableLastArbitrationMailboxAllowed to disable the arbitration mailbox.
Mailbox plans should be moved to another server; to do this, run the command Set-MailboxPlan **MailboxPlan ID**  -Database **Database ID**.  
> \+ CategoryInfo : InvalidOperation: (**Database ID** :DatabaseIdParameter) [Remove-MailboxDatabase], AssociatedUserMailboxExistException  
> \+ FullyQualifiedErrorId : [Server= **Server**,RequestId= **RequestId**,TimeStamp= **TimeStamp** ]  [FailureCategory=Cmdlet-AssociatedUserMailboxExistException] **XXXXXXXX**,Microsoft.Exchange.Management.SystemConfigurationTasks.RemoveMailboxDatabase  
> \+ PSComputerName : **Computer Name**

Or

> This mailbox database contains one or more mailboxes, mailbox plans, archive mailboxes, public folder mailboxes arbitration mailboxes, or audit mailboxes. To get a list of all mailboxes in this database, run the command Get-Mailbox -Database \<Database ID>. To get a list of all mailbox plans in this database, run the command Get-MailboxPlan. To get a list of archive mailboxes in this database, run the command Get-Mailbox -Database \<Database ID> -Archive. To get a list of all public folder mailboxes in this database, run the command Get-Mailbox -Database \<Database ID> -PublicFolder. To get a list of all arbitration mailboxes in this database, run the command Get-Mailbox -Database \<Database ID> -Arbitration. To get a list of all Audit mailboxes in this database, run the command Get-Mailbox -Database \<Database ID> -AuditLog. To disable a non-arbitration mailbox so that you can delete the mailbox database, run the command Disable-Mailbox \<Mailbox ID>. To disable an archive mailbox so you can delete the mailbox database, run the command Disable-Mailbox \<Mailbox ID> -Archive. To disable a public folder mailbox so that you can delete the mailbox database, run the command Disable-Mailbox \<Mailbox ID> -PublicFolder. Audit mailboxes should be moved to another server; to do this, run the command New-MoveRequest \<parameters>. If this is the last server in the organization, run the command Get-Mailbox -AuditLog | Disable-Mailbox. Arbitration mailboxes should be moved to another server; to do this, run the command New-MoveRequest \<parameters>. If this is the last server in the organization, run the command Disable-Mailbox \<Mailbox ID> -Arbitration -DisableLastArbitrationMailboxAllowed to disable the arbitration mailbox. Mailbox plans should be moved to another server; to do this, run the command Set-MailboxPlan \<MailboxPlan ID> -Database

## Cause

This issue occurs because Exchange Server 2016 introduces an AuditLog mailbox. This mailbox may be still present and blocking removal of the database.

## Resolution

To fix this issue, use the `Get-Mailbox` cmdlet together with the `-AuditLog` parameter to determine whether the AuditLog mailbox is still present. To do this, run the following cmdlet in the Exchange Management Shell:

```powershell
Get-Mailbox -AuditLog -Database <DatabaseName>
```

If the AuditLog mailbox is present, move the mailbox to a different database, or remove or disable it.
