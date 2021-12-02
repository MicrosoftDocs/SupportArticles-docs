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

> "MessageText": "Microsoft.Exchange.InfoWorker.Common.Availability.MailRecipientNotFoundException: **Unable to resolve e-mail address `user@northamerica.contoso.com` to an Active Directory object.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>."  
>"ResponseCode": "**ErrorMailRecipientNotFound**"

### Cause

If the user's email address is valid, then this error occurs in one of the following situations:

- An organization relationship isn't established with the user's domain.
- An organization relationship is established with the user's domain, but access to the free/busy information isn't enabled..

    **Note**: This scenario occurs only between two Microsoft 365 organizations.

### Resolution

Run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to get the list of domains for which an organization relationship has been set up:

```powershell
Get-OrganizationRelationship | ft name, domainnames
```

- If the domain isn't included in the returned result, [create an organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship) with the domain, or [add the domain to an existing organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship#use-the-exchange-admin-center-to-create-an-organization-relationship).

- If the domain is included in the returned result, run the  [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to enable access to the free/busy information for the domain.

    ```powershell
    Set-OrganizationRelationship -Identity "<User Domain Name>" -FreeBusyAccessEnabled $true
    ```

## Error: The organization relationship can't be used

A sample of the complete error message is as follows:

> "MessageText": "The mail recipient is not found in Active Directory., inner exception: Microsoft.Exchange.InfoWorker.Common.Availability.InvalidOrganizationRelationshipForRequestDispatcherException: **The organization relationship \<name of the organization relationship\> can't be used. Please confirm that the organization relationship is configured correctly.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>."  
> "ResponseCode": "**ErrorMailRecipientNotFound**"

### Cause

This error occurs when the values of one of all of the following parameters in the organization relationship aren't set correctly:

- `TargetApplicationUri`
- `TargetAutodiscoverEpr` or `TargetSharingEpr`(at least one of these values isn't set correctly)

### Resolution

1. In Exchange Online, run the [Get-FederationInformation](/powershell/module/exchange/get-federationinformation) cmdlet to get the federation information of the user's domain.

    :::image type="content" source="media/no-free-busy-information-retrieved/federation-information.png" alt-text="Screenshot that shows the federation information of a domain after running the Get-FederationInformation cmdlet.":::

1. In Exchange Server on-premises, run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to check the values of the three parameters in the organization relationship. If any value is set incorrectly, use the [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to set them by using the output from the `Get_FederationInformation` cmdlet. For example:

    ```powershell
    Set-OrganizationRelationship -Identity "<User Domain Name>" -TargetAutodiscoverEpr "<Value from the federation information>" -TargetApplicationUri "<Value from the federation information>"
    ```
