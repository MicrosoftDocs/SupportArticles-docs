---
title: TLS negotiation failed with error NoCredentials error
description: Email messages that are sent to external domains get deferred and generate an error entry that states TLS negotiation failed with error NoCredentials in the Send Connector logs.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow\Not Able to Send or Receive Emails from Internet
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: rrajan, batre, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# TLS negotiation failed with error NoCredentials error if messages to external domains are deferred

_Original KB number:_ &nbsp; 4495258

## Symptoms

Email messages that are sent to External domains are queued in on-premises Exchange Server (2016 or 2013). When you check the status, you receive the following error message:

> 421 4.4.1 Connection timed out." Attempted failover to alternate host, but that did not succeed. Either there are no alternate hosts, or delivery failed to all alternate hosts.

Additionally, the following error entry in the Send Connector logs indicates that Transport Layer Security (TLS) negotiation has failed:

> TLS negotiation failed with error NoCredentials

## Cause

This issue occurs if the following conditions are true:

- The certificate that's used for outbound TLS is missing a private key.
- You populate the `TLSCertificateName` attribute by using the **Issuer** and **SubjectName** strings of the certificate. Additionally, the `<I>Issuer string<S>SubjectName string` attribute is used for outbound TLS within the Send Connector to route email messages to external domains.

## Resolution

To resolve this issue, follow these steps:

1. Enable logging on the Send Connector that is authoritative for sending email messages. To do this, run the following PowerShell cmdlet as an administrator:

    ```powershell
    Set-SendConnector "NameOfTheSendCconnector" -ProtocolLoggingLevel Verbose
    ```

1. Review the Send Connector logs to identify the certificate that's used during outbound TLS. For example, the log entry may resemble the following:

    > Date/Time.ConnectorId,Outbound to Office 365,SessionId,16,192.168.0.78:28252,172.16.38.36:25,*,,Sending certificate  
    Date/Time.ConnectorId,Outbound to Office 365,SessionId,17,192.168.0.78:28252,172.16.38.36:25,*,CN=*.xxx.xxx.xxx,Certificate subject  
    Date/Time.ConnectorId,Outbound to Office 365,SessionId,18,192.168.0.78:28252,172.16.38.36:25,*,"CN=xxxxxx, OU=xxxxxx, O=xxxx, L=xxxx, S=xxxxx, C=xx",Certificate issuer name  
    Date/Time.ConnectorId,Outbound to Office 365,SessionId,19,192.168.0.78:28252,172.16.38.36:25,*,xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx,Certificate serial number  
    Date/Time.ConnectorId,Outbound to Office 365,SessionId,20,192.168.0.78:28252,172.16.38.36:25,*,xxxxxxxxxxxxxxxxxxxxxxxxxxxx,Certificate thumbprint  
    Date/Time.ConnectorId,Outbound to Office 365,SessionId,21,192.168.0.78:28252,172.16.38.36:25,*,*.xxxx.xxx.xx alternate names  
    Date/Time.ConnectorId,Outbound to Office 365,SessionId,22,192.168.0.78:28252,172.167.38.36:25,*,,TLS negotiation failed with error NoCredentials

1. Check the status of the `PrivateKey` property for the certificate that's identified in step 2. To do this, run the following cmdlet:

    ```powershell
    Get-ChildItem -Path Cert:\LocalMachine\My | where {$_.Thumbprint -like 'Certificate thumbprint identified in step 2'} | Select-Object -Property thumbprint,hasprivatekey
    ```

1. Remove the certificate that's identified in step 2 by running the following cmdlet:

    ```powershell
    Get-ChildItem -Path Cert:\LocalMachine\My | where {$_.Thumbprint -like 'Certificate thumbprint identified in step 2'} | remove-item
    ```

    > [!NOTE]
    > Before you remove the certificate that's identified in step 2, make sure that there is no dependency of the certificate on any other application that's running on the server that running Microsoft Exchange Server. If there is a dependency, make the required changes in the application so that the application starts by using the certificate that's mentioned in step 5.

1. Import a valid third-party certificate through the usual import process, and then check the status of the certificate from the Exchange Management Shell by running the following cmdlet.

   ```powershell
   Get-ExchangeCertificate | where {$_.rootca -eq 'third-party certificate'}
   ```

    > [!NOTE]
    > Exchange Management Shell always lists certificates that have a valid private key.

1. Enable SMTP service on the newly imported third-party certificate by running the following cmdlet:

   ```powershell
   Enable-Exchangecertificate -thumbprint "Thumbprint of the new certificate" -services SMTP
   ```

    > [!NOTE]
    > When you're prompted to replace the existing certificate by using a new certificate, type **No**.

1. If the third-party certificate was already imported, Exchange Server starts by using the new third-party certificate.

1. Run the following cmdlet to perform a retry against the messages in queue.

   ```powershell
   Get-queue -resultsize unlimited | where {$_.status -eq 'retry'} | retry-queue
   ```
