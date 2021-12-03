---
title: ErrorMailRecipientNotFound when viewing free/busy information
description: Fixes ErrorMailRecipientNotFound response that occurs when viewing free/busy information of a user in another organization.
author: v-charloz
audience: ITPro
ms.service: exchange-online
ms.topic: troubleshooting
ms.author: v-chazhang
ms.custom: 
- CI 157711
- Exchange Online
- CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Exchange Server 2013
- Exchange Server 2016
- Exchange Server 2019
---

# ErrorMailRecipientNotFound response when viewing free/busy information

When you try to view the free/busy information for a user in another forest or tenant by using organization relationships, the information isn't displayed. Instead, you see the **ErrorMailRecipientNotFound** response and one of the following error messages.

## Error: Unable to resolve e-mail address to an Active Directory object

A sample of the complete error message is as follows:

> "Microsoft.Exchange.InfoWorker.Common.Availability.MailRecipientNotFoundException: **Unable to resolve e-mail address `user@northamerica.contoso.com` to an Active Directory object.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>."

### Cause

This error occurs in one of the following situations after the user's email address is determined to be valid:

- An organization relationship isn't established with the user's domain.
- An organization relationship is established with the user's domain, but access to the free/busy information isn't enabled.

    **Note**: This scenario occurs only between two Microsoft 365 organizations.

### Resolution

Run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to see the list of domains for which an organization relationship has been set up:

```powershell
Get-OrganizationRelationship | ft name, domainnames
```

- If the user's domain isn't included in the returned result, [create an organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship) with the domain, or [add the domain to an existing organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship#use-the-exchange-admin-center-to-create-an-organization-relationship).

- If the user's domain is included in the returned result, run the  [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to enable access to the free/busy information for the domain.

    ```powershell
    Set-OrganizationRelationship -Identity "<User's Domain Name>" -FreeBusyAccessEnabled $true
    ```

## Error: The organization relationship can't be used

A sample of the complete error message is as follows:

> "The mail recipient is not found in Active Directory., inner exception: Microsoft.Exchange.InfoWorker.Common.Availability.InvalidOrganizationRelationshipForRequestDispatcherException: **The organization relationship \<name of the organization relationship\> can't be used. Please confirm that the organization relationship is configured correctly.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>."  

### Cause

This error occurs when the values of any or all of the following parameters in the organization relationship aren't set correctly:

- `TargetApplicationUri`
- `TargetAutodiscoverEpr` or `TargetSharingEpr`

### Resolution

1. Run the [Get-FederationInformation](/powershell/module/exchange/get-federationinformation) cmdlet either in Exchange Online or on Exchange on-premises as appropriate to get federation information for the user's domain.

For example, if the user's domain name on Exchange Online is `northamerica.contoso.com`, run:

```powershell
Get-FederationInformation northamerica.contoso.com
```

The following is a sample of the output you'll see:

If the user's domain is on Exchange on-premises , run the `Get-FederationInformation` cmdlet on the routing domain "`<user's domain_name>.mail.onmicrosoft.com`". For example, if the user's domain name is contoso, run:

```powershell
Get-FederationInformation contoso.mail.onmicrosoft.com
```

The following is a sample of the output you'll see:

1. Run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to check the values of the three parameters in the organization relationship. For any parameters whose values don't match those in the output from the `Get-FederationInformation` cmdlet, use the [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to correct them. For example:

    ```powershell
    Set-OrganizationRelationship -Identity "<User's Domain Name>" -TargetAutodiscoverEpr "<Value of this parameter from the federation information>" -TargetApplicationUri "<Value of this parameter from the federation information>"
    ```
