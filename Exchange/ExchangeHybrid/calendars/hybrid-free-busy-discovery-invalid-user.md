---
title: Hybrid free/busy fails with an Autodiscover InvalidUser error
description: Check mailbox addresses and the selected EWS endpoint when hybrid free/busy fails with an ExternalEwsUrl InvalidUser error.
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
# Hybrid free/busy fails with an Autodiscover InvalidUser error

## Summary

This article addresses an EWS-based hybrid availability request that fails because mailbox addressing or the selected endpoint is incorrect. It doesn't cover every `InvalidUser` error in a different tenant or a Microsoft Graph request.

## Symptoms

An Exchange Online user can't retrieve an on-premises user's availability. The diagnostic response includes:

```text
The response from the Autodiscover service failed due to an error in user setting 'ExternalEwsUrl'. Error message: InvalidUser.
```

## Cause

The cloud mailbox's proxy addresses or the endpoint used for the hybrid availability request can be misconfigured. Use the affected mailbox pair and the failing direction to identify which setting is incorrect rather than treating the error as a reason to recreate either mailbox.

## Resolution

Use a supported Exchange Server SE deployment with the [dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app). The following checks apply to the EWS path; they don't establish that a Graph-based request uses the same endpoint.

1. In Exchange Online PowerShell, use [Get-Mailbox](/powershell/module/exchangepowershell/get-mailbox) to inspect the cloud mailbox's proxy addresses:

   ```powershell
   Get-Mailbox -Identity "clouduser@contoso.com" |
       Format-List PrimarySmtpAddress,EmailAddresses
   ```

1. Verify that the expected secondary address in your hybrid routing domain, such as `contoso.mail.onmicrosoft.com`, is present. If the object is managed on-premises, correct the address in the authoritative on-premises directory and synchronize the change. Don't edit a synchronized property only in Exchange Online.
1. Inspect the active configuration by using [Get-IntraOrganizationConnector](/powershell/module/exchangepowershell/get-intraorganizationconnector) and [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship). Compare its discovery or EWS endpoint with the actual on-premises deployment.
1. Correct a confirmed endpoint error using the configuration object that the request actually uses. If an organization relationship is used, [Set-OrganizationRelationship](/powershell/module/exchangepowershell/set-organizationrelationship) can specify its correct `TargetSharingEpr`. Don't point a Hybrid Agent deployment at an unrelated direct-access endpoint.
1. Confirm that the selected on-premises EWS endpoint belongs to the target organization. Don't change an Exchange Online-to-Exchange Online relationship as part of this hybrid procedure.

### Verify the resolution

After the required directory synchronization finishes, reproduce the issue by using the same cloud requester and on-premises target. Confirm that `ExternalEwsUrl` no longer returns `InvalidUser` and that availability loads. Test the other direction independently.

## More information

- [Resolve free/busy errors](/troubleshoot/outlook/calendaring/resolve-free-busy-errors)
- [Deploy the dedicated Exchange hybrid app](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app)
