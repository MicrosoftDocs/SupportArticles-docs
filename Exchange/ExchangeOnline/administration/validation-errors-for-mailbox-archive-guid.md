---
title: Validation errors for a mailbox archive GUID for Microsoft 365 users
description: You receive a validation error in the Microsoft 365 admin center or in Microsoft Entra ID.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.reviewer: kellybos, v-six
ms.date: 01/24/2024
---
# Validation errors for a mailbox archive GUID for Microsoft 365 users

_Original KB number:_ &nbsp; 4053483

## Symptoms

An administrator who signs in to Microsoft 365 admin center or Microsoft Entra ID may receive the following validation errors for some users:

> "Failed to sync the ArchiveGuid \<GUID> of mailboxMailboxGuid because one cloud archiveCloudArchiveGuid exists."

> "Failed to enable the new cloud archiveCloudArchiveGuid of mailboxMailboxGuid because a different archiveArchiveGuid exists. To enable the new archive, first disable the archive on-premises. After the next Dirsync sync cycle, enable the archive on-premises again."

In this situation, updates to other property values of these users can't be synchronized from Microsoft Entra ID to Exchange Online.

## Resolution

Update the `msExchArchiveGUID` (`ArchiveGUID`) property value in the on-premises organization to match the Exchange Online value. To do this, follow the steps for the scenario that corresponds to your on-premises configuration.

### Scenario 1: You still have an Exchange server running in the on-premises organization

Here's how to keep the `ArchiveGuid` property value consistent between Exchange environments:

1. Run the following cmdlets from the Exchange Management Shell to retrieve information about `ArchiveGuid` and `RecipientTypeDetails`:

    ```powershell
    Get-Recipient -Identity user@contoso.com | fl ArchiveGuid, RecipientTypeDetails
    ```

2. Run these cmdlets to update the value based on different situations, as follows:

    - **Situation 1**: The `RecipientTypeDetails` property is set to `RemoteUserMailbox` and the `ArchiveGuid` property is set to **0**:

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

    - **Situation 3**: The `RecipientTypeDetails` property value isn't `RemoteUserMailbox` (no remote mailbox is enabled for the affected user):

        ```powershell
         Enable-RemoteMailbox user@contoso.com -RemoteRoutingAddress user@contoso.mail.onmicrosoft.com
        ```

        ```powershell
         Enable-RemoteMailbox user@contoso.com -Archive
        ```

        ```powershell
         Set-RemoteMailbox -Identity user@contoso.com -ArchiveGuid <Cloud ArchiveGUID>
        ```

### Scenario 2: You no longer have any Exchange server running in on-premises, but you still have Exchange-related attributes in AD

In this scenario, you must install an Exchange server to manage the Exchange-related attributes for synchronized users.

> [!NOTE]
> Managing the Exchange attributes for cloud users from the Active Directory PowerShell or from ADSIEDIT isn't supported. We strongly recommend that you keep at least one active Exchange server in AD to manage the Exchange attributes for synchronized users. For more information, see the "Can third-party management tools be used?" section of [How and when to decommission your on-premises Exchange servers in a hybrid deployment](/exchange/decommission-on-premises-exchange#can-third-party-management-tools-be-used).

To update the `ArchiveGuid` property value, run the following cmdlets from Active Directory PowerShell in a domain controller:

```powershell
Import-Module ActiveDirectory
```

```powershell
[guid]$guid = "Cloud ArchiveGUID"
```

```powershell
Get-ADUser <user alias> | Set-ADUser -Replace @{msExchArchiveguid=$guid.tobytearray()}
```
