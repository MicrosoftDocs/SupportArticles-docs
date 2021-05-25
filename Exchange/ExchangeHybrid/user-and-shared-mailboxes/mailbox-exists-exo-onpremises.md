---
title: How to recover when a mailbox exists in both Exchange Online and on-premises
description: This article describes an issue in which a mailbox that exists in both Exchange Online and on-premises. Provides two solutions.
author: simonxjx
ms.author: benwinz
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CI 105380
- CSSTroubleshoot
ms.reviewer: benwinz, EXOL_Triage
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Exchange Server 2019
- Exchange Server 2016
- Exchange Server 2013
---
# How to recover when a mailbox exists in both Exchange Online and on-premises

## Description

In a Microsoft Exchange Server hybrid deployment, a user may have a mailbox in both Exchange Online and an Exchange on-premises organization. This isn't a desired state for a hybrid organization because it will create mail flow issues. In this case, messages will be delivered to the mailbox that corresponds to the location of the sender. If the sender is located in your on-premises organization, messages will be delivered to the on-premises mailbox. If the sender is located in your Exchange Online tenant, messages will be delivered to the Exchange Online mailbox.

## How to improve the situation

To correct this mail flow issue, we recommend that you refer to the methods that are provided in this article. Other possible options use recovery methods that are not guaranteed to work. As Office 365 continues to evolve and new features are added, additional options may be possible. This article will be updated to reflect additional corrective methods as they become available.

### Scenario 1: Keep Exchange Online mailbox

This scenario would be most applicable if the user mailbox was previously migrated to Exchange Online, and somehow the old mailbox was reconnected or a new mailbox was provisioned on-premises. Another possible scenario is when an Exchange Online license is assigned prematurely, and a new cloud-only mailbox is created while the user already has an existing mailbox in Exchange on-premises. Be sure to read the important note at the end of step 7.

To use this method, follow these steps:

1. Save the on-premises mailbox information to a file, such as "SMTP addresses", "Exchange attributes", and so on.

2. Set the PowerShell Format enumeration limit to "unlimited" to make sure that no attribute values are truncated. For example:

    ```powershell
    $formatenumerationlimit = -1
    Get-Mailbox "mailbox identity" | fl > mailboxinfo.txt
    ```

3. Disconnect the on-premises mailbox:

    ```powershell
    Disable-Mailbox "mailbox identity"
    ```

4. Enable the on-premises user as a remote mailbox:

    ```powershell
    Enable-RemoteMailbox "user identity" -RemoteRoutingAddress "user@contoso.mail.onmicrosoft.com"
    ```

5. Restore any custom proxy addresses and any other Exchange attributes that were stripped when the mailbox was disabled (compare to the `Get-Mailbox` command from step 1).

6. (Optional) Stamp the Exchange Online GUID on the remote mailbox (required if you ever want to off board the mailbox back to on-premises).

    ```powershell
    Set-RemoteMailbox "user identity" -ExchangeGuid "Exchange guid value of Exchange Online mailbox"
    ```

7. Restore the contents of the disconnected mailbox to Exchange Online. For the Credentials, you must specify an on-premises Exchange admin account. To perform a remote restore, the administrator must have one of the following conditions:

   - A member of the Domain Admins group in Active Directory Domain Services (AD DS) in the on-premises organization.
   - A member of the Exchange Recipients Administrators group in Active Directory in the on-premises organization.
   - A member of the Organization Management or Recipient Management group in Exchange 2010 or above.

    ```powershell
    $cred = Get-Credential
    New-MailboxRestoreRequest -RemoteHostName "mail.contoso.com" -RemoteCredential $cred -SourceStoreMailbox "exchange guid of disconnected mailbox" -TargetMailbox "exchange guid of cloud mailbox" -RemoteDatabaseGuid "guid of on-premises database" -RemoteRestoreType DisconnectedMailbox
    ```

    > [!NOTE]
    > The remote restore isn't supported for Exchange 2010. The minimum supported version is Exchange 2013.

