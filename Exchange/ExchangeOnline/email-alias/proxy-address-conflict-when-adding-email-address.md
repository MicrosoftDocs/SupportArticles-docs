---
title: Proxy address conflict when adding an email address in Exchange Online
description: Describes how you can resolve a proxy address conflict that occurs when you try to add an email address for a mail recipient in Exchange Online.
author: v-trisshores
ms.author: v-trisshores
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 165756
ms.reviewer: alexaca, batre, nualex, meerak
appliesto: 
  - Exchange Online
  - Azure Active Directory
search.appverid: MET150
ms.date: 10/18/2022
---
# Proxy address conflict when adding an email address in Exchange Online

## Symptoms

When you try to assign a proxy address in Exchange Online to a new or existing mail recipient, you get an error message similar to one of the following:

- > The proxy address "SMTP:\<conflicting SMTP address\>" is already being used by "\<domain\>.prod.outlook.com/Microsoft Exchange Hosted Organizations/contoso.onmicrosoft.com/\<forest\>". Choose another proxy address.

- > An Azure Active Directory call was made to keep object in sync between Azure Active Directory and Exchange Online. However, it failed. Detailed error message: Another object with the same value for property proxyAddresses already exists. ConflictingObject: PublicFolder\_\<GUID\>.

Examples of a mail recipient include a mail user, user mailbox, shared mailbox, distribution group, Microsoft 365 Group, and mail-enabled public folder (MEPF).

## Cause

The first error message can occur if a mail-enabled object in Exchange Online uses the proxy address you want to assign.

The second error message can occur if an MEPF object that exists only in Azure Active Directory (Azure AD) uses the proxy address you want to assign.

## Resolution

The resolution for the first error is to [check for and remove any conflicting proxy address in Exchange Online](#check-for-and-remove-any-conflicting-proxy-address-in-exchange-online).

The resolution for the second error is to [check for and remove any conflicting proxy address in Exchange Online](#check-for-and-remove-any-conflicting-proxy-address-in-exchange-online) and to [check for and remove any conflicting proxy address in Azure AD](#check-for-and-remove-any-conflicting-proxy-address-in-azure-ad).

Use the appropriate resolution depending on the error message you received. Then retry assigning the proxy address.

#### Check for and remove any conflicting proxy address in Exchange Online

The following steps search for existing mail-enabled objects in Exchange Online that use the conflicting proxy address.

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. To list all mail recipients that use the conflicting SMTP address, run the command:

   ```powershell
   Get-EXORecipient -ResultSize unlimited | Where-Object {$_.EmailAddresses -match "<conflicting SMTP address>"} | fl Name, RecipientType, EmailAddresses
   ```

   However, if you don't know the exact SMTP address, you can run this command:

   ```powershell
   Get-EXORecipient -ResultSize unlimited | Where-Object {$_.EmailAddresses -match "<partial conflicting SMTP address>"} | fl Name, RecipientType, EmailAddresses
   ```

3. A proxy address can only be assigned to one object at a time. After you determine which object is in conflict, remove or change the proxy address that's associated with that object.

#### Check for and remove any conflicting proxy address in Azure AD

The following steps check for and remove any MEPFs with the conflicting proxy address from Azure AD. The steps require an on-premises server with Azure AD Connect version 2.0 or higher.

1. Search for the conflicting proxy address in all on-premises MEPFs by running the following command in the on-premises Exchange Management Shell (EMS):

   ```powershell
   Get-MailPublicFolder -ResultSize Unlimited | Where-Object {$_.EmailAddresses -match "<conflicting SMTP address>"}
   ```

2. For each on-premises MEPF identified in step 1, remove the conflicting SMTP address by running the following command in the on-premises EMS:

   ```powershell
   Set-MailPublicFolder -Identity <public folder name or GUID> -EmailAddresses @{remove="<conflicting SMTP address>"} -EmailAddressPolicyEnabled:$false
   ```

   The purpose of this step is to remove any proxy address conflicts on the on-premises side to ensure they aren't synced into Azure AD or Exchange Online.

3. If you removed a conflicting SMTP address from any on-premises MEPF in step 2, wait for the next scheduled sync to run on the Azure AD Connect server, or manually start a [sync cycle](/azure/active-directory/hybrid/how-to-connect-sync-feature-scheduler#full-sync-cycle) using the following PowerShell command:

   ```powershell
   Start-ADSyncSyncCycle -PolicyType Delta
   ```

   The sync should remove the conflicting SMTP address from Azure AD.

4. If you didn't find the conflicting SMTP address in any on-premises MEPF, or the sync didn't remove the conflicting SMTP address from Azure AD, search for MEPFs with the conflicting SMTP address in Azure AD. To search MEPFs in Azure AD use the [Get-ADSyncToolsAadObject](/azure/active-directory/hybrid/reference-connect-adsynctools#example-1-12) PowerShell cmdlet on the Azure AD Connect server. The search is case-insensitive. Include the smtp: prefix when specifying the SMTP address:

   ```powershell
   $mailEnabledPublicFolders = Get-ADSyncToolsAadObject -SyncObjectType "PublicFolder" -Credential (Get-Credential)
   ```

   ```powershell
   $conflictingSmtpAddress = "smtp:<conflicting SMTP address>"
   ```

   ```powershell
   $mailEnabledPublicFolders | Where-Object {$_.ProxyAddresses -icontains $conflictingSmtpAddress} | Select SourceAnchor
   ```

   The returned search results provide the [SourceAnchor](https://microsoft-my.sharepoint.com/azure/active-directory/hybrid/plan-connect-design-concepts#sourceanchor) for each MEPF that meets the search criteria.

5. For each MEPF identified in step 4, remove the MEPF from Azure AD by using the [Remove-ADSyncToolsAadObject](/azure/active-directory/hybrid/reference-connect-adsynctools#remove-adsynctoolsaadobject) cmdlet. Supply the `SourceAnchor` value of the MEPF in Base64 format.

   ```powershell
   $conflictingSourceAnchor= "SourceAnchor value"
   ```

   ```powershell
   Remove-ADSyncToolsAadObject -SourceAnchor $conflictingSourceAnchor -SyncObjectType "PublicFolder" -Credentials (Get-Credential)
   ```

   For a cmdlet usage example, see [Remove-ADSyncToolsAadObject example 2](/azure/active-directory/hybrid/reference-connect-adsynctools#example-2-14).

6. Rerun the step 4 search in Azure AD. This time, the search results shouldn't return any MEPFs.

> [!NOTE]
> This resolution requires an on-premises server with Azure AD Connect installed. If your on-premises infrastructure is decommissioned, contact [Microsoft Support](https://support.microsoft.com/).
