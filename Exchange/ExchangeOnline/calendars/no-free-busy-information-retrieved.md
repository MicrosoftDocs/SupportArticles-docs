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

When you try to view the free/busy information of a user in another organization by using organization relationships, the information isn't displayed.

Additionally, you might see one of the following error messages that is displayed with the **ErrorMailRecipientNotFound** response.

## Error 1: Unable to resolve e-mail address to an Active Directory object

You try to view the free/busy information for a user in another organization, you receive the following error message:

> Microsoft.Exchange.InfoWorker.Common.Availability.MailRecipientNotFoundException: **Unable to resolve e-mail address `user@northamerica.contoso.com` to an Active Directory object.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>.

### Cause

This error occurs in one of the following situations if the recipient email address is valid:

- An organization relationship isn't established with the domain.
- An organization relationship is established with the domain, but the free/busy access isn't enabled.

    **Note**: This scenario occurs only between two Microsoft 365 organizations.

### Resolution

Run the following [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to get the domains with which an organization relationship has been set up:

```powershell
Get-OrganizationRelationship | ft name, domainnames
```

- If the domain isn't included in the returned result, [create an organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship) with the domain, or [add the domain to an existing organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship#use-the-exchange-admin-center-to-create-an-organization-relationship).

- If the domain is included in the returned result, run the  [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to enable the free/busy access. For example:

    ```powershell
    Set-OrganizationRelationship -Identity "Contoso" -FreeBusyAccessEnabled $true
    ```

## Error 2: The organization relationship can't be used

You try to view the free/busy information for a user in another organization, you receive the following error message:

> The mail recipient is not found in Active Directory., inner exception: Microsoft.Exchange.InfoWorker.Common.Availability.InvalidOrganizationRelationshipForRequestDispatcherException: **The organization relationship \<name of the organization relationship\> can't be used. Please confirm that the organization relationship is configured correctly.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>.

### Cause

This error occurs because the values of the following parameters aren't set correctly in the organization relationship:

- `TargetApplicationUri`
- `TargetAutodiscoverEpr` or `TargetSharingEpr`(at least one of these values isn't set correctly)

### Resolution

Run the [Get-FederationInformation](/powershell/module/exchange/get-federationinformation) cmdlet to get the federation information of the domain from Exchange Online. For example:

:::image type="content" source="media/no-free-busy-information-retrieved/federation-information.png" alt-text="Screenshot that shows the federation information of a domain after running the Get-FederationInformation cmdlet.":::

Then, run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to check the parameters value of the organization relationship. If any value is set incorrectly, use the [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to set these parameters with the required values. For example:

```powershell
Set-OrganizationRelationship -Identity "Contoso" -TargetAutodiscoverEpr "<Value from the federation information>" -TargetApplicationUri "<Value from the federation information>"
```
