---
title: Cross-tenant free/busy fails with a federated proxy address error
description: Diagnose a federated proxy address error by comparing the requesting mailbox's SMTP addresses, federated domain, and target organization relationship.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: meshel, shanefe
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
ms.date: 11/12/2026
ai-usage: ai-assisted
---

# Cross-tenant free/busy fails with a federated proxy address error

## Summary

This article explains how to investigate a federated proxy address error when an Exchange Online user requests another tenant's availability. It covers the requesting mailbox's SMTP addresses, the domain used for federation, and the receiving tenant's organization relationship.

The guidance applies to an existing federation-based Exchange Web Services (EWS) lookup. If the lookup uses Microsoft 365 Cross-Tenant Access Policy or Microsoft Graph, use the [current cross-tenant sharing guidance](/exchange/sharing/migrate-to-m365-xtap) instead. Don't change federation settings to troubleshoot a Graph request.

## Symptoms

In Scheduling Assistant, a user can't retrieve an attendee's availability from another Exchange Online tenant. When you analyze an [HTTP Archive (HAR) network trace](collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains:

```text
UserWithoutFederatedProxyAddressException: User doesn't have any SMTP proxy address from a domain that is federated.
```

Identify the requesting user and the target attendee before collecting configuration. The mailbox to inspect for this error is the requester, not the attendee whose calendar is unavailable.

## Cause

The requesting mailbox doesn't have an SMTP proxy address in a domain that can be used for the federated request.

The federation configuration determines the domain used in delegation tokens. As documented for [Set-FederatedOrganizationIdentifier](/powershell/module/exchangepowershell/set-federatedorganizationidentifier#-defaultdomain), a configured `DefaultDomain` is used for delegation tokens. If it isn't set, the user's primary SMTP domain is used. A mailbox address in a different domain doesn't establish that the selected domain is usable.

## Resolution

Work with administrators in both tenants. Use accounts with permission to read the relevant configuration, and make changes only after confirming the intended addressing and sharing configuration.

1. In the requesting tenant, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell). Inspect the federation configuration by using [Get-FederatedOrganizationIdentifier](/powershell/module/exchangepowershell/get-federatedorganizationidentifier):

   ```powershell
   Get-FederatedOrganizationIdentifier |
       Format-List Enabled,DefaultDomain,Domains
   ```

1. Inspect the requesting mailbox by using [Get-Mailbox](/powershell/module/exchangepowershell/get-mailbox). Replace the example address with the affected requester's address:

   ```powershell
   Get-Mailbox -Identity "requester@contoso.com" |
       Format-List PrimarySmtpAddress,EmailAddresses
   ```

1. Identify the domain selected for delegation tokens. Compare it with the federated domains and the mailbox's SMTP proxy addresses. If the intended proxy address is missing, have an authorized administrator correct it by following [Add or remove email addresses for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/add-or-remove-email-addresses).

   Preserve existing addresses and mail routing. If the object is synchronized from an on-premises directory, correct it through its authoritative recipient-management process. Don't change the tenant-wide `DefaultDomain` just to make one user's lookup succeed.

1. In the target tenant, have its administrator use [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship) to inspect the relationship for the requesting organization:

   ```powershell
   Get-OrganizationRelationship |
       Format-List Name,DomainNames,Enabled
   ```

   Confirm that `DomainNames` includes the requester's effective federated domain. If it doesn't, add only the confirmed missing domain by following [Modify an organization relationship](/exchange/sharing/organization-relationships/modify-an-organization-relationship). Preserve the relationship's other domains and settings.

   This receiving-side check doesn't replace correcting a missing SMTP proxy address on the requester.

1. Repeat the lookup with the same requester, target, and meeting time range. Confirm that availability is returned without the federated proxy address error. If it succeeds, stop troubleshooting.

### If the issue persists

[Contact Microsoft Support](/microsoft-365/admin/get-help-support) with the requester and target, their tenant locations, the failed time range, the reproduction time with its time zone, the exact error, and the relevant federation, proxy-address, and organization-relationship output. Don't keep changing mailbox addresses or tenant-wide federation settings without an established cause. Share collected information only through the support request, not in a public forum.
