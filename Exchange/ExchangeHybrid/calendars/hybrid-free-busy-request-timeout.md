---
title: Hybrid free/busy fails with a request timed out error
description: Isolate a network or transient failure when an EWS hybrid availability request times out while waiting for completion.
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
# Hybrid free/busy fails with a request timed out error

## Summary

This article addresses an EWS hybrid availability request that doesn't complete in time. It helps you distinguish an intermittent failure from a repeatable endpoint connection problem.

## Symptoms

An Exchange Online user can't retrieve an on-premises user's availability. The response includes:

```text
The request timed out.
Request could not be processed in time.
```

The response can also state that the timeout occurred while waiting for the request to complete.

## Cause

Network or transient problems can prevent the request from completing. This generic error doesn't identify a specific timeout setting, server defect, or authentication failure.

## Resolution

1. Reproduce the lookup with one affected requester and one target. Record the time in UTC, the mailbox locations, and whether repeated attempts fail consistently.
1. Confirm the actual EWS or Autodiscover endpoint selected by the hybrid configuration. Review [Get-IntraOrganizationConnector](/powershell/module/exchangepowershell/get-intraorganizationconnector) and, if used, [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship). A direct EWS endpoint can bypass Autodiscover.
1. Reproduce the failure, then correlate the request with the target server's IIS and EWS logs. Check whether it reaches the server and whether the recorded processing time indicates where the delay occurs:

   ```text
   %SystemDrive%\inetpub\logs\LogFiles
   %ExchangeInstallPath%\Logging\Ews
   ```

1. Check the relevant firewall and reverse-proxy logs. Correct a confirmed connection restriction between the actual hybrid endpoints using [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges). Don't increase unrelated timeout values without evidence.
1. For OAuth token acquisition, follow the verification procedure for the [dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app#verify-the-configuration). A successful token test doesn't prove that the availability request completes.
1. If the timeout persists, collect the affected mailbox pair, exact error, reproduction time, and correlated logs for Microsoft Support. Review collected data for sensitive information before transferring it through an approved support channel.

These checks address an EWS request. For a Graph-based hybrid request, use the dedicated-app guide to verify its supported server build, permissions, workflow, and actual endpoint. Don't apply EWS timeout assumptions to Graph.

### Verify the resolution

Repeat the original lookup and confirm that availability returns without a timeout. Test the same affected target rather than relying only on a different mailbox or the reverse direction.

## More information

- [Resolve free/busy errors](/troubleshoot/outlook/calendaring/resolve-free-busy-errors)
