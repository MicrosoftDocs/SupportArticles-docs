---
title: Proxy address conflict when adding an email address in Exchange Online
description: Discusses how to resolve a proxy address conflict that occurs when you try to add an email address for a mail recipient in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Recipients management
  - Exchange Online
  - CSSTroubleshoot
  - CI 165756
ms.reviewer: alexaca, batre, nualex, meerak, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 07/17/2024
---
# Proxy address conflict when adding an email address in Exchange Online

## Symptoms

When you try to assign a proxy address to a new or existing mail recipient in Exchange Online, you receive an error message that resembles one of the following examples.

**Error 1**

> The proxy address "SMTP:\<conflicting SMTP address\>" is already being used by "\<domain\>.prod.outlook.com/Microsoft Exchange Hosted Organizations/contoso.onmicrosoft.com/\<forest\>". Choose another proxy address.

**Error 2**

> A Microsoft Entra ID call was made to keep object in sync between Microsoft Entra ID and Exchange Online. However, it failed. Detailed error message: Another object with the same value for property proxyAddresses already exists. ConflictingObject: PublicFolder\_\<GUID\>.

Examples of a mail recipient include a mail user, user mailbox, shared mailbox, distribution group, Microsoft 365 Group, and mail-enabled public folder (MEPF).

## Cause

**Cause 1**

The first error message occurs if a mail-enabled object in Exchange Online uses the proxy address that you want to assign.

**Cause 2**

The second error message occurs if an MEPF object that exists only in Microsoft Entra ID uses the proxy address that you want to assign.

## Resolution

The resolution for the first error is to [check for and remove any conflicting proxy address in Exchange Online](#check-for-and-remove-any-conflicting-proxy-address-in-exchange-online).

The resolution for the second error is to [check for and remove any conflicting proxy address in Exchange Online](#check-for-and-remove-any-conflicting-proxy-address-in-exchange-online) and to [check for and remove any conflicting proxy address in Microsoft Entra ID](#check-for-and-remove-any-conflicting-proxy-address-in-azure-ad).

Use the appropriate resolution, depending on the error message that you receive. Then, try to assign the proxy address again.

#### Check for and remove any conflicting proxy address in Exchange Online

Follow these steps to search for existing mail-enabled objects in Exchange Online that use the conflicting proxy address.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. To list all mail recipients that use the conflicting SMTP address, run the following command:

   ```powershell
   Get-EXORecipient -ResultSize unlimited | Where-Object {$_.EmailAddresses -match "<conflicting SMTP address>"} | fl Name, RecipientType, EmailAddresses
   ```

   If you don't know the exact SMTP address, run the following command instead:

   ```powershell
   Get-EXORecipient -ResultSize unlimited | Where-Object {$_.EmailAddresses -match "<partial conflicting SMTP address>"} | fl Name, RecipientType, EmailAddresses
   ```

3. A proxy address can be assigned to only one object at a time. After you determine which object is in conflict, remove or change the proxy address that's associated with that object.

   For example, if the object is a mail-enabled public folder, run the following command to disable the public folder to free up the email address that's used:

   ```powershell
   Get-MailPublicFolder -ResultSize Unlimited | Where-Object {$_.EmailAddresses -match "<conflicting SMTP address>"} | Disable-MailPublicFolder
   ```

<a name='check-for-and-remove-any-conflicting-proxy-address-in-azure-ad'></a>

#### Check for and remove any conflicting proxy address in Microsoft Entra ID

> [!IMPORTANT]
> This resolution requires an on-premises server with Microsoft Entra Connect installed. If your on-premises infrastructure is decommissioned, contact [Microsoft Support](https://support.microsoft.com/).

Follow these steps to check for and remove from Microsoft Entra any MEPFs that use the conflicting proxy address. These steps require an on-premises server that runs Microsoft Entra Connect version 2.0 or a later version.

1. Search for the conflicting proxy address in all on-premises MEPFs by running the following command in the on-premises Exchange Management Shell (EMS):

   ```powershell
   Get-MailPublicFolder -ResultSize Unlimited | Where-Object {$_.EmailAddresses -match "<conflicting SMTP address>"}
   ```

2. For each on-premises MEPF that's identified in step 1, remove the conflicting SMTP address by running the following command in the on-premises EMS:

   ```powershell
   Set-MailPublicFolder -Identity <public folder name or GUID> -EmailAddresses @{remove="<conflicting SMTP address>"} -EmailAddressPolicyEnabled:$false
   ```

   This step removes any proxy address conflicts on the on-premises side to make sure that they aren't synced to Microsoft Entra ID or Exchange Online.

3. If you removed a conflicting SMTP address from any on-premises MEPF in step 2, wait until the next scheduled sync runs on the Microsoft Entra Connect server, or manually start a [sync cycle](/azure/active-directory/hybrid/how-to-connect-sync-feature-scheduler#full-sync-cycle) by running the following PowerShell command:

   ```powershell
   Start-ADSyncSyncCycle -PolicyType Delta
   ```

   The sync should remove the conflicting SMTP address from Microsoft Entra ID.

4. If you didn't find the conflicting SMTP address in any on-premises MEPF, or if the sync didn't remove the conflicting SMTP address from Microsoft Entra ID, search Microsoft Entra ID for MEPFs that have the conflicting SMTP address. To search for MEPFs in Microsoft Entra ID, use the [Get-ADSyncToolsAadObject](/azure/active-directory/hybrid/reference-connect-adsynctools#example-1-12) PowerShell cmdlet on the Microsoft Entra Connect server. The search is case-insensitive. Include the "smtp:" prefix when you specify the SMTP address.

   ```powershell
   $mailEnabledPublicFolders = Get-ADSyncToolsAadObject -SyncObjectType "PublicFolder" -Credential (Get-Credential)
   ```

   ```powershell
   $conflictingSmtpAddress = "smtp:<conflicting SMTP address>"
   ```

   ```powershell
   $mailEnabledPublicFolders | Where-Object {$_.ProxyAddresses -icontains $conflictingSmtpAddress} | Select SourceAnchor
   ```

   The search results provide the [SourceAnchor](/azure/active-directory/hybrid/plan-connect-design-concepts#sourceanchor) for each MEPF that meets the search criteria.

5. For each MEPF that's identified in step 4, remove the MEPF from Microsoft Entra ID by using the [Remove-ADSyncToolsAadObject](/azure/active-directory/hybrid/reference-connect-adsynctools#remove-adsynctoolsaadobject) cmdlet. Supply the `SourceAnchor` value of the MEPF in Base64 format.

   ```powershell
   $conflictingSourceAnchor= "SourceAnchor value"
   ```

   ```powershell
   Remove-ADSyncToolsAadObject -SourceAnchor $conflictingSourceAnchor -SyncObjectType "PublicFolder" -Credentials (Get-Credential)
   ```

   For a cmdlet usage example, see [Remove-ADSyncToolsAadObject example 2](/azure/active-directory/hybrid/reference-connect-adsynctools#example-2-14).

6. Rerun the Microsoft Entra ID search from step 4. This time, the search results shouldn't return any MEPFs.
