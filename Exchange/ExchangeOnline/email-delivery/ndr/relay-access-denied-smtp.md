---
title: 550 5.7.64 TenantAttribution when users send mails externally
description: 550 5.7.64 TenantAttribution; Relay Access Denied SMTP bounce backs for external emails being relayed out through Microsoft 365.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 01/24/2024
ms.reviewer: v-six
---
# "550 5.7.64 TenantAttribution" when sending mail externally in Microsoft 365

## Symptoms

When users send mail (that is relayed out through Microsoft 365) externally, they receive the following error message:

> 550 5.7.64 TenantAttribution; Relay Access Denied SMTP.

## Cause

This issue is due to one of the following reasons:

- You use an inbound connector in Microsoft 365 that's configured to use a certificate from on-premises to verify the identity of the submitting server. (This is the recommended method. The alternative is by IP address). However, the certificate on-premises no longer matches the certificate that is specified in Microsoft 365. This may be due to a configuration change on-premises or a new/renewed certificate that uses a different name.
- The IP address that's configured in the Microsoft 365 connector no longer matches the IP address that's being used by the submitting server.

## Resolution

To identify the submitting server and authorize relay, there must be a connector that is configured correctly in Microsoft 365, and the connector must match the submitting server.

### Option 1: Rerun the HCW to update the inbound connector (recommended for hybrid customers)

Rerun the Hybrid Configuration Wizard (HCW) to update the inbound connector in Exchange Online. Be aware that any manual customization to a hybrid configuration (which is uncommon) may have to be redone after the Wizard is finished. For information about what the values for the TLS Sender certificate were and changes that are made, see the HCW logs. For more information, see [Hybrid Configuration wizard](/exchange/hybrid-configuration-wizard).

1. Download and run the Hybrid Configuration Wizard from the Exchange Online admin center.
2. Make sure that the new certificate is selected on the transport certificate page.

When the Wizard has successfully completed, the value for the `TLSSenderCertificate` name should match the certificate that's used by the on-premises server. Changes may take some time to take effect.

### Option 2: Change the inbound connector without running HCW

Make sure that the new certificate is sent from on-premises Exchange to Exchange Online Protection (EOP) when users send external mail. If the new certificate isn't sent from on-premises Exchange to EOP, there may be a certificate configuration issue on-premises. Confirm the issue by enabling logging on the send connector that is used for routing mail to Microsoft 365 and checking those logs. To find the location of the send connector logs, run the following cmdlet against the source servers that are listed in that send connector. (Here we assume that the send connector name that's used for relaying to external domains through EOP is "outbound to Microsoft 365.")

**For Exchange 2010**

```powershell
(Get-SendConnector "outbound to Microsoft 365").SourceTransportServers | foreach {get-transportserver $_.name} | Select-Object name,SendProtocolLogPath
```

**For Exchange 2013 and later versions**

```powershell
(Get-SendConnector "outbound to Microsoft 365").SourceTransportServers | foreach {get-transportservice $_.name} | Select-Object name,SendProtocolLogPath
```

1. In the send connector log, you can check for the thumbprint of the certificate that is given to Exchange Online. The following is a code example from send connector logs.

    ```output
    Date/Time,Outbound to Microsoft 365,SessionID,SequenceNumber,LocalEndpoint,RemoteEndpoint,<,220 2.0.0 SMTP server ready, Date/Time,Outbound to Microsoft 365,SessionID,SequenceNumber,LocalEndpoint,RemoteEndpoint,*,,Sending certificate Date/Time,Outbound to Microsoft 365,SessionID,SequenceNumber,LocalEndpoint,RemoteEndpoint,*,CN=*.contoso.com,Certificate subject Date/Time,Outbound to Microsoft 365,SessionID,SequenceNumber,LocalEndpoint,RemoteEndpoint,*,"CN=CommonName, OU= OrganizationalUnit, O=OrganizationName, L=Location, S=State, C=Country",Certificate issuer name Date/Time,Outbound to Microsoft 365,SessionID,SequenceNumber,LocalEndpoint,RemoteEndpoint,*,CertificateSerialNumber,Certificate serial number Date/Time,Outbound to Microsoft 365,SessionID,SequenceNumber,LocalEndpoint,RemoteEndpoint,*,CertificateThumbprintNumber,Certificate thumbprint
    ```

2. At this point, you can locate the matching inbound connector in Microsoft 365 and verify that the certificate value matches. In this example, the `TlsSenderCertificateName` value must be set to *.contoso.com.

    > [!NOTE]
    > To relay messages through Microsoft 365, the domain of the sender or the domain of contoso.com must be verified in the Microsoft 365 tenant. Otherwise, you may see an error similar to that described in Symptoms but also an explicit ATT36 error. (For information about the ATT36 error, see [Configure a certificate-based connector to relay email messages through Microsoft 365](../office-365-notice.md).)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
