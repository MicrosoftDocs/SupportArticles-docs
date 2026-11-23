---
title: Hybrid free/busy fails because a connection was forcibly closed
description: Diagnose a transport reset during an EWS hybrid free/busy lookup without assuming that every reset has the same firewall or TLS cause.
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
  - Exchange Server SE
  - Outlook on the web
  - Outlook for Windows
search.appverid: MET150
ms.date: 11/09/2026
ai-usage: ai-assisted
---
# Hybrid free/busy fails because a connection was forcibly closed

## Summary

Use this article to identify a firewall or TLS connection reset during an EWS availability lookup between Exchange Online and Exchange Server SE. A connection reset is a transport symptom, not proof of a single cause.

## Symptoms

Scheduling Assistant doesn't display the remote mailbox's availability. The diagnostic response includes an error such as:

```text
An existing connection was forcibly closed by the remote host.
An unexpected error occurred on a receive.
```

A related reset can occur while sending a request during an outbound connection or OAuth connectivity test.

## Cause

A firewall can interrupt the connection between Exchange Online and an on-premises EWS or Autodiscover endpoint. An incompatible TLS configuration can also close a connection. Confirm which endpoint and connection direction fail before choosing a remedy.

## Resolution

1. Record the requester and target mailbox locations, the failed endpoint, and the reproduction time in UTC.
1. For a cloud-to-on-premises request, reproduce once and check the on-premises firewall, reverse-proxy, and IIS logs for that request. Check the Exchange HTTP proxy logs under:

   ```text
   %ExchangeInstallPath%\Logging\HttpProxy\Autodiscover
   %ExchangeInstallPath%\Logging\HttpProxy\Ews
   ```

1. If the request doesn't reach the expected endpoint, identify the device that blocks or resets it. Correct only the confirmed network restriction using [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges). Don't open unrelated inbound services or disable the firewall.
1. If evidence indicates a TLS negotiation failure, review [Exchange Server TLS configuration best practices](/exchange/plan-and-deploy/post-installation-tasks/security-best-practices/exchange-tls-configuration). Use the [Exchange Health Checker](https://microsoft.github.io/CSS-Exchange/Diagnostics/HealthChecker/) and the [Microsoft SSL server test](https://testconnectivity.microsoft.com/tests/SslServer/input) to identify the actual configuration problem. Don't apply old-server registry changes without checking the supported SE configuration.
1. Maintain the [dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app). Don't attempt to resolve a transport reset by uploading certificates to the retired shared service principal.

These EWS endpoint checks don't identify the endpoint of a Graph-based hybrid request. If Graph-based hybrid flow is enabled, determine the actual failed connection using the dedicated-app guide before changing network rules.

### Verify the resolution

Repeat the original lookup in the same direction. Confirm that the connection finishes without a reset and that Scheduling Assistant displays availability. A successful connection alone doesn't prove that authorization or the availability response is correct.

## More information

- [Resolve free/busy errors](/troubleshoot/outlook/calendaring/resolve-free-busy-errors)
