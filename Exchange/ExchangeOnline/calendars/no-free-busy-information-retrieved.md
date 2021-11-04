---
title: ErrorMailRecipientNotFound when viewing free/busy information
description: Describes an issue in which you can't view free/busy information of a user who is in another forest or tenant from Scheduling Assistant.
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

# ErrorMailRecipientNotFound error and no free/busy information

An organization relationship that has delegated authentication configured is set up to share calendar information with a user in another forest or tenant. When you try to view the user's free/busy information in Scheduling Assistant, no free/busy information is displayed. Additionally, when you log in Outlook on the Web as the source mailbox, open Developer Tools by pressing F12 and select the **Network** tab, one of the following error messages is displayed with the ErrorMailRecipientNotFound error in the response body for the `GetUserAvailabilityInternal` action.

## Unable to resolve e-mail address to an Active Directory object

> Microsoft.Exchange.InfoWorker.Common.Availability.MailRecipientNotFoundException: Unable to resolve e-mail address `user@northamerica.contoso.com` to an Active Directory object.\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>.

### Cause

This error occurs if one of the following scenarios is true:

- The domain name isn't included in the domain name list of the organization relationship.

- The domain name is included in the domain name list of the organization relationship, but the free/busy access isn't enabled. (This scenario occurs in cloud server only environment.)

### Resolution

Before you try the resolution, you can run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to check if the domain name is included in the domain name list of the organization relationship.

- If the domain name isn't included, use the Exchange admin center or Exchange Online PowerShell to [create an organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship), or [modify the existing organization relationship](/exchange/sharing/organization-relationships/modify-an-organization-relationship) to include that domain.

- If the domain name is included, set the value of the `FreeBusyAccessEnabled` parameter to `$true` to enable the free/busy access.

## The organization relationship can't be used

> The mail recipient is not found in Active Directory., inner exception: Microsoft.Exchange.InfoWorker.Common.Availability.InvalidOrganizationRelationshipForRequestDispatcherException: The organization relationship \<name of the organization relationship\> can't be used. Please confirm that the organization relationship is configured correctly.\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>.

### Cause

This error occurs because the organization relationship that is used to retrieve free/busy information has no value set, or the value isn't set correctly for the following parameters:

- `TargetApplicationUri`
- `TargetAutodiscoverEpr` and `TargetSharingEpr` (at least one of these two values must exist)

### Resolution

Before you try the resolution, you can run the `Get-OrganizationRelationship` cmdlet to check the parameters value. If any value is incorrectly set, use the [Set-OrganizationRelationship](/powershell/module/exchange/set-organizationrelationship) cmdlet to set these parameters correctly with the required values.

The following example modifies an organization relationship with the following conditions applied:

- The Autodiscover URL of Exchange Web Services is `https://contoso.com/autodiscover/autodiscover.svc/wssecurity`.
- The target Uniform Resource Identifier (URI) is `mail.contoso.com`.
- The URL of the target Exchange Web Services is: `https://outlook.office365.com/ews/Exchange.asmx`.

```powershell
Set-OrganizationRelationship -TargetAutodiscoverEpr "https://contoso.com/autodiscover/autodiscover.svc/wssecurity" -TargetApplicationUri "mail.contoso.com" -TargetSharingEpr "https://outlook.office365.com/ews/Exchange.asmx"
```

**Note**: On-premises Exchange organizations can run the [Get-FederationInformation](/powershell/module/exchange/get-federationinformation) cmdlet with the domain name of the queried user to check these values across the routing domain.
