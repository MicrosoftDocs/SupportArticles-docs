---
title: Free/busy lookup fails because the user-context value in the token is ambiguous
description: Diagnose duplicate on-premises user identifiers when an Exchange hybrid free/busy lookup reports an ambiguous user-context value.
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
# Free/busy lookup fails because the user-context value in the token is ambiguous

## Summary

This article explains how to troubleshoot a hybrid free/busy lookup that fails because the user-context value in the token is ambiguous. It covers identifying duplicate on-premises user identifiers, confirming their intended ownership, correcting a duplicate, and verifying the lookup. Not every HTTP 401 response indicates this issue.

For the current hybrid authentication configuration, see [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app).

## Symptoms

An Exchange Online user can't view an on-premises user's availability in a hybrid deployment. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following message from the failed Exchange Web Services (EWS) request:

> The request failed with HTTP status 401: Unauthorized ... The user specified by the user-context in the token is ambiguous.

The diagnostic might also include `error_category="invalid_user"`.

## Cause

Another on-premises user object uses the user principal name (UPN) or a `proxyAddresses` value of the affected on-premises user. The request can't uniquely identify the user.

## Resolution

1. Record the identifiers of the affected on-premises user.
1. Use an Active Directory query to search for other user objects that have the same `userPrincipalName` or a duplicate `proxyAddresses` value. For an example LDAP query, see the [ambiguous-user troubleshooting procedure](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#exception-proxy-web-request-failed).
1. Confirm which object should own each identifier before you make a change.
1. Have an authorized administrator correct the duplicate identifier on the incorrect object by using the supported management process for that object.

   Don't delete a mailbox or user object only because it appears in the search results. This procedure doesn't require broad account deletion or an authentication reset.

1. Run the identity search again. Confirm that the identifiers uniquely match the intended user.
1. Repeat the same cloud-to-on-premises lookup. Confirm that availability is returned without the ambiguous-user error. If the lookup succeeds, stop troubleshooting.

### If the issue persists

If the lookup still fails, or if the ownership of an identifier is unclear, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, the exact diagnostic, the request time with time zone, and the sanitized duplicate search results. Don't delete objects or reassign identifiers before you confirm their intended ownership.
