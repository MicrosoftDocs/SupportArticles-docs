---
title: Free/busy lookup fails with "Unable to connect to the remote server" error
description: Diagnose blocked or interrupted HTTPS connections on the EWS path of an Exchange hybrid free/busy lookup.
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
ms.date: 11/17/2026
---
# Free/busy lookup fails with "Unable to connect to the remote server" error

## Summary

This article explains how to troubleshoot a hybrid free/busy lookup that fails with `Unable to connect to the remote server`. It covers identifying the failed connection's direction and destination, checking the firewall and reverse proxy path, and verifying the lookup after correcting a blocking rule. The guidance applies to EWS connection errors, not Microsoft Graph requests.

## Symptoms

A cloud user can't view an on-premises user's availability, or an on-premises user can't view a cloud user's availability. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following [connection error](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#proxy-web-request-failed-unable-to-connect-to-the-remote-server):

> Proxy web request failed ... Unable to connect to the remote server.

For a cloud-to-on-premises lookup, a blocked connection can also produce the following [connection-closed error](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#an-existing-connection-was-forcibly-closed-by-the-remote-host):

> An existing connection was forcibly closed by the remote host.

The error can also refer to an unexpected error on a send or receive operation.

## Cause

A network connectivity problem prevents or interrupts the HTTPS connection between Exchange Online and an on-premises Exchange endpoint. For example, an on-premises firewall can block an inbound connection from an Exchange Online outbound IP address.

## Resolution

1. Record the requester, the target mailbox location, the failed endpoint, and the time of the lookup. Don't assume that both directions use the same network path.
1. For a cloud-to-on-premises request, check the firewall, reverse proxy, and Exchange logs for that time. Verify whether the request reached IIS and the following HTTP proxy log folders:

   - `%ExchangeInstallPath%\Logging\HttpProxy\Autodiscover`
   - `%ExchangeInstallPath%\Logging\HttpProxy\Ews`

   IIS log timestamps use UTC. An absent Autodiscover request can be expected if the organization relationship uses an explicit EWS `TargetSharingEpr`.

1. For an on-premises-to-cloud request, check the outbound firewall and proxy logs for the destination that the failed request used.
1. Correct the rule that blocks or interrupts the connection. Use the current [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges) and the network requirements in [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app#network-connectivity-requirements).

   Don't reuse an old static IP list or retired authentication endpoints. If the failure affects only some cloud users, check whether the firewall blocks the outbound source IP address that is associated with their requests.

1. Repeat the original lookup in the affected direction. Confirm that the connection error is gone and that availability is returned. If both directions were affected, test both. If the lookups succeed, stop troubleshooting.

### If the issue persists

If the lookup still fails, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, the direction, the failed endpoint, the exact error, the request time with time zone, and the correlated firewall, proxy, and Exchange log entries. State whether the request reached Exchange, and include the relevant source and destination addresses.
