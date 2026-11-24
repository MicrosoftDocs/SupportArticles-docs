---
title: Free/busy lookup fails with "The remote name could not be resolved" error
description: Diagnose DNS resolution or endpoint-name errors in an Exchange hybrid Autodiscover free/busy lookup.
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
ms.date: 10/31/2026
---
# Free/busy lookup fails with "The remote name could not be resolved" error

## Summary

This article helps you use the hostname in the error to check DNS and the configured Autodiscover endpoint when an Exchange Online user can't look up the availability of an on-premises user in an Exchange hybrid deployment.

This article applies to a failed Autodiscover and Exchange Web Services (EWS) request. It doesn't cover Microsoft Graph endpoint failures. For current hybrid authentication prerequisites and API selection, see [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app).

## Symptoms

An Exchange Online user can't view the availability (free/busy) of an on-premises user. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains an error that resembles the following [name-resolution error](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#autodiscover-failed-for-email-address-the-remote-name-could-not-be-resolved):

> Autodiscover failed for email address user@contoso.com ... The remote name could not be resolved: 'mail.contoso.com'.

The hostname in your error can differ from this example.

## Cause

The availability service can't resolve the hostname in the configured Autodiscover URL. An incorrect endpoint name, or a missing or incorrect public DNS record, can cause this error.

## Resolution

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), and then inspect the configuration for the affected target domain:

   ```powershell
   Get-IntraOrganizationConnector |
       Format-List Name,Enabled,DiscoveryEndpoint,TargetAddressDomains
   Get-OrganizationRelationship |
       Format-List Name,DomainNames,TargetAutodiscoverEpr,TargetSharingEpr
   ```

   For more information, see [Get-IntraOrganizationConnector](/powershell/module/exchangepowershell/get-intraorganizationconnector) and [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship).

1. Compare the hostname in the error with the endpoint in the configuration that the request uses. The Autodiscover URL of the intra-organization connector is the `DiscoveryEndpoint` property.
1. Verify public DNS for the intended on-premises endpoint. Check from outside the on-premises network. A DNS record that resolves only inside that network doesn't verify public resolution.
1. Correct the DNS record or the incorrect endpoint name. If the Hybrid Configuration Wizard (HCW) manages the endpoint, run the [current HCW](/exchange/hybrid-configuration-wizard) to restore the intended configuration.

   Don't set an arbitrary EWS URL to bypass the error. In an organization relationship, an explicitly configured `TargetSharingEpr` value takes precedence over `TargetAutodiscoverEpr`. Keep the endpoint appropriate to your deployment.

1. Confirm that the intended hostname resolves publicly, and then repeat the same availability lookup. Verify that the availability of the target user is returned and that the name-resolution error no longer occurs.

### If the issue persists

If the lookup still fails, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, the hostname and configured endpoint, the exact error, the request time and time zone, the results of the external DNS check, and the relevant connector or organization relationship output. Don't change unrelated endpoints.
