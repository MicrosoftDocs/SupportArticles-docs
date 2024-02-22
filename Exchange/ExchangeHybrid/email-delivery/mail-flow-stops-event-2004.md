---
title: Mail flow to EXO stops and event 2004 is logged
description: Fixes an issue in which mail flow to Exchange Online stops and a Failed to establish appropriate TLS channel UntrustedRoot Access Denied error message is logged in Event Viewer.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Mail flow to Exchange Online stops and event ID 2004 is logged on the hybrid transport server

_Original KB number:_ &nbsp; 2888788

## Problem

You experience the following symptoms in a hybrid deployment of on-premises Microsoft Exchange Server and Microsoft Exchange Online in Microsoft 365:

- Mail flow to Exchange Online stops.
- The following event is recorded in the Application log of the on-premises transport server that contains the connector to your Microsoft 365 environment:

    > Event ID: 2004  
    > Log Name: Application  
    > Source: MSExchangeTransport  
    > Date: \<MM/DD/YY/YY> \<Hr:Min:Sec> \<AM/PM>  
    > Event ID: 2004  
    > Task Category: SmtpSend  
    > Level: Information  
    > Keywords: Classic  
    > User: N/A  
    > Computer: exchange.contoso.com  
    >
    > Description:  
    > Send connector Outbound to Office 365: Message delivery was not successful. The message with message ID \<MessageID> was acknowledged with SMTP response 454 4.7.0 Failed to establish appropriate TLS channel: UntrustedRoot: Access Denied.

## Cause

This issue can occur if all the following conditions are true:

- The SMTP service was assigned two certificates that match the domain name of the on-premises transport server that contains the connector to your Microsoft 365 environment.
- One of the certificates was issued by a certification authority (CA) that's trusted by Windows Live, and the other certificate was issued by a nontrusted CA (such as an internal root CA).

In this scenario, the Exchange transport server establishes a Transport Layer Security (TLS) session to the cloud gateway by using the available SMTP certificate. However, when the Exchange transport server tries to establish a TLS session by using the certificate from the nontrusted CA, the cloud gateway doesn't accept the connection.

## Solution

Unbind the SMTP service on the certificate that's issued by the nontrusted CA. To do this, follow these steps:

1. Get the details of the assigned services. For example, in the Exchange Management Shell, run the following cmdlet:

    ```powershell
    Get-ExchangeCertificate -Thumbprint <thumbprint of nontrusted CA> | fl friendlyname,services
    ```

    The output of this example is as follows:

    ```output
    FriendlyName : Microsoft Exchange  
    Services : IMAP, POP, IIS, SMTP
    ```

2. Unbind the SMTP service. For example, in the Exchange Management Shell, run the following cmdlet:

    ```powershell
    Enable-ExchangeCertificate -Thumbprint <thumbprint of nontrusted certificate> -Services IIS, pop, imap
    ```

3. Check the services that are assigned to the certificate. For example, in the Exchange Management Shell, run the following cmdlet:

    ```powershell
    Get-ExchangeCertificate -Thumbprint <thumbprint of nontrusted CA> | fl friendlyname,services
    ```

    The output of this example is as follows:

    ```output
    FriendlyName : Microsoft Exchange
    Services : IMAP, POP, IIS
    ```

## More information

For more information about trusted root CAs, see [Trusted root certification authorities for federation trusts](/exchange/trusted-root-certification-authorities-for-federation-trusts-exchange-2013-help).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
