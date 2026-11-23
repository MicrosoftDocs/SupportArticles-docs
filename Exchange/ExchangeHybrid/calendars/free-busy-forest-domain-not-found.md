---
title: Free/busy lookup fails with forest/domain configuration error
description: Fix a hybrid free/busy lookup that fails with "Configuration information for forest/domain could not be found" by correcting recipient routing or hybrid configuration.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: shanefe
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom:
  - sap:Calendaring
  - Exchange Hybrid
  - CSSTroubleshoot
  - ai-usage:ai-assisted
search.appverid: MET150
appliesto:
  - Exchange Online
  - Exchange Server SE
  - Outlook on the web
  - Outlook for Windows
ms.date: 11/16/2026
---
# Free/busy lookup fails with forest/domain configuration error

## Summary

This article helps you fix a hybrid free/busy lookup that fails because Exchange can't find forest/domain configuration for the target recipient. It explains how to check the target recipient's routing address and the requester-side hybrid configuration. Apply the checks to the request that returned the error. Don't assume that a cloud-to-cloud cross-tenant lookup uses the same configuration.

## Symptoms

A cross-premises availability lookup fails. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following [forest/domain configuration error](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#configuration-information-for-forestdomain-could-not-be-found-in-active-directory):

> Configuration information for forest/domain could not be found in Active Directory.

## Cause

The target recipient has an incorrect routing address, or the target domain isn't included in the hybrid configuration that the requester uses. An incomplete hybrid configuration can also leave the required connector or organization relationship missing.

## Resolution

1. Identify the requester and target mailbox locations and the address used for the failed lookup.
1. If an on-premises user looks up a cloud mailbox, check the cloud user's remote mailbox in the on-premises Exchange Management Shell:

   ```powershell
   Get-RemoteMailbox -Identity "user@contoso.com" |
       Format-List PrimarySmtpAddress,RemoteRoutingAddress,EmailAddresses
   ```

   For more information, see [Get-RemoteMailbox](/powershell/module/exchangepowershell/get-remotemailbox).

1. If a cloud user looks up an on-premises mailbox, check the on-premises user's mail user in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

   ```powershell
   Get-MailUser -Identity "user@contoso.com" |
       Format-List PrimarySmtpAddress,ExternalEmailAddress,EmailAddresses
   ```

   For more information, see [Get-MailUser](/powershell/module/exchangepowershell/get-mailuser).

1. In the requester-side Exchange session, check the configuration for the target domain:

   ```powershell
   Get-IntraOrganizationConnector |
       Format-List Name,Enabled,TargetAddressDomains,DiscoveryEndpoint
   Get-OrganizationRelationship |
       Format-List Name,DomainNames,TargetAutodiscoverEpr,TargetSharingEpr
   ```

   For more information, see [Get-IntraOrganizationConnector](/powershell/module/exchangepowershell/get-intraorganizationconnector) and [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship). Compare the recipient's actual routing domain with the configuration intended for that lookup.

1. Correct the routing or target-domain error through the supported management process. If the hybrid configuration is incomplete, run the [current Hybrid Configuration Wizard](/exchange/hybrid-configuration-wizard) to restore the required configuration.

   For the current hybrid application configuration, see [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app).

   Don't add unrelated partner domains to a hybrid connector, infer fallback behavior from a failed request, or use `TargetOwaURL` as a free/busy endpoint.

1. Repeat the lookup with the same requester and target. Confirm that availability is returned and that the forest/domain error no longer occurs. If the issue affected both directions, test both directions.

If the lookup succeeds, no further action is needed.

### If the issue persists

If the lookup still fails, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide the following information:

- The requester and target identities and locations
- The routing address and target domain
- The exact error message
- The request time, including time zone
- The output from the recipient, connector, and organization relationship commands

Don't add unrelated domains to troubleshoot an unexplained failure.
