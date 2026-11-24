---
title: Free/busy lookup fails with "Response is not well-formed XML" error
description: Diagnose a malformed XML response on the on-premises EWS path of an Exchange hybrid free/busy lookup.
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
# Free/busy lookup fails with "Response is not well-formed XML" error

## Summary

This article helps you determine whether Exchange or a device in front of Exchange returned a malformed response when an Exchange Online user looks up the availability of an on-premises user in an Exchange hybrid deployment.

This article applies to the Exchange Web Services (EWS) XML request path. It doesn't cover Microsoft Graph responses. For current hybrid authentication prerequisites and API selection, see [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app).

## Symptoms

An Exchange Online user can't view the availability (free/busy) of an on-premises user. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following [malformed XML error](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#proxy-web-request-failed-response-is-not-well-formed-xml):

> Proxy web request failed ... Response is not well-formed XML.

## Cause

The EWS request receives a response that isn't well-formed XML. An error response from Exchange, or from a firewall or reverse proxy in the request path, can cause this failure.

## Resolution

1. Reproduce the lookup for one affected target, and record the time of the request.
1. Check whether the request reached on-premises Exchange. Review the IIS logs and the `%ExchangeInstallPath%\Logging\HttpProxy\Ews` logs for the corresponding request.

   IIS log timestamps use UTC. An HTTP 200 or 401 entry can help identify where the request arrived, but it doesn't establish that the availability lookup succeeded.

1. If the request didn't reach Exchange, review the firewall and reverse proxy logs and the response body to identify the device that returned the unexpected content. Correct the publication or response-handling rule that causes it.
1. If the request reached Exchange, check the Windows **Application** event log for errors at the same time. Use the matching Exchange error to determine the repair. Don't change unrelated authentication settings.
1. Repeat the same availability lookup. Confirm that the malformed XML error no longer occurs and that the availability of the target user is returned. An HTTP 200 response alone doesn't verify the fix.

### If the issue persists

If the failure persists or the Exchange error doesn't identify a documented repair, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, the endpoint, the exact error, the request time and time zone, and the matching IIS, HTTP proxy, device, and Application event log entries. Treat logs and response bodies as sensitive. Provide the sanitized response body only in the support request, and don't post mailbox information, authentication headers, or raw traces publicly.
