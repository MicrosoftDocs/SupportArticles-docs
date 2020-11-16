---
title: Error occurs when running Hybrid Configuration Diagnostic
description: Describes a scenario in which a No valid hybrid certificate found error is returned when you run the Exchange Hybrid Configuration Diagnostic.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: scotro
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Confirm Hybrid Certificate has IIS and SMTP services assigned to it error when you run the Exchange Hybrid Configuration Diagnostic

_Original KB number:_ &nbsp; 3064938

## Symptoms

When you run the Exchange Hybrid Configuration Diagnostic, the following error message is returned in the output:

> Check Title: Exchange HCW: Confirm Hybrid Certificate has IIS and SMTP services assigned to it and is valid  
Check Failure: No valid hybrid certificate found

## Cause

The certificate that you specified in the Hybrid Configuration wizard is not set up for the Simple Mail Transfer Protocol (SMTP) service.

## Resolution

Make sure that the certificate that you specified in the Hybrid Configuration wizard is configured correctly on your on-premises Client Access servers and Mailbox servers. To do this, follow these steps:

1. On an on-premises Client Access server or Mailbox server, open the Exchange Management Shell.
2. Run the following command:

    ```powershell
    Get-ExchangeCertificate| format-list
    ```

3. In the Hybrid Configuration wizard, you specified a certificate that was to be used for secure mail transport.Locate the information for that certificate.
4. Make sure that the following parameter values are set for the certificate:
   - `IsSelfSigned` parameter: This parameter value should be **False**.
   - `RootCAType` parameter: This parameter value should be **Third Party**.
   - `Services` parameter: This parameter value should be **IIS, SMTP (at a minimum)**.
   - `NotAfter` parameter: This parameter value is the certificate expiration date. The date should not be expired.

    > [!NOTE]
    > If IIS, SMTP, or both are missing from the *Services* parameter, enable the services. To do this, run the following command:

    ```powershell
    Enable-ExchangeCertificate -Services IIS,SMTP -thumbprint <ThumbprintOfHybridCertificate>
    ```

## More information

For more information, see [Troubleshoot a hybrid deployment](/exchange/hybrid-deployment/troubleshoot-a-hybrid-deployment).

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting tool. Run it on the server on which the Hybrid Configuration wizard failed. The tool collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, you receive a message that states what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
