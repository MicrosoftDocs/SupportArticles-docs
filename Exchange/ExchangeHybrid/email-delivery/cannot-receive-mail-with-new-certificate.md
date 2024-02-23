---
title: Can't receive mail if installing new certificate
description: Describes an issue in which you don't receive mail and the STARTTLS command is missing on a hybrid server after you install a new certificate. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: trudolf, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't receive mail in a hybrid environment after you install a new certificate on the server

_Original KB number:_ &nbsp; 2989382

## Symptoms

After you install a new Exchange certificate in an Exchange Server hybrid environment, you experience the following symptoms:

- You cannot receive mail from the Internet or from Microsoft 365 when you use Transport Layer Security (TLS).
- If you use Telnet (for example, telnet localhost 25) to examine Simple Mail Transfer Protocol (SMTP) communications, you notice that the `STARTTLS` command is missing.
- If you examine the Application log in Event Viewer, you see an event entry that resembles the following:

    > Log Name: Application  
    Source: MSExchangeFrontEndTransport  
    Date: MM/DD/YYYY 0:00:00 AM  
    Event ID: 12014  
    Task Category: TransportService  
    Level: Error  
    Keywords: Classic  
    User: N/A  
    Computer: \<HybridServerName>.contoso.com  
    Description:  
    Microsoft Exchange could not find a certificate that contains the domain name \<I>CN=Certificate Name, OU=\<CertificateIssuer>, O=Certificate Provider, C=US\<S>CN=`mail.contoso.com`, OU=IT, O=contoso, L=location, S=location, C=US in the personal store on the local computer.

- The check connectivity test to the on-premises server fails, and you receive the following error message:

    > 450 4.4.101 Proxy session setup failed on Frontend with '451 4.4.0 Primary target IP address responded with "451 5.7.3 STARTTLS is required to send mail." Attempted failover to alternate host, but that did not succeed. Either there are no alternate hosts, or delivery failed to all alternate hosts. The last endpoint attempted was \<endpoint>'.

## Cause

This issue occurs if the `TlsCertificateName` property of the hybrid server's receive connector contains incorrect certificate information after a new Exchange certificate is installed and old certificate that is used for hybrid mail flow is removed.

The `TlsCertificateName` property is set correctly when the Hybrid Configuration wizard (HCW) is run after a new Exchange certificate is installed.

However, if the HCW is not run, or if a failure occurs for any other reason when you run the HCW, the `TlsCertificateName` property is not updated, and the new Exchange certificate is not used by the hybrid server's receive connector.

In this scenario, the `STARTTLS` command is not present in SMTP communications, and the mail flow from Microsoft 365 fails.

## Resolution

Make sure that the new certificate is enabled for SMTP. If it's not, run the following command to enable the SMTP service on the newly installed certificate.

```powershell
Enable-ExchangeCertificate <thumbprint> -services SMTP
```

> [!NOTE]
> Select **No** when you are prompted to overwrite the default certificate). Otherwise, EdgeSync breaks and has to be re-created. Then, remove the `TlsCertificateName` property from the receive connector on the hybrid server. To do this, run the following command:

```powershell
Get-ReceiveConnector "ServerName\Default Frontend ReceiveConnector" | Set-ReceiveConnector -TlsCertificateName $null
```

Rerun the Hybrid Configuration wizard to update the receive connector on the hybrid server that has the newly installed certificate information.

## More information

For more information, see [Certificate requirements for hybrid deployments](/exchange/certificate-requirements).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
