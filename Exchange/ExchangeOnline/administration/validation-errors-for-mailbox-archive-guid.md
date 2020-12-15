---
title: Validation errors for a mailbox archive GUID for Microsoft 365 users
description: You receive a validation error in the Microsoft 365 admin center or in Azure Active Directory.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
  - CSSTroubleshoot
appliesto:
- Exchange Online
search.appverid: MET150
ms.reviewer: kellybos
---
# Validation errors for a mailbox archive GUID for Microsoft 365 users

_Original KB number:_ &nbsp; 4053483

## Symptoms

When you as an administrator sign into Microsoft 365 admin center or Azure Active Directory, you receive these validation errors for some users:

> "Failed to sync the ArchiveGuid <GUID> of mailboxMailboxGuid because one cloud archiveCloudArchiveGuid exists."

> "Failed to enable the new cloud archiveCloudArchiveGuid of mailboxMailboxGuid because a different archiveArchiveGuid exists. To enable the new archive, first disable the archive on-premises. After the next Dirsync sync cycle, enable the archive on-premises again."

In this situation, updates to other property values of those users can't be synchronized from Azure Active Directory to Exchange Online.

## Resolution

Update the `msExchArchiveGUID` (`ArchiveGUID`) property value in the on-premises to match the Exchange Online value.

Follow the steps listed under the scenario that corresponds to your on-premises configuration.

### Scenario 1: You still have an Exchange server running in the on-premises organization

Here's how to keep the ArchiveGuid property value consistent:

1. Run these cmdlets from Exchange Management PowerShell to retrieve information about `ArchiveGuid` and `RecipientTypeDetails`:

    ```powershell
    Get-Recipient -Identity user@contoso.com | fl ArchiveGuid, RecipientTypeDetails
    ```

2. Run theses cmdlets to update the value based on different situations:

    - **Situation 1**: The `RecipientTypeDetails` property is set to `RemoteUserMailbox` and the `ArchiveGuid` property isn't set (is zero):

        ```powershell
         Enable-RemoteMailbox user@contoso.com -Archive
        ```

        ```powershell
         Set-RemoteMailbox -Identity user@contoso.com -ArchiveGuid <Cloud ArchiveGUID>
        ```

    - **Situation 2**: The `RecipientTypeDetails` property is set to `RemoteUserMailbox` and the `ArchiveGuid` property is already populated:

        ```powershell
         Set-RemoteMailbox -Identity user@contoso.com -ArchiveGuid <Cloud ArchiveGUID>
        ```

    - **Situation 3**: The `RecipientTypeDetails` property isn't `RemoteUserMailbox`. That means no remote mailbox is enabled for the affected user:

        ```powershell
         Enable-RemoteMailbox user@contoso.com -RemoteRoutingAddress user@contoso.mail.onmicrosoft.com
        ```

        ```powershell
         Enable-RemoteMailbox user@contoso.com -Archive
        ```

        ```powershell
         Set-RemoteMailbox -Identity user@contoso.com -ArchiveGuid <Cloud ArchiveGUID>
        ```

### Scenario 2: You no longer have any Exchange server running in on-premises, but you still have Exchange-related attributes in Active Directory

Install an Exchange Server to manage the Exchange-related attributes for synchronized users.

> [!NOTE]
> Managing the Exchange attributes for cloud users from Active Directory PowerShell or from ADSIEDIT isn't supported. We strongly recommend keeping at least one active Exchange Server in Active Directory to manage the Exchange attributes for synchronized users. For more information, see the "Can third-party management tools be used?" section in [How and when to decommission your on-premises Exchange servers in a hybrid deployment](https://docs.microsoft.com/exchange/decommission-on-premises-exchange?redirectedfrom=MSDN#can-third-party-management-tools-be-used).

To update the `ArchiveGuid` property value, run these cmdlets from Active Directory PowerShell in a domain controller:

```powershell
Import-Module ActiveDirectory
```

```powershell
[guid]$guid = "Cloud ArchiveGUID"
```

```powershell
Get-ADUser <user alias> | Set-ADUser -Replace @{msExchArchiveguid=$guid.tobytearray()}
```
