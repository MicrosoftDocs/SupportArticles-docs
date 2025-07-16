---
title: Resolve validation errors for an archive mailbox
description: Provides a resolution for an issue in which the Microsoft Entra admin center or the Microsoft 365 admin center display validation error messages for cloud users in a hybrid Exchange environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - CSSTroubleshoot
  - CI 193712
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.reviewer: apascual, lusassl, meerak, v-shorestris
ms.date: 08/21/2024
---

# Resolve validation errors for an archive mailbox

_Original KB number:_ &nbsp; 4053483

## Symptoms

For some user mailboxes in a hybrid Exchange environment, you find either of the following validation error messages in the Microsoft Entra admin center or Microsoft 365 admin center:

- > Failed to sync the ArchiveGuid \<GUID\> of mailboxMailboxGuid because one cloud archiveCloudArchiveGuid exists.

- > Failed to enable the new cloud archiveCloudArchiveGuid of mailboxMailboxGuid because a different archiveArchiveGuid exists. To enable the new archive, first disable the archive on-premises. After the next Dirsync sync cycle, enable the archive on-premises again.

Also, you can't update most property and attribute values of these mailboxes, and synchronization from Microsoft Entra ID to Exchange Online fails.

## Cause

For each affected user mailbox, the issue occurs if the `ArchiveGuid` property value in Microsoft Exchange Server doesn't match the `msExchArchiveGUID` attribute value in Exchange Online. The `ArchiveGuid` and `msExchArchiveGUID` values identify the archive mailbox that's associated with a user mailbox.

This inconsistency occurs if either of the following PowerShell cmdlets are run in the on-premises Exchange Management Shell (EMS) to enable an archive mailbox that was originally [enabled from Exchange Online](/purview/enable-archive-mailboxes):

- `Enable-RemoteMailbox <user mailbox ID> -Archive`
- `Enable-Mailbox <user mailbox ID> -RemoteArchive -ArchiveDomain <domain>.mail.onmicrosoft.com`

> [!IMPORTANT]
> For cloud mailboxes in an Exchange hybrid environment that are synchronized from on-premises Active Directory, enable archive mailboxes from Exchange Server, not from Exchange Online.

## Resolution

> [!NOTE]
> We recommend that you don't manage Exchange attributes for synchronized users by using Active Directory PowerShell or ADSI Edit. For more information, see [Manage recipients in Exchange Hybrid environments using Management tools](/exchange/manage-hybrid-exchange-recipients-with-management-tools?source=recommendations#will-this-new-method-work-for-me) and [Can third-party management tools be used?](/exchange/decommission-on-premises-exchange#can-third-party-management-tools-be-used)

To fix the issue, update the on-premises `ArchiveGuid` property value to match the Exchange Online `msExchArchiveGUID` attribute value. Follow these steps:

1. Run the following PowerShell cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to get the `msExchArchiveGUID` attribute value from Exchange Online:

   ```PowerShell
   Get-Mailbox -Identity <cloud user mailbox ID> | FL ArchiveGuid 
   ```

2. Run the following PowerShell cmdlet in the on-premises EMS to get the `RecipientTypeDetails` and `ArchiveGuid` parameter values:

   ```PowerShell
   Get-Recipient -Identity <user mailbox ID> | FL RecipientTypeDetails,ArchiveGuid
   ```

3. Depending on the `RecipientTypeDetails` and `ArchiveGuid` parameter values from step 2, select one of the following options:

   - If the `RecipientTypeDetails` property value is **RemoteUserMailbox** and the `ArchiveGuid` property value is all zeros, run the following PowerShell code in the on-premises EMS:

      ```PowerShell
      # Create an archive mailbox object for sync to the cloud.
      Enable-RemoteMailbox <user mailbox ID> -Archive
      # Set the ArchiveGuid parameter value of the user mailbox to the `msExchArchiveGUID` attribute value.
      Set-RemoteMailbox -Identity <user mailbox ID> -ArchiveGuid <msExchArchiveGUID attribute value>
      ```

   - If the `RecipientTypeDetails` property value is **RemoteUserMailbox** and the `ArchiveGuid` property value is not all zeros, run the following PowerShell code in the on-premises EMS:

      ```PowerShell
      # Set the ArchiveGuid parameter value of the user mailbox to the msExchArchiveGUID attribute value.
      Set-RemoteMailbox -Identity <user mailbox ID> -ArchiveGuid <msExchArchiveGUID attribute value>
      ```
