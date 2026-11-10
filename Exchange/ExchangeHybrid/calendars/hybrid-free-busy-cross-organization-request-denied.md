---
title: Cross-tenant free/busy fails because the requester is from a different organization
description: Correct the target address used for an EWS free/busy lookup when a cloud user's domain resolves to the on-premises side of a hybrid organization.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: meshel,shanefe
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom:
  - sap:Calendaring
  - Exchange Hybrid
  - CSSTroubleshoot
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
search.appverid: MET150
ms.date: 11/09/2026
ai-usage: ai-assisted
---
# Cross-tenant free/busy fails because the requester is from a different organization

## Summary

This article addresses an EWS-based cross-tenant lookup for a cloud mailbox in a hybrid organization when Autodiscover directs the request to Exchange Server. The target mailbox is in Exchange Online; this isn't a general fix for all access-denied errors.

## Symptoms

A user in a separate Exchange Online tenant can't retrieve the cloud target's availability. The response includes:

```text
The cross-organization request for mailbox is not allowed because the requester is from a different organization.
```

For example, the target user's primary SMTP domain directs Autodiscover to the on-premises environment, while the user's hybrid routing address directs it to Exchange Online.

## Cause

The availability request reaches the on-premises side of the target's hybrid organization rather than the cloud mailbox. The on-premises service can't proxy this external organization's request through the hybrid organization in the way the requester expects.

## Resolution

First confirm the target mailbox's actual location and the Autodiscover destination for the address used in the failed request.

1. Have the target organization's administrator confirm that the target mailbox is in Exchange Online and identify its existing address whose Autodiscover route points to Exchange Online.
1. Test the lookup by selecting that confirmed cloud-routed address. For example, a confirmed address in `contoso.mail.onmicrosoft.com` can identify a cloud user whose primary address uses `contoso.com`. Don't assume that every user in the hybrid organization has a cloud mailbox or that an arbitrary routing address exists.
1. If users select a directory representation in the requesting tenant, have its administrator review the target's external email address. Where appropriate, update that representation to the confirmed cloud-routed address by following the organization's supported recipient-management or synchronization process. Preserve its other addressing and mail-flow requirements.
1. Coordinate any broader cross-tenant synchronization change with the target organization's administrator. Don't change the target organization's public Autodiscover record to fix one external lookup.

For Microsoft 365 tenants that use the newer cross-tenant sharing policy, use [Microsoft 365 Cross-Tenant Access Policy guidance](/exchange/sharing/migrate-to-m365-xtap) instead. Don't treat this EWS addressing workaround as a Graph-policy repair, and don't disable hybrid sharing policies as part of it.

### Verify the resolution

Query the same cloud target by using the confirmed address and the same meeting time range. Confirm that availability is returned and that the cross-organization proxy error is absent. Separately test an on-premises target if your organization also requires that scenario.

## More information

- [Resolve free/busy errors](/troubleshoot/outlook/calendaring/resolve-free-busy-errors)
- [Cross-tenant synchronization](/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview)
