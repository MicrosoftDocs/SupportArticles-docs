---
title: Free/busy lookup fails due to missing signing certificate
description: Fix a hybrid free/busy lookup that fails with "Missing signing certificate" by restoring the Exchange Server Auth Certificate and updating the dedicated hybrid application.
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
ms.date: 11/16/2026
---
# Free/busy lookup fails due to missing signing certificate

## Summary

This article helps you fix a hybrid free/busy lookup that fails because the Exchange Server OAuth signing certificate is missing. It explains how to check whether the Auth Certificate configured in Exchange is present on the involved on-premises server, restore it by using current certificate-maintenance guidance, and update the dedicated hybrid application if the certificate is replaced.

## Symptoms

A hybrid free/busy lookup fails. When you analyze an [HTTP Archive (HAR) network trace](../../ExchangeOnline/calendars/collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following message:

> Microsoft.Exchange.Security.OAuth.OAuthTokenRequestFailedException: Missing signing certificate.

The error might be reported with HTTP status `401 Unauthorized`. Use the specific certificate error, not HTTP 401 alone, to identify this issue.

## Cause

The Exchange Server Auth Certificate that signs OAuth tokens is missing or isn't available as configured on the involved Exchange server.

This issue differs from a receiving service that rejects a signature because an application has an outdated certificate registration.

## Resolution

1. On the involved on-premises server, open Exchange Management Shell and check the configured current Auth Certificate:

   ```powershell
   (Get-AuthConfig).CurrentCertificateThumbprint |
       Get-ExchangeCertificate |
       Format-List Subject,Thumbprint,NotAfter,NotBefore
   ```

   For more information, see [Get-AuthConfig](/powershell/module/exchangepowershell/get-authconfig) and [Get-ExchangeCertificate](/powershell/module/exchangepowershell/get-exchangecertificate).

1. If Exchange reports that it can't find the certificate that has the configured thumbprint, follow the missing-certificate procedure in [Maintain the Exchange Server OAuth certificate](/exchange/plan-and-deploy/integration-with-sharepoint-and-skype/maintain-oauth-certificate).

   Use that procedure to distinguish an already missing or expired certificate from a planned rotation. Don't apply a scheduled rotation as if it were an immediate missing-certificate repair.

1. Check that the configured Auth Certificate is present and valid on each involved Exchange server.
1. If the certificate was replaced, follow [Update the Auth Certificate for the dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app#update-the-auth-certificate). The certificate-maintenance guidance covers replication and rerunning the Hybrid Configuration Wizard.

   > [!IMPORTANT]
   > Don't use legacy MSOnline commands to upload the certificate to the shared Exchange service principal. Current hybrid coexistence uses the dedicated Exchange hybrid application.

1. Follow the verification steps in the [dedicated hybrid application guidance](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app#verify-the-configuration).
1. Repeat the original availability lookup. Confirm that availability is returned without the certificate error.

An Exchange Web Services (EWS) connectivity test verifies only that test's EWS/OAuth path. It doesn't replace a real free/busy lookup or prove that a Graph-based request succeeded.

If the lookup succeeds, no further action is needed.

### If the issue persists

If the certificate is still unavailable or the lookup still fails, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide the following information:

- The requester and target identities
- The involved servers
- The exact error message
- The request time, including time zone
- The configured certificate thumbprint and validity output
- The application verification results

Don't include a certificate private key, token, or secret.