> [!IMPORTANT]
> Because `New-MailboxRestoreRequest` was designed to work in a single Exchange organization, the cross-premises restore jobs will fail due to an unavoidable mismatch between the source and target mailbox ExchangeGuid's.  The mailbox restore request will end in status "FailedOther", and the report (from `Get-MailboxRestoreRequestStatistics -IncludeReport`) will show the following error message in the final report Entry:

```powershell
Get-MailboxRestoreRequest "<mailbox's ID>" | `
Get-MailboxRestoreRequestStatistics -IncludeReport | `
select -ExpandProperty Report | `
select -ExpandProperty Entries | `
select -Last 2 | `
select -Last 1

CreationTime               : mmmm/dddd/yyyy 12:16:36 AM
ServerName                 : YTBPR01MB4016
Type                       : Error
TypeInt                    : 4
Flags                      : Failure, Fatal
FlagsInt                   : 18
Message                    : Fatal error RecipientNotFoundPermanentException has occurred.
MessageData                : {0, 1, 0, 0...}
MessageBytes               : {10, 29, 70, 97...}
Failure                    : RecipientNotFoundPermanentException: Cannot find a recipient that has mailbox
                             GUID '2ed5d0ca-54e2-4226-xxxx-a48848e18c0f'.
BadItem                    :
ConfigObject               :
MailboxSize                :
SessionStatistics          :
ArchiveSessionStatistics   :
MailboxVerificationResults : {}
DivergenceFixupResults     : {}
DebugData                  :
Connectivity               :
SourceThrottleDurations    :
TargetThrottleDurations    :
UnknownElements            :
UnknownAttributes          :
XmlSchemaType              :
LocalizedString            : mmmm/dddd/yyyy 12:16:36 AM [YTBPR01MB4016] Fatal error
                             RecipientNotFoundPermanentException has occurred.
Identity                   :
IsValid                    : True
ObjectState                : New
```

This failure can be disregarded and the job instead treated as a success, as long as the second to last entry in the report shows the correct number of items having been copied (e.g. Copy Progress: 5000/5000 messages, 2.34 GB/2.34 GB).  For example:

```powershell
Get-MailboxRestoreRequest "<mailbox's ID>" | `
Get-MailboxRestoreRequestStatistics -IncludeReport | `
select -ExpandProperty Report | `
select -ExpandProperty Entries | `
select -Last 2 | `
select -First 1

CreationTime               : mmmm/dddd/yyyy 12:16:36 AM
ServerName                 : YTBPR01MB4016
Type                       : Informational
TypeInt                    : 0
Flags                      : None
FlagsInt                   : 0
Message                    : Copy progress: 799/799 messages, 25 MB (26,215,094 bytes)/25 MB (26,215,094
                             bytes), 0/0 folders completed.
MessageData                : {0, 1, 0, 0...}
MessageBytes               : {10, 68, 67, 111...}
Failure                    :
BadItem                    :
ConfigObject               :
MailboxSize                :
SessionStatistics          :
ArchiveSessionStatistics   :
MailboxVerificationResults : {}
DivergenceFixupResults     : {}
DebugData                  :
Connectivity               :
SourceThrottleDurations    :
TargetThrottleDurations    :
UnknownElements            :
UnknownAttributes          :
XmlSchemaType              :
LocalizedString            : mmmm/dddd/yyyy 12:16:36 AM [YTBPR01MB4016] Copy progress: 799/799 messages, 25 MB
                             (26,215,094 bytes)/25 MB (26,215,094 bytes), 0/0 folders completed.
```

Any items reported in the BadItemsEncountered, LargeItemsEncountered, or MissingItemsEncountered properties (from `Get-MailboxRestoreRequestStatistics`) should be treated normally, as these would have been encountered regardless of whether the mailbox was migrated via migration batch / move request, or via New-MailboxRestoreRequest.

### Scenario 2: Remove Exchange Online mailbox data

The mailbox information in Office 365 may no longer be needed. In this case, see [this Exchange Team Blog article](https://techcommunity.microsoft.com/t5/Exchange-Team-Blog/Permanently-Clear-Previous-Mailbox-Info/ba-p/607619) for more information about how to remove the Exchange Online mailbox information completely.
