---
title: Free/busy lookup fails with an Object moved error
description: Troubleshoot an Object moved HTML response from the EWS endpoint used by an Exchange hybrid free/busy lookup.
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
# Free/busy lookup fails with an Object moved error

## Summary

This article explains how to troubleshoot an availability lookup in an Exchange hybrid deployment that receives an HTML response containing `Object moved`. It covers checking the explicitly configured Exchange Web Services (EWS) endpoint, restoring the correct endpoint, and verifying the lookup.

This article applies to the failed EWS request. It doesn't cover Microsoft Graph requests. For current hybrid authentication prerequisites and API selection, see [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app).

## Symptoms

An Exchange Online user can't view the availability (free/busy) of an on-premises user. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains `Proxy web request failed` and an HTML response whose title is [`Object moved`](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#proxy-web-request-failed-object-moved).

## Cause

The `TargetSharingEpr` value in the cloud-to-on-premises organization relationship specifies an incorrect EWS URL. The availability service request reaches a location that returns an HTML redirection response instead of the expected EWS response.

## Resolution

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), and then inspect the affected organization relationship:

   ```powershell
   Get-OrganizationRelationship |
       Format-List Name,DomainNames,TargetSharingEpr,TargetAutodiscoverEpr
   ```

   For more information, see [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship).

1. Compare the `TargetSharingEpr` value with the EWS endpoint that you publish for your deployment.
1. Use the reverse proxy and Exchange logs to identify the URL that returned the HTML response.
1. Restore the correct endpoint by using the [current Hybrid Configuration Wizard](/exchange/hybrid-configuration-wizard) or your approved configuration procedure.

   > [!IMPORTANT]
   > A [Microsoft Hybrid Agent](/exchange/hybrid-deployment/hybrid-agent) deployment can use an endpoint that the HCW generates. Don't replace that endpoint with a guessed public hostname. Don't clear it only because it differs from a classic hybrid endpoint.

   When `TargetSharingEpr` is set, the organization relationship uses it instead of `TargetAutodiscoverEpr`. For the parameter behavior, see [Set-OrganizationRelationship](/powershell/module/exchangepowershell/set-organizationrelationship). A blank value isn't always invalid.

1. Repeat the same availability lookup. Confirm that EWS no longer returns the `Object moved` response and that the availability of the affected target is returned.

### If the issue persists

If the response or the lookup failure persists, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, the configured endpoint, the exact error, the request time and time zone, and the matching reverse proxy and Exchange log entries. Provide a sanitized response body only in the support request.
