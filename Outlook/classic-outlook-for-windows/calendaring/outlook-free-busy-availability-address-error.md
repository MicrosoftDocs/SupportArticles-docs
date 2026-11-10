---
title: Outlook free/busy fails with Failed to get ASURL error 8004010F
description: Check Autodiscover and the returned EWS availability URL when classic Outlook reports Failed to get ASURL error 8004010F in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: meshel,shanefe
audience: ITPro
ms.topic: troubleshooting
ms.service: outlook
ms.custom:
  - sap:Calendar\Working with meetings or appointments
  - Classic Outlook for Windows
  - CSSTroubleshoot
appliesto:
  - Outlook for Windows
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 11/09/2026
ai-usage: ai-assisted
---
# Outlook free/busy fails with Failed to get ASURL error 8004010F

## Summary

Use this article when classic Outlook for Windows can't get the availability URL for an EWS-based hybrid free/busy lookup. The article doesn't address Outlook send/receive error `0x8004010F` or a Microsoft Graph request.

## Symptoms

An on-premises user can't get a cloud user's availability in Scheduling Assistant. The availability diagnostics report:

```text
Failed to get ASURL. Error 8004010F.
```

## Cause

This error is a general Autodiscover error. Outlook can't get the EWS URL needed for the availability lookup. The error alone doesn't establish whether the problem is in Autodiscover, a load balancer, or a later hybrid connection.

## Resolution

1. In the affected classic Outlook profile, run **Test E-mail AutoConfiguration**. Hold **Ctrl**, right-click the Outlook icon in the notification area, and select **Test E-mail AutoConfiguration**. Test Autodiscover for the affected user and check the returned EWS URL.
1. If Autodiscover doesn't return the expected EWS URL, ask the Exchange administrator to correct the Autodiscover or EWS configuration. Use the endpoint for the affected user's actual mailbox location. Don't substitute an Exchange Online endpoint for an on-premises mailbox.
1. Test availability between on-premises mailboxes on different Exchange servers. If that lookup also fails, investigate the on-premises availability path before treating the problem as cloud connectivity.
1. If a load balancer is present in the path, ask the Exchange and network administrators to compare requests through it with a controlled test to the correct backend. Keep the published hostname and certificate validation. Don't leave a temporary routing or Hosts-file override in place after testing.
1. If on-premises availability works, check the hybrid servers' outbound connectivity to the endpoints required by the [current dedicated hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app) and [Microsoft 365 connectivity guidance](/microsoft-365/enterprise/urls-and-ip-address-ranges).

For Exchange Server SE hybrid deployments, use the dedicated hybrid application. Don't reintroduce legacy federation-token or shared-service-principal instructions as an ASURL repair. If the failed request uses Graph rather than EWS, troubleshoot that flow separately.

### Verify the resolution

Repeat the Autodiscover test in the affected profile and confirm that it returns the correct EWS URL. Then repeat the original cloud-target availability lookup in Scheduling Assistant and confirm that the ASURL error no longer occurs.

## More information

- [Resolve free/busy errors](Resolve-free-busy-errors.md)
