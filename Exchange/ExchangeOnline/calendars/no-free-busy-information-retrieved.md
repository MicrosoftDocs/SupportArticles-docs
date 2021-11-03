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

## Symptoms

An organization relationship that has delegated authentication configured is set up to share calendar information with a user in another forest or tenant. When you try to view the user's free/busy information in Scheduling Assistant, no free/busy information is displayed, and one of the following error messages is displayed with the ErrorMailRecipientNotFound error in the `GetUserAvailabilityInternal` action log:

**Error message 1**:

> Microsoft.Exchange.InfoWorker.Common.Availability.MailRecipientNotFoundException: Unable to resolve e-mail address `user@nootherforest.com` to an Active Directory object.\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>.

**Error message 2**:

> Microsoft.Exchange.InfoWorker.Common.Availability.MailRecipientNotFoundException: Unable to resolve e-mail address `user@northamerica.contoso.com` to an Active Directory object.\r\n. Name of the server where exception originated: \<Host name of cloud server\>.

**Error message 3**:

> The mail recipient is not found in Active Directory., inner exception: Microsoft.Exchange.InfoWorker.Common.Availability.InvalidOrganizationRelationshipForRequestDispatcherException: The organization relationship \<name of the organization relationship\> can't be used. Please confirm that the organization relationship is configured correctly.\r\n. Name of the server where exception originated: \<Host name of cloud or on-premises server\>.

## Cause

Here are the causes that correspond to the error messages:

**Cause 1**: Free/busy information is retrieved from a non-resolvable email address where the domain name isn't included in the domain name list of the organization relationship.

**Cause 2**: Free/busy information is retrieved from a non-resolvable email address where the domain name is included in the domain name list of the organization relationship, and the value of the `FreeBusyAccessEnabled` parameter is set to `$false`. (This scenario occurs in cloud server only environment.)

**Cause 3**: Organization relationship that is used to retrieve free/busy information has no value set, or the value isn't set correctly for the following parameters:

- `TargetApplicationUri`
- Both `TargetAutodiscoverEpr` and `TargetSharingEpr` (at least one of these two values must exist)

## Resolution

Before you try the resolutions, you can run the [Get-OrganizationRelationship](/powershell/module/exchange/get-organizationrelationship) cmdlet to check the domain name list of the organization relationship. See the following cmdlet output as an example:

:::image type="content" source="media/no-freebusy-information-retrieved/domainnames-ouput.png" alt-text="Screenshot for cmdlet output as an example.":::

To fix this issue, check the following resolutions that correspond to the causes.

**Resolution 1**: If the domain name (for example, nootherforest) isn't included in the domain name list of the organization relationship when the recipient email address is valid, [create an organization relationship](/exchange/sharing/organization-relationships/create-an-organization-relationship#use-exchange-online-powershell-to-create-an-organization-relationship), or modify the existing organization relationship to include that domain.

**Resolution 2**: If the domain name (for example, northamerica.contoso) is included in the domain name list of the organization relationship when the recipient email address is valid, ensure that the organization relationship that is used sets the value of the `FreeBusyAccessEnabled` parameter to `$true`.

**Resolution 3**: Ensure that the following parameters are set correctly with the required values:

- `TargetApplicationUri`
- `TargetAutodiscoverEpr` or `TargetSharingEpr` (at least one of these two values must exist)

**Note**: On-premises Exchange organizations can run the [Get-FederationInformation](/powershell/module/exchange/get-federationinformation) cmdlet with the domain name of the queried user to check these values across the routing domain.
