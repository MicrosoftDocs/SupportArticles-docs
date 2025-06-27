---
title: RequiredTls flag should be set to true error
description: Describes an issue in which you receive a RequiredTls flag should be set to true if TlsCertificateName is specified error message when you run the Hybrid Configuration wizard. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# RequiredTls flag should be set to true if TlsCertificateName is specified error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3062283

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

When you run the Hybrid Configuration wizard, you receive the following error message:

> Execution of the Set-HybridMailflow cmdlet had thrown an exception. This may indicate invalid parameters in your Hybrid Configuration settings.
>
> RequiredTls flag should be set to true if TlsCertificateName is specified.
>
> at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet Dictionary`2 parameters Boolean ignoreNotFoundErrors)

## Cause

The problem can occur if the send connector or receive connector has a Transport Layer Security (TLS) name that's not in the certificate. This can happen if the certificate changed and caused mismatched names for the connector.

## Resolution

Rerun the Hybrid Configuration wizard. When you're prompted to specify the fully qualified domain name (FQDN) of the on-premises server that is running Microsoft Exchange Server, make sure that the name that you enter is on a certificate that's bound to the Simple Mail Transfer Protocol (SMTP) service.

## More information

To determine which certificate and domain name can be used, follow these steps:

1. Open Exchange Management Shell on the on-premises Exchange server, and then run the following command:

    ```powershell
    Get-ExchangeCertificate |fl Services,CertificateDomains,thumbprint,IsSelfSigned
    ```

2. Look for certificates in which the **Services** value is **SMTP**.
3. Look for certificates in which the `IsSelfSigned` parameter is set to **False**.
4. Examine the **CertificateDomains** values that remain, and then look for the domain name that you configured for external DNS.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
