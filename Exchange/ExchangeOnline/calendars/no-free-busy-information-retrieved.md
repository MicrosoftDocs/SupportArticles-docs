---
title: ErrorMailRecipientNotFound when viewing free/busy information
description: Fixes the ErrorMailRecipientNotFound response that occurs when viewing free/busy information of a user in another organization.
audience: ITPro
ms.topic: troubleshooting
author: cloud-writer
ms.author: meerak
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
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
ms.reviewer: v-chazhang
---

# ErrorMailRecipientNotFound response when viewing free/busy information

When you try to view the free/busy information for a user in another forest or tenant by using organization relationships, the information isn't displayed. Instead, you see the **ErrorMailRecipientNotFound** response and one of the following error messages.

## Error 1: "Unable to resolve e-mail address to an Active Directory object"

A sample of the complete error message is as follows:

> "Microsoft.Exchange.InfoWorker.Common.Availability.MailRecipientNotFoundException: **Unable to resolve e-mail address `user@northamerica.contoso.com` to an Active Directory object.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>."

### Cause

This error occurs in one of the following situations after the user's email address is determined to be valid:

- An organization relationship isn't established with the user's domain.
- An organization relationship is established with the user's domain, but access to the free/busy information isn't enabled.

    **Note**: This scenario occurs only between two Microsoft 365 organizations.

### Resolution

Run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to see the list of domains for which an organization relationship was set up:

```powershell
Get-OrganizationRelationship | ft name, domainnames
```

- If the user's domain isn't included in the returned result, [create an organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship) with the domain, or [add the domain to an existing organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship#use-the-exchange-admin-center-to-create-an-organization-relationship).

- If the user's domain is included in the returned result, run the  [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to enable access to the free/busy information for the domain.

    ```powershell
    Set-OrganizationRelationship -Identity "<User's Domain Name>" -FreeBusyAccessEnabled $true
    ```

## Error 2: "The organization relationship can't be used"

A sample of the complete error message is as follows:

> "The mail recipient is not found in Active Directory., inner exception: Microsoft.Exchange.InfoWorker.Common.Availability.InvalidOrganizationRelationshipForRequestDispatcherException: **The organization relationship \<name of the organization relationship\> can't be used. Please confirm that the organization relationship is configured correctly.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>."  

### Cause

This error occurs if the values of any or all the following parameters in the organization relationship aren't set correctly:

- `TargetApplicationUri`
- `TargetAutodiscoverEpr` or `TargetSharingEpr`

### Resolution

1. Run the [Get-FederationInformation](/powershell/module/exchange/get-federationinformation) cmdlet in either Exchange Online or Microsoft Exchange Server on-premises, as appropriate, to get federation information for the user's domain.

    For example, if a cloud user is trying to view the free/busy information for an on-premises user, and the user's domain name in Exchange Online is `northamerica.contoso.com`, run the following:

    ```powershell
    Get-FederationInformation northamerica.contoso.com
    ```

    The following is an example of the output:

    :::image type="content" source="media/no-free-busy-information-retrieved/output.png" alt-text="Screenshot that shows the federation information of a domain after running the Get-FederationInformation cmdlet in Exchange Online.":::

    If an on-premises user is trying to the view free/busy information for a cloud user, run the `Get-FederationInformation` cmdlet on the routing domain, "`<user's domain name>.mail.onmicrosoft.com`". For example, if the user's domain name is contoso, run the following:

    ```powershell
    Get-FederationInformation contoso.mail.onmicrosoft.com
    ```

    The following is an example of the output:

    :::image type="content" source="media/no-free-busy-information-retrieved/output-routing-domain.png" alt-text="Screenshot that shows the federation information of a domain after running the Get-FederationInformation cmdlet on the routing domain.":::

1. Run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to check the values of the three parameters in the organization relationship. For any parameters whose values don't match those in the output from the `Get-FederationInformation` cmdlet, use the [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to correct them. For example:

    ```powershell
    Set-OrganizationRelationship -Identity "<User's Domain Name>" -TargetAutodiscoverEpr "<Value of this parameter from the federation information>" -TargetApplicationUri "<Value of this parameter from the federation information>"
    ```
