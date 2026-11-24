---
title: Free/busy lookup fails with an Autodiscover HTTP 404 error
description: Diagnose an HTTP 404 response from the Autodiscover endpoint used by an Exchange hybrid free/busy lookup.
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
# Free/busy lookup fails with an Autodiscover HTTP 404 error

## Summary

This article helps you find and fix the Autodiscover endpoint that returns HTTP 404 when an Exchange Online user looks up the availability of an on-premises user in an Exchange hybrid deployment.

This article applies when the failed request uses the Autodiscover and Exchange Web Services (EWS) path. It doesn't cover Microsoft Graph requests. For current hybrid authentication prerequisites and API selection, see [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app).

## Symptoms

An Exchange Online user can't view the availability (free/busy) of an on-premises user. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following [Autodiscover HTTP 404 error](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#autodiscover-failed-for-email-address-http-status-404):

> Autodiscover failed for email address ... The request failed with HTTP status 404: Not Found.

## Cause

An incorrect Autodiscover URL or publication rule can cause the availability service's request to reach an endpoint that returns HTTP 404 instead of the expected Autodiscover response.

## Resolution

1. Identify where the requester and target mailboxes are located, and reproduce the error for one affected target.
1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), and then inspect the cloud-to-on-premises configuration:

   ```powershell
   Get-IntraOrganizationConnector |
       Format-List Name,Enabled,DiscoveryEndpoint,TargetAddressDomains
   Get-OrganizationRelationship |
       Format-List Name,DomainNames,TargetAutodiscoverEpr,TargetSharingEpr
   ```

   For more information, see [Get-IntraOrganizationConnector](/powershell/module/exchangepowershell/get-intraorganizationconnector) and [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship). The connector property is `DiscoveryEndpoint`, not `TargetAutodiscoverEpr`.

1. Identify the configuration and endpoint that the failed request uses. Compare the URL with the endpoint that you publish for your deployment.
1. Check the reverse proxy and Exchange IIS logs to determine where the 404 response originates.
1. Correct the incorrect endpoint or publication rule. If the Hybrid Configuration Wizard (HCW) manages the configuration, run the [current HCW](/exchange/hybrid-configuration-wizard) to restore the intended hybrid configuration. Don't guess an endpoint or edit unrelated connectors.

   If an organization relationship has `TargetSharingEpr` set, that relationship uses the explicit EWS endpoint instead of `TargetAutodiscoverEpr`. A blank `TargetSharingEpr` value isn't automatically an error.

1. Repeat the same availability lookup. Confirm that the Autodiscover request no longer returns HTTP 404 and that the availability of the target user is returned. A successful browser request alone doesn't verify free/busy.

### If the issue persists

If the lookup still fails or the source of the 404 response remains unclear, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, the failed endpoint, the exact error, the request time and time zone, the configuration output, and the matching reverse proxy and IIS log entries. Share this information only in the support request, and remove sensitive data first.
