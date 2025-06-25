---
title: Outbound email messages are not sent
description: Outbound email messages for recipients outside your organization are queued and not sent on the Exchange Hub Transport server or the Edge server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Need Help with Configuring Mailflow, Mail routing (Connectors, Domains)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: rrajan, scottlan, v-six
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Outbound email messages are not sent on the Exchange Hub Transport or Edge server

_Original KB number:_ &nbsp; 4051498

## Symptoms

When you examine the status of the queue, you notice the following error message:

> 451 4.4.0 Primary target IP address responded with: "421 4.4.1 Connection timed out." Attempted failover to alternate host, but that did not succeed. Either there are no alternate hosts, or delivery failed to all alternate hosts.

Additionally, the following entry is logged in the Send connector logs if logging is enabled:

> TLS negotiation failed with error UnknownCredentials.

## Cause

This issue occurs if a third-party certificate that is installed on the server that is running Exchange Server is not bound to the SMTP service.

## Resolution

To resolve this issue, bind the third-party certificate to the SMTP service. To do this, follow these steps:

1. Enable logging on the Send connector. To do this, run the following command:

    ```powershell
    Set-SendConnector "<SendConnectorName>" -ProtocolLoggingLevel Verbose
    ```

2. In the Send connector logs, look for the thumbprint of the TLS certificate. Sample log:

    > 2017-10-07T04:42:56.804Z,Outbound to Office 365,08D50D3D9730A8D2,16,10.10.248.7:16547,216.32.181.234:25,\*,"CN=\*.domain.com, OU=Enterprise SSL Wildcard, OU=Contoso IT, O=Contoso Corporation",Certificate subject  
    2017-10-07T04:42:56.804Z,Outbound to Office 365,08D50D3D9730A8D2,17,10.10.248.7:16547,216.32.181.234:25,\*,"CN=Trusted Secure Certificate Authority 5, O=Corporation Service Company, L=Wilmington, S=DE, C=US",Certificate issuer name  
    2017-10-07T04:42:56.804Z,Outbound to Office 365,08D50D3D9730A8D2,18,10.10.248.7:16547,216.32.181.234:25,\*,xxxxxxxxxxxxxxxxxxxxxx,Certificate serial number  
    2017-10-07T04:42:56.804Z,Outbound to Office **365,08D50D3D9730A8D2,19,10.10.248.7:16547,216.32.181.234:25,\*,xxxxxxxxxxxxxxxxxxxxxx,Certificate thumbprint**  
    2017-10-07T04:42:56.804Z,Outbound to Office 365,08D50D3D9730A8D2,20,10.10.248.7:16547,216.32.181.234:25,\*,\*.domai.com;`conotso.com`,Certificate alternate names  
    2017-10-07T04:42:56.804Z,Outbound to Office 365,08D50D3D9730A8D2,21,10.10.248.7:16547,216.32.181.234:25,\*,,TLS negotiation failed with error UnknownCredentials

3. Verify the services that are associated with the TLS certificate. To do this, run the following command. The names of the services are used in the next step.

    ```powershell
    Get-ExchangeCertificate -ThumbPrint "<TLSCertThumbprint>" | select-object services
    ```

4. Bind the certificate to the SMTP service. To do this, run the following command:

    ```powershell
    Enable-ExchangeCertificate -ThumbPrint "<TLSCertThumbprint>" -services <ServicesNames>
    ```

    Example:

    ```powershell
    Enable-ExchangeCertificate -ThumbPrint "xxxxxxxxxxxxxxxxxxxx" -services SMTP,IIS,POP
    ```

5. At the prompt to replace the existing certificate by using the new certificate, type *N*, and then press **Enter**.
