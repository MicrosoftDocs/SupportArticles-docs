---
title: OAuth authentication configuration fails
description: Describes an error that occurs when you run the Hybrid Configuration wizard. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: timothyh
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Exchange OAuth authentication couldn't find the authorization certificate with thumbprint error when running Hybrid Configuration

_Original KB number:_ &nbsp; 3089171

## Symptoms

When you run the Hybrid Configuration wizard, OAuth authentication configuration fails, and you receive the following error message:

> Exchange OAuth authentication couldn't find the authorization certificate with thumbprint \<Thumbprint> in your on-premises organization. Run Get-AuthConfig cmdlet to verify the CurrentCertificateThumbprint information.

## Cause

The OAuth authentication configuration looks for a specific certificate. However, this certificate either was removed or can't be accessed.

## Resolution

To fix this issue, follow these steps:

1. Open the Exchange Management Shell.
2. Identify the certificate for which the authentication configuration is looking. To do this, follow these steps:

   1. Run the following command:

        ```powershell
        Get-AuthConfig |fl CurrentcertificateThumbPrint
        ```

   2. Examine the output, and then take one of the following actions:

       - If no value is returned for `CurrentCertificateThumbPrint`, go to step 3.
       - If a value is returned for `CurrentCertificateThumbPrint`, verify that the certificate is available to Exchange. To do this, run the following command:

            ```powershell
            Get-ExchangeCertificate
            ```

         If a certificate that has a matching thumbprint is available in both locations, there should be no issues. You can run the Hybrid Configuration wizard again to set OAuth authentication. If the issue persists, go to step 3.

3. Create a new certificate. To do this, run the following command:

   ```powershell
   New-ExchangeCertificate -KeySize 2048 -SubjectName "cn= Microsoft Exchange ACS Certificate" -FriendlyName "Microsoft Exchange Server ACS Certificate" -PrivateKeyExportable $true -Services SMTP -DomainName fabrikam.com
   ```

4. Set the new certificate that you created to be used for OAuth authentication. To do this, run the following commands:

   Command 1:

   ```console
   $date=get-date
   ```

   Command 2:

   ```powershell
   Set-AuthConfig -NewCertificateThumbprint <ThumbprintFromStep4A> -NewCertificateEffectiveDate $date
   ```

   Command 3:

   ```powershell
   Set-AuthConfig -PublishCertificate
   ```

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
