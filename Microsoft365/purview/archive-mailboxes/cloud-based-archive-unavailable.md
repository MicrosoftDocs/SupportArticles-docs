---
title: Users can't access their cloud-based archive mailbox
description: Provides a resolution for an issue in which users in a hybrid Exchange environment can't use Outlook or Outlook on the web to access their cloud-based archive mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - Exchange Online
  - Exchange Server
  - CSSTroubleshoot
  - 'Associated content asset: 4555324'
  - CI 193457
ms.reviewer: alexaca, lusassl, meerak, v-shorestris
appliesto: 
  - Exchange Online Archiving
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 08/21/2024
---

# Users can't access their cloud-based archive mailbox

_Original KB number:_ &nbsp; 2860302

## Symptoms

Users in your hybrid Exchange environment who have a cloud-based archive mailbox encounter one or both of the following issues.

### Issue 1

Users can't [access their archive mailbox](/exchange/policy-and-compliance/in-place-archiving/in-place-archiving#client-access-to-archive-mailboxes) in Microsoft Outlook even though the archive mailbox exists in their Outlook profile.

### Issue 2

When users try to access their archive mailbox in Outlook on the web, they receive the following error message:

> Your archive appears to be unavailable. Try to access it again in 10 seconds. If you see this error again, contact your Help Desk.

## Cause

Issue 1 can occur because of Cause 1. Issue 2 can occur because of either Cause 1 or Cause 2.

### Cause 1

One or more root certificates on a Windows server that runs Microsoft Exchange Server are missing or corrupted. Root certificates are necessary to validate the on-premises side of your hybrid environment.

### Cause 2

One or more settings are misconfigured:

- Domains are missing from the [Exchange Online organization relationship](/exchange/sharing/organization-relationships/organization-relationships) because the organization relationship parameters, `TargetApplicationUri` and `TargetAutodiscoverEpr`, have incorrect values.

- The domain in the primary SMTP address of the on-premises [FederatedEmail arbitration mailbox](/exchange/architecture/mailbox-servers/recreate-arbitration-mailboxes) isn't a federated domain. 

  **Note**: The primary SMTP address is stored in the `PrimarySMTPAddress` parameter of a mailbox.

- The domain in the user's primary SMTP address doesn't exist in the [federated organization identifier](/powershell/module/exchange/get-federatedorganizationidentifier).

## Resolution

For either issue, complete the resolution for Cause 1. If users experience Issue 2 after you complete the resolution for Cause 1, also complete the resolution for Cause 2.

### Resolution for Cause 1

1. Update the root certificates on the Windows servers that run Exchange Server.

2. Rerun the [Hybrid Configuration Wizard](/exchange/hybrid-configuration-wizard) to update the hybrid Exchange environment.

### Resolution for Cause 2

1. Verify that the domain in the user's primary SMTP address is in the cloud organization relationship. Run the following PowerShell cmdlet to list the domains in the cloud organization relationship:

   ```PowerShell
   (Get-OrganizationRelationship -Identity "<name of organization relationship>").DomainNames
   ```

   > [!NOTE]
   > For information about how to add a domain to the organization relationship, see [Modify an organization relationship in Exchange Online](/exchange/sharing/organization-relationships/modify-an-organization-relationship).

2. Run the following cmdlet both to verify that the FederatedEmail arbitration mailbox exists and to determine the primary SMTP address of the mailbox:

   ```PowerShell
   (Get-Mailbox -Identity "FederatedEmail.4c1f4d8b-8179-4148-93bf-00a95fa1e042" -Arbitration).EmailAddresses
   ```

   For information about how to re-create a missing arbitration mailbox, see [Re-create missing arbitration mailboxes](/exchange/architecture/mailbox-servers/recreate-arbitration-mailboxes).

3. Verify that the domain in the primary SMTP address of the FederatedEmail arbitration mailbox is included in the list of domains for the cloud organization relationship from step 1.

4. Use the following steps to verify that the `msExchOrgFederatedMailbox` attribute in on-premises Active Directory is set to the primary SMTP address of the FederatedEmail arbitration mailbox. The domain in the primary SMTP address must be a federated domain.

   1. Run the following PowerShell cmdlet to determine the value of the `msExchOrgFederatedMailbox` attribute:

      ```PowerShell
      Get-ADObject -SearchBase "CN=Transport Settings,CN=<organization name>,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=contoso,DC=com" -Filter 'ObjectClass -eq "msExchTransportSettings"' -Properties msExchOrgFederatedMailbox
      ```

      **Note:** In this cmdlet, substitute your domain for `contoso`.

   2. If the `msExchOrgFederatedMailbox` attribute value isn't set correctly, run the following PowerShell cmdlet to correct it:

      ```PowerShell
      Set-ADObject -Identity "CN=Transport Settings,CN=<organization name>,CN=Microsoft Exchange,CN=Services,CN=Configuration,DC=contoso,DC=com" -Replace @{msExchOrgFederatedMailbox="FederatedEmail.4c1f4d8b-8179-4148-93bf-00a95fa1e042@contoso.com"}
      ```

      **Note**: In this cmdlet, substitute your domain for `contoso`.

5. Run the following PowerShell cmdlet to verify that the values of the `TargetAutodiscoverEpr` and `TargetApplicationUri` parameters in the organization relationship are correct:

   ```PowerShell
   Get-OrganizationRelationship | FL Name,Target*
   ```

   - `TargetAutodiscoverEpr` parameter value should be `https://autodiscover-s.outlook.com/autodiscover/autodiscover.svc/WSSecurity`.
   - `TargetApplicationUri` parameter value should be `outlook.com`.

6. Verify that none of the following PowerShell cmdlets return the error message "Federation information could not be received from the external organization":

   ```PowerShell
   - Get-FederationInformation contoso.com -Verbose -BypassAdditionalDomainValidation | FL
   - Get-FederationInformation contoso.onmicrosoft.com -Verbose | FL
   - Get-FederationInformation contoso.mail.onmicrosoft.com -Verbose | FL
   ```

   Note: In these cmdlets, substitute your domain for `contoso`.

7. Run the following PowerShell cmdlet to verify that the domains that are listed in the command output include the domain in the user's primary SMTP address:

   ```PowerShell
   Get-FederatedOrganizationIdentifier | FL Domains
   ```

After you complete these steps, ask users to try again to access their archive mailbox.
