---
title: Hybrid free/busy fails with a client assertion signature or key not found error
description: Check the current OAuth certificate on the dedicated Exchange hybrid application when an on-premises free/busy request fails to acquire a token.
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
# Hybrid free/busy fails with a client assertion signature or key not found error

## Summary

This article addresses a certificate mismatch when Exchange Server SE uses its dedicated hybrid application to acquire an OAuth token. Confirm the application in the failed request before applying a certificate update.

## Symptoms

An on-premises user can't retrieve an Exchange Online user's availability. An EWS OAuth connectivity test returns HTTP 401 with an authentication error that includes:

```text
Client assertion contains an invalid signature.
The key was not found.
```

## Cause

The certificate used to sign the client assertion isn't available to the application that validates it. For a deployment that uses the dedicated Exchange hybrid application, check that application's certificate configuration. Don't assume that updating the legacy shared Exchange Online service principal repairs the dedicated application.

## Resolution

1. Identify the application associated with the failed token request. Confirm that it is your [dedicated Exchange hybrid application](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app), not an unrelated application or the retired shared-service-principal workflow.
1. On the affected Exchange server, use [Get-AuthConfig](/powershell/module/exchangepowershell/get-authconfig) and [Get-ExchangeCertificate](/powershell/module/exchangepowershell/get-exchangecertificate) to inspect the current OAuth certificate:

   ```powershell
   Get-AuthConfig | Format-List CurrentCertificateThumbprint,NextCertificateThumbprint
   Get-ExchangeCertificate -Thumbprint (Get-AuthConfig).CurrentCertificateThumbprint |
       Format-List Thumbprint,NotAfter
   ```

1. If the local OAuth certificate is missing or expired, follow [Maintain the Exchange Server OAuth certificate](/exchange/plan-and-deploy/integration-with-sharepoint-and-skype/maintain-oauth-certificate) before updating the application. Don't substitute a certificate that has no corresponding private key on Exchange.
1. Follow **Update the Auth Certificate** in the [dedicated hybrid app deployment guide](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app). For a Mailbox server with the required connectivity and permissions, the documented application update is:

   ```powershell
   .\ConfigureExchangeHybridApplication.ps1 -UpdateCertificate
   ```

   Obtain the script from the deployment guide. If you use split execution, follow that guide's certificate-file procedure and export only the public certificate, not its private key.
1. Keep the certificate on the dedicated application. Don't upload it to the first-party Exchange Online service principal or reinstate MSOnline-based repair instructions.

### Verify the resolution

Follow the deployment guide's [configuration verification procedure](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app#verify-the-configuration) using [Test-OAuthConnectivity](/powershell/module/exchangepowershell/test-oauthconnectivity). Confirm successful token acquisition with the dedicated application's ID and then reproduce the original availability lookup. Token acquisition on the server running the test doesn't prove that every mailbox server or end-to-end availability request succeeds.

The EWS test and error in this article aren't proof of a Graph-specific failure. For the Graph-based hybrid flow, separately verify supported server builds, cloud availability, application permissions, and workflow configuration in the deployment guide.

## More information

- [Deploy the dedicated Exchange hybrid app](/exchange/hybrid-deployment/deploy-dedicated-hybrid-app)
