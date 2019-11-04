---
title: How to recover when a mailbox exists in both Exchange Online and on-premises
description: This article describes an issue in which a mailbox that exists in both Exchange Online and on-premises. Provides two solutions.
author: TobyTu
ms.author: benwinz
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
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

In a Microsoft Exchange Server hybrid deployment, a user may have a mailbox in both Exchange Online and an Exchange on-premises organization. This isn’t a desired state for a hybrid organization because it will create mail flow issues. In this case, messages will be delivered to the mailbox that corresponds to the location of the sender. If the sender is located in your on-premises organization, messages will be delivered to the on-premises mailbox. If the sender is located in your Exchange Online tenant, messages will be delivered to the Exchange Online mailbox.

## How to improve the situation

To correct this mail flow issue, we recommend that you refer to the methods that are provided in this article. Other possible options use recovery methods that are not guaranteed to work. As Office 365 continues to evolve and new features are added, additional options may be possible. This article will be updated to reflect additional corrective methods as they become available.

### Scenario 1: Keep Exchange Online mailbox

This scenario would be most applicable if the user mailbox was previously migrated to Exchange Online, and somehow the old mailbox was reconnected or a new mailbox was provisioned on-premises. To use this method, follow these steps:

1. Save the on-premises mailbox information to a file, such as "SMTP addresses," "Exchange attributes," and so on.

2. Set the PowerShell Format enumeration limit to "unlimited" to make sure that no attribute values are truncated. For example:

    ```powershell
    $formatenumerationlimit = -1
    Get-Mailbox “mailbox identity” | fl > mailboxinfo.txt
    ```

3. Disconnect the on-premises mailbox:

    ```powershell
    Disable-Mailbox “mailbox identity”
    ```

4. Enable the on-premises user as a remote mailbox:

    ```powershell
    Enable-RemoteMailbox “user identity” -RemoteRoutingAddress user@contoso.mail.onmicrosoft.com
    ```

5. Restore any custom proxy addresses and any other Exchange attributes that were stripped when the mailbox was disabled (compare to the **Get-Mailbox** command from step 1).

6. (Optional) Stamp the Exchange Online GUID on the remote mailbox (required if you ever want to offboard the mailbox back to on-premises).

    ```powershell
    Set-RemoteMailbox “user identity” -ExchangeGuid “Exchange guid value of Exchange Online mailbox”
    ```

7. Restore the contents of the disconnected mailbox to Exchange Online.

    ```powershell
    $cred = Get-Credential
    New-MailboxRestoreRequest -RemoteHostName mail.contoso.com -RemoteCredential $cred -SourceStoreMailbox “exchange guid of disconnected mailbox” -TargetMailbox “exchange guid of cloud mailbox” -RemoteDatabaseGuid “guid of on-premises database” -RemoteRestoreType DisconnectedMailbox
    ```

### Scenario 2: Remove Exchange Online mailbox data

The mailbox information in Office 365 may no longer be needed. In this case, see [this Exchange Team Blog article](https://techcommunity.microsoft.com/t5/Exchange-Team-Blog/Permanently-Clear-Previous-Mailbox-Info/ba-p/607619) for more information about how to remove the Exchange Online mailbox information completely.
