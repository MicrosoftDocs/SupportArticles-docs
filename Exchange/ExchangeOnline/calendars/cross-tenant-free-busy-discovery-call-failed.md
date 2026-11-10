---
title: Cross-tenant free/busy fails with an Autodiscover call failed error
description: Check organization-relationship endpoint settings when an EWS-based cross-tenant availability lookup or Test-OrganizationRelationship reports an Autodiscover failure.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: meshel,shanefe
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
search.appverid: MET150
ms.date: 11/09/2026
ai-usage: ai-assisted
---
# Cross-tenant free/busy fails with an Autodiscover call failed error

## Summary

This article addresses incorrect endpoints in an organization relationship that still uses Exchange Web Services (EWS) for cross-tenant free/busy. It isn't a repair for a Microsoft 365 Cross-Tenant Access Policy or Microsoft Graph request.

## Symptoms

Users can't retrieve availability from the other organization. A diagnostic request, such as [Test-OrganizationRelationship](/powershell/module/exchangepowershell/test-organizationrelationship), reports that the Autodiscover call failed.

## Cause

An organization relationship can direct availability requests to an incorrect endpoint. The Autodiscover failure doesn't, by itself, prove that DNS or the Autodiscover service is unavailable. Compare the relationship with the target organization's published federation configuration before changing it.

## Resolution

Determine whether both organizations still use an EWS organization relationship for this lookup. If they use Microsoft 365 Cross-Tenant Access Policy instead, use [the current cross-tenant sharing guidance](/exchange/sharing/migrate-to-m365-xtap).

1. In the requesting tenant, inspect the relationship by using [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship):

   ```powershell
   Get-OrganizationRelationship |
       Format-List Name,DomainNames,Enabled,TargetApplicationUri,TargetAutodiscoverEpr,TargetSharingEpr
   ```

1. Use [Get-FederationInformation](/powershell/module/exchangepowershell/get-federationinformation) for the actual target domain, and compare the returned federation information with the relationship. See the endpoint procedure in [ErrorMailRecipientNotFound when viewing free/busy information](no-free-busy-information-retrieved.md).
1. Correct a confirmed incorrect setting by using [Set-OrganizationRelationship](/powershell/module/exchangepowershell/set-organizationrelationship). Preserve existing domain entries and other features of the relationship. Use the endpoint for the target organization's cloud; don't substitute a worldwide endpoint for a sovereign-cloud deployment.
1. Check the relationship in the target tenant for the requesting organization's domain and intended free/busy access. Have that tenant's administrator correct a confirmed configuration error.

A blank `TargetSharingEpr` isn't automatically an error: Exchange can use Autodiscover when no direct EWS endpoint is specified. Don't populate it merely because it's blank, and don't change federation or mailbox proxy addresses without confirming a separate cause.

### Verify the resolution

Repeat the diagnostic test with the same requesting mailbox and relationship. Then query the same target in Scheduling Assistant. Confirm both that the endpoint error is gone and that the intended availability is returned.

## More information

- [Migrate Microsoft 365 cross-tenant sharing](/exchange/sharing/migrate-to-m365-xtap)
- [Organization relationships](/exchange/sharing/organization-relationships/organization-relationships)
