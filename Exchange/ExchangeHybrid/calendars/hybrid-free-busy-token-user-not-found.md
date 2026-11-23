---
title: Hybrid free/busy fails because the user-context value in the token doesn't exist
description: Check directory synchronization when an Exchange Server user's cloud mail-user representation is absent and hybrid availability fails with an invalid_user error.
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
# Hybrid free/busy fails because the user-context value in the token doesn't exist

## Summary

Use this article when an on-premises user's corresponding cloud mail-user object isn't synchronized or provisioned and an EWS hybrid lookup reports that the token's user doesn't exist.

## Symptoms

An on-premises user can't view an Exchange Online user's availability. The lookup or an OAuth connectivity test returns HTTP 401 and an error such as:

```text
The user specified by the user-context in the token does not exist.
error_category="invalid_user"
```

This differs from an ambiguous user error, which indicates more than one matching identity.

## Cause

The on-premises mailbox user and its corresponding cloud mail-user representation aren't synchronized. The cloud service can't resolve the user context presented in the request.

## Resolution

1. Identify the on-premises requester in the failed lookup. Confirm that you aren't checking the cloud attendee instead.
1. On-premises, use [Get-Mailbox](/powershell/module/exchangepowershell/get-mailbox) to inspect that user's primary SMTP address and proxy addresses:

   ```powershell
   Get-Mailbox -Identity "onpremuser@contoso.com" |
       Format-List PrimarySmtpAddress,EmailAddresses
   ```

1. In Exchange Online PowerShell, use [Get-MailUser](/powershell/module/exchangepowershell/get-mailuser) to check for the corresponding mail-user object:

   ```powershell
   Get-MailUser -Identity "onpremuser@contoso.com" |
       Format-List PrimarySmtpAddress,ExternalEmailAddress,EmailAddresses
   ```

1. If the expected object is missing or hasn't synchronized, correct the directory synchronization problem using your supported [Microsoft Entra Connect](/entra/identity/hybrid/connect/whatis-azure-ad-connect) configuration. Check synchronization scope and any object errors before repeating synchronization. Don't create a competing cloud mailbox or unrelated mail contact as a workaround.
1. Confirm that the hybrid deployment uses the [dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app). Restoring a missing directory object doesn't replace application configuration or consent.

These symptoms and checks apply to the documented EWS OAuth failure. Don't assume that every Graph `invalid_user` response has this same synchronization cause.

### Verify the resolution

After synchronization completes, confirm that the expected mail-user object is available. Repeat the OAuth verification and the original availability lookup using the same on-premises requester and cloud target. Confirm that the error about the missing user no longer occur and availability is restored.

## More information

- [Resolve free/busy errors](/troubleshoot/outlook/calendaring/resolve-free-busy-errors)
- [Verify dedicated hybrid app configuration](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app#verify-the-configuration)
