---
title: Free/busy lookup fails with HTTP 401 at a preauthentication device
description: Diagnose HTTP 401 responses caused by preauthentication in front of on-premises Autodiscover or EWS during an Exchange hybrid free/busy lookup.
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
ms.date: 11/23/2026
---
# Free/busy lookup fails with HTTP 401 at a preauthentication device

## Summary

This article explains how to check for firewall or reverse proxy preauthentication when an Exchange Online user's lookup of an on-premises user's availability fails with HTTP 401. It covers tracing the request, confirming the cause, and correcting the endpoint publication rule. The guidance applies to the Autodiscover and Exchange Web Services (EWS) path, not Microsoft Graph authorization failures.

## Symptoms

An Exchange Online user can't view an on-premises user's availability in a hybrid deployment. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains one of the following [HTTP 401 messages](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#proxy-web-request-failed-http-status-401):

> Proxy web request failed ... The request failed with HTTP status 401: Unauthorized.

> Autodiscover failed for email address ... The request failed with HTTP status 401: Unauthorized.

## Cause

This issue occurs when a firewall or reverse proxy in front of Exchange preauthenticates the request instead of passing it through to Exchange. The hybrid Autodiscover and EWS virtual directories don't support perimeter preauthentication.

An HTTP 401 response alone doesn't prove this cause. Exchange logs contain some normal 401 responses, and other authentication failures return the same status.

## Resolution

1. Reproduce the lookup for one affected on-premises target.
1. Review the authentication configuration and logs of the perimeter device. Check whether the device challenges or rejects the matching request before it reaches Exchange.
1. Correlate the request with the following on-premises HTTP proxy logs:

   - `%ExchangeInstallPath%\Logging\HttpProxy\Autodiscover`
   - `%ExchangeInstallPath%\Logging\HttpProxy\Ews`

   Use the request time, target, and endpoint to identify matching entries. IIS log timestamps use UTC. If the request reaches Exchange, investigate the Exchange-side authentication error instead of assuming that the perimeter device blocked the request.

1. If you confirm perimeter preauthentication, configure the hybrid endpoint publication rule to pass the request through to Exchange. Keep the required Exchange-side authentication. Don't enable anonymous access to mailbox data, and don't disable authentication globally.

   For Exchange virtual directory settings, see [Default settings for Exchange virtual directories](/exchange/clients/default-virtual-directory-settings). For the current hybrid authentication configuration, see [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app).

1. Repeat the lookup. Confirm that the request reaches Exchange and that availability is returned. Don't use the disappearance of a single HTTP 401 log entry as the success criterion. If the lookup succeeds, stop troubleshooting.

### If the issue persists

If the lookup still fails, or if you can't confirm perimeter preauthentication, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, the endpoint, the exact error, the request time with time zone, and the correlated device and Exchange HTTP proxy log entries. Don't disable more authentication settings before you establish the cause.
