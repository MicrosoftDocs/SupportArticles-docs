---
title: Can't remove a certificate that's installed in Exchange Server
description: Provides a resolution for an error that occurs when you try to remove a certificate that's installed in Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 170888
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dugolini, arindamt, batre, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: MET150
ms.date: 01/24/2024
---

# Can't remove a certificate that's installed in Exchange Server

## Symptoms

Consider the following scenario:

- You assign a [renewed certificate](/exchange/architecture/client-access/renew-certificates) to one or more Microsoft [Exchange Server services](/exchange/architecture/client-access/assign-certificates-to-services).

- You try to remove the old certificate in the Exchange admin center (EAC) or by using the [Remove-ExchangeCertificate](/powershell/module/exchange/remove-exchangecertificate) PowerShell cmdlet.

In this scenario, you receive the following error message:

> "A special Rpc error occurs on server \<server name\>: These certificates are tagged with following Send Connectors : \<Send connector names\>. Removing and replacing certificates from Send Connector would break the mail flow. If you still want to proceed then replace or remove these certificates from Send Connector and then try this command."

:::image type="content" source="media/cannot-remove-installed-certificate/certificate-removal-error.png" alt-text="Screenshot of the error you receive when you try to remove a transport certificate that's associated with a Send connector." border="true":::

The issue occurs if the new certificate has the same [issuer name](/previous-versions/office/exchange-server-2007/bb851505(v=exchg.80)#issuer) and [subject name](/previous-versions/office/exchange-server-2007/bb851505(v=exchg.80)#subject) that are used by the old certificate.

## Cause

To avoid disruptions to mail flow, Exchange Server prevents a certificate from being removed if the issuer name and subject name are specified in the [TlsCertificateName](/powershell/module/exchange/set-sendconnector#-tlscertificatename) property of any Send connector. The format of the `TlsCertificateName` property value is "\<I\>IssuerName\<S\>SubjectName". If the `TlsCertificateName` value matches both the old and the new certificate, Exchange Server will prevent both those certificates from being removed.

## Resolution

To remove the old certificate, use the following steps. Unless noted otherwise, run the following PowerShell commands in the Exchange Management Shell (EMS).

1. Get the thumbprints of the new and old certificates. To do this, get a list of all Exchange Server certificates by running the following command. Then, identify the new and old certificates in the list.

   ```powershell
   Get-ExchangeCertificate | Format-List FriendlyName,Subject,Issuer,CertificateDomains,Thumbprint,NotBefore,NotAfter
   ```

2. For each Send connector that's reported in the error message, use the [Get-SendConnector](/powershell/module/exchange/get-sendconnector) cmdlet to build an aggregated list of associated [source transport servers](/powershell/module/exchange/set-sendconnector#-sourcetransportservers):

   ```powershell
   Get-SendConnector -Identity <connector name> | Format-List SourceTransportServers
   ```

   Or, identify the source transport servers in the EAC as follows:

   1. Navigate to **Mail flow** \> **Send connectors**.

   2. For each Send connector that's reported in the error message:

      1. Double-click to open the connector.

      2. Navigate to **Scoping** \> **Source server** to see the servers associated with that connector.

3. To minimize mail flow issues during this procedure, stop the Microsoft Exchange Transport service by running the following command on each source transport server that you found in step 2. The command doesn't have to be run in the EMS, but it does require an elevated PowerShell session.

   ```powershell
   Stop-Service MSExchangeTransport
   ```

   Or, stop the Microsoft Exchange Transport service by using the Services.msc snap-in on each source transport server.

   > [!NOTE]
   > After you stop the transport service, mail flow on each source transport server is stopped until you restart the Microsoft Exchange Transport service in the final step of this procedure. For more information about mail flow in Exchange Server, see [Queues and messages in queues](/exchange/mail-flow/queues/queues-and-messages-in-powershell).

4. For each Send connector that's reported in the error message, use the [Set-SendConnector](/powershell/module/exchange/set-sendconnector) cmdlet to clear its `TlsCertificateName` property:

   ```powershell
   Set-SendConnector -Identity <connector name> -TlsCertificateName $Null
   ```

   > [!NOTE]
   > If you have a large environment that uses different sites, you might have to [force AD replication](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc835086(v=ws.11)) to fully remove the `TlsCertificateName` property value on the affected source transport servers.

5. For each source transport server that you found in step 2, remove the old certificate by running the following command:

   ```powershell
   Remove-ExchangeCertificate -Server <server name> -Thumbprint <old certificate thumbprint>
   ```

   Or you can remove the old certificate in the EAC as follows:

   1. Navigate to **Servers** \> **Certificates**.

   2. For each source transport server that you found in step 2:

      1. Select the server.

      2. Select the old certificate, and then delete it.

   > [!NOTE]
   > If you don't remove the old certificate from all applicable source transport servers before you reassign the `TlsCertificateName` property value, you will have to repeat the resolution procedure to remove the remaining instances of the old certificate.

6. Generate the `TlsCertificateName` property value by running the following commands:

   ```powershell
   $cert = Get-ExchangeCertificate -Thumbprint <new certificate thumbprint>
   $tlscertificatename = "<i>$($cert.Issuer)<s>$($cert.Subject)"
   ```

7. For each Send connector reported in the error message, run the following command to assign the `TlsCertificateName` property value that you generated in step 6:

   ```powershell
   Set-SendConnector -Identity <connector name> -TlsCertificateName $tlscertificatename
   ```

8. Restart the Microsoft Exchange Transport service by running the following command on each source transport server that you found in step 2. The command doesn't have to be run in the EMS, but it does require an elevated PowerShell session.

   ```powershell
   Start-Service MSExchangeTransport
   ```

   Or, you can start the Microsoft Exchange Transport service in the Services.msc snap-in on each source transport server.

## More information

To determine which certificate a Send or Receive connector is using, follow these steps:

1. [Enable protocol logging](/exchange/mail-flow/connectors/configure-protocol-logging) for the connector. For more information about protocol logging, see [Protocol logging in Exchange Server](/exchange/mail-flow/connectors/protocol-logging).

2. Open the most recent protocol log file for the connector. You can determine the applicable log folder path by running the following command in EMS:

   ```powershell
   Get-TransportService | Format-List Identity,*ProtocolLogPath
   ```

3. In the protocol log file, find the certificate information for the connector by searching for an entry that starts with "Sending certificate" in the `context` column. The certificate information is in the `data` column of the same row. The format of the certificate information is "\<Subject\> \<Issuer\> \<SerialNumber\> \<Thumbprint\> \<NotBefore\> \<NotAfter\> \<CertificateDomains\>".

   You can find the corresponding Exchange Server certificate by running the following command in EMS:

   ```powershell
   Get-ExchangeCertificate | Format-List Subject,Issuer,SerialNumber,Thumbprint,NotBefore,NotAfter,CertificateDomains
   ```

For more information about certificate management, see [Certificate procedures in Exchange Server](/exchange/architecture/client-access/certificate-procedures).
