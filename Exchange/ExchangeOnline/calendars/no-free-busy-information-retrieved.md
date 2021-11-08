---
title: ErrorMailRecipientNotFound when viewing free/busy information
description: Fixes ErrorMailRecipientNotFound ResponseCode that occurs when viewing free/busy information of a user in another organization by using Scheduling Assistant.
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

# ErrorMailRecipientNotFound ResponseCode and no free/busy information

An organization relationship that has delegated authentication configured is set up to share calendar information. When you try to view the free/busy information of a user in another organization by using Scheduling Assistant, no free/busy information is displayed.

Additionally, one of the following error messages is displayed with the **ErrorMailRecipientNotFound** ResponseCode in the response body of the `GetUserAvailabilityInternal` action. To view the error message, sign in to Outlook on the Web, open Developer Tools by pressing F12 and select the **Network** tab.

## Error 1: Unable to resolve e-mail address to an Active Directory object

> Microsoft.Exchange.InfoWorker.Common.Availability.MailRecipientNotFoundException: **Unable to resolve e-mail address `user@northamerica.contoso.com` to an Active Directory object.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>.

### Cause

This error occurs in one of the following situations:

- An organization relationship isn't established with the domain.
- An organization relationship is established with the domain, but the free/busy access isn't enabled.

    **Note**: This scenario occurs only between two Microsoft 365 organizations.

### Resolution

Run the following [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to get the domains with which an organization relationship has been set up:

```powershell
Get-OrganizationRelationship | ft name, domainnames
```

- If the domain isn't included in the returned result, [create an organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship) with the domain, or [add the domain to an existing organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship#use-the-exchange-admin-center-to-create-an-organization-relationship).

- If the domain is included in the returned result, run the following [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to enable the free/busy access. The cmdlet sets the value of the `FreeBusyAccessEnabled` parameter to `$true`.

    ```powershell
    Set-OrganizationRelationship -Identity Contoso -FreeBusyAccessEnabled $true
    ```

## Error 2: The organization relationship can't be used

> The mail recipient is not found in Active Directory., inner exception: Microsoft.Exchange.InfoWorker.Common.Availability.InvalidOrganizationRelationshipForRequestDispatcherException: **The organization relationship \<name of the organization relationship\> can't be used. Please confirm that the organization relationship is configured correctly.**\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>.

### Cause

This error occurs because the values of the following parameters aren't set correctly in the organization relationship:

- `TargetApplicationUri`
- `TargetAutodiscoverEpr` or `TargetSharingEpr`(at least one of these values isn't set correctly)

### Resolution

Run the `Get-OrganizationRelationship` cmdlet to check the parameters value. If any value is set incorrectly, use the `Set-OrganizationRelationship` cmdlet to set these parameters with the required values. For example:

**Note**: On-premises Exchange organizations can run the [Get-FederationInformation](/powershell/module/exchange/get-federationinformation) cmdlet with the domain name of the queried user to check these values across the routing domain.

```powershell
Set-OrganizationRelationship -Identity Contoso -TargetAutodiscoverEpr "https://contoso.com/autodiscover/autodiscover.svc/wssecurity" -TargetApplicationUri "mail.contoso.com" -TargetSharingEpr "https://outlook.office365.com/ews/Exchange.asmx"
```
