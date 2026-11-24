---
title: Free/busy lookup fails with "Could not create SSL/TLS secure channel" error
description: Diagnose TLS configuration and certificate trust problems in an Exchange hybrid free/busy connection.
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
# Free/busy lookup fails with "Could not create SSL/TLS secure channel" error

## Summary

This article explains how to troubleshoot a cross-premises availability lookup that fails with `Could not create SSL/TLS secure channel`. It covers identifying the failed HTTPS endpoint, checking TLS negotiation and certificate trust, and verifying the lookup after correcting a confirmed problem. The error doesn't indicate an OAuth token or calendar permission failure.

## Symptoms

A cross-premises availability lookup in a hybrid deployment fails. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following [secure-channel error](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#the-request-was-aborted-could-not-create-ssltls-secure-channel):

> The request was aborted: Could not create SSL/TLS secure channel.

The failure can occur in either direction between Exchange Online and on-premises Exchange.

## Cause

TLS negotiation fails. Depending on the direction, the cause can be TLS that's disabled or misconfigured on an on-premises endpoint, a certificate chain trust problem, or incompatible cipher suites.

## Resolution

1. Identify the direction of the lookup and the endpoint in the error. Check the Exchange server and any firewall or proxy that terminates TLS on that path.
1. Run [Exchange HealthChecker](https://microsoft.github.io/CSS-Exchange/Diagnostics/HealthChecker/) on each involved on-premises Exchange server. Compare the TLS findings with [Exchange Server TLS configuration best practices](/exchange/plan-and-deploy/post-installation-tasks/security-best-practices/exchange-tls-configuration).
1. For a publicly exposed on-premises endpoint, use the [SSL server test](https://testconnectivity.microsoft.com/tests/SslServer/input) in Microsoft Remote Connectivity Analyzer. Check the TLS configuration and the certificate that the endpoint presents.
1. For an outbound failure, check certificate chain trust and the cipher suites that the destination supports. See [TLS cipher suites supported by Microsoft 365](/purview/technical-reference-details-about-encryption).

   > [!IMPORTANT]
   > Don't disable certificate validation, and don't install the leaf certificate of an endpoint as a trusted root. Repair the certificate chain and trusted CA configuration through your organization's approved certificate management process.

1. Correct the confirmed TLS, certificate chain, or cipher suite problem. For Graph-based hybrid requests, use the actual Graph endpoint and the current network requirements in [Deploy the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app). Don't apply EWS endpoint settings to these requests.
1. Repeat the same availability lookup in each affected direction. Confirm that availability is returned without the secure channel error. If the lookups succeed, stop troubleshooting.

### If the issue persists

If the error persists, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, the affected direction and endpoint, the exact error, the request time with time zone, and the relevant HealthChecker, connectivity test, and TLS findings. Don't share certificate private keys or authentication secrets.
