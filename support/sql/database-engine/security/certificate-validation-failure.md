---
title: Certificate validation failure
description: Troubleshoots certificate validation failure.
ms.date: 12/05/2023
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
---
# Certificate validation failure

> [!NOTE]
> This article is intended for someone familiar with taking and reading network traces.

## Symptoms

When your client fails to validate the server certificate, you see the following error message in the client application:

```output
System.Data.SqlClient.SqlException:
A connection was successfully established with the server, but then an error occurred during the login process.
(provider: SSL Provider, error: 0 - The certificate chain was issued by an authority that is not trusted.)
---> System.ComponentModel.Win32Exception: The certificate chain was issued by an authority that is not trusted
```

## Network trace example

```output
Frame  Date and Time        Source IP    Dest IP      Description
-----  -------------------  -----------  -----------  -----------------------------------------------------------------------------------
590    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=CE....S., SrcPort=56277, DstPort=1433, PayloadLen=0,
593    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=.E.A..S., SrcPort=1433, DstPort=56277, PayloadLen=0,
596    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=...A...., SrcPort=56277, DstPort=1433, PayloadLen=0,
599    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TDS:Prelogin, Flags=...AP..., SrcPort=56277, DstPort=1433, PayloadLen=104,
602    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TDS:Response
605    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TLS:TLS Rec Layer-1 HandShake: Client Hello.
614    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=...A...., SrcPort=1433, DstPort=56277, PayloadLen=0,
617    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TLS:TLS Rec Layer-1 HandShake: Server Hello. Certificate. Server Key Exchange. Server Hello Done.
686    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=...A...F, SrcPort=56277, DstPort=1433, PayloadLen=0,
710    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=...A...., SrcPort=1433, DstPort=56277, PayloadLen=0,
713    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=...A...F, SrcPort=1433, DstPort=56277, PayloadLen=0,
719    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=...A...., SrcPort=56277, DstPort=1433, PayloadLen=0,
```

## Network trace example with comments

```output
Frame  Date and Time        Source IP    Dest IP      Description
-----  -------------------  -----------  -----------  -----------------------------------------------------------------------------------
TCP 3-way handshake establishes a basic TCP connection.

590    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=CE....S., SrcPort=56277, DstPort=1433, PayloadLen=0, 
593    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=.E.A..S., SrcPort=1433, DstPort=56277, PayloadLen=0, 
596    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=...A...., SrcPort=56277, DstPort=1433, PayloadLen=0, 

The PreLogin packet from the client indicates data encryption is required. This also implies the client will try to validate the certificate.

599    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TDS:Prelogin, Flags=...AP..., SrcPort=56277, DstPort=1433, PayloadLen=104,

- Tds: Prelogin
  + PacketHeader: SPID = 0, Size = 104, PacketID = 1, Window = 0
  - PreLoginPacketData:
   - PreloginOptions:
    + PreloginOptionTokens:
    - PreloginOptionData:
     + VersionData:
     - EncryptionData:
        Encryption: ENCRYPT_ON 1 (0x1)    <----- Data Encryption is Requested by the client
     + InstOptData:
     + ThreadIDData:
     + MARSData:
     + TRACEIDLengthData:
     + FederatedLengthData:

602    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TDS:Response

The SSL/TLS handshake results in the server sending a certificate to the client.
For data encryption, the client tries to validate the certificate after receiving frame 617 (Server Hello).

605    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TLS:TLS Rec Layer-1 HandShake: Client Hello.
614    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=...A...., SrcPort=1433, DstPort=56277, PayloadLen=0,
617    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TLS:TLS Rec Layer-1 HandShake: Server Hello. Certificate. Server Key Exchange. Server Hello Done.

- TLS: TLS Rec Layer-1 HandShake: Server Hello. Certificate. Server Key Exchange. Server Hello Done.
  - TlsRecordLayer: TLS Rec Layer-1 HandShake:
     ContentType: HandShake:
   + Version: TLS 1.2
     Length: 847 (0x34F)
   - SSLHandshake: SSL HandShake Server Hello Done(0x0E)
      HandShakeType: ServerHello(0x02)
      Length: 81 (0x51)
    + ServerHello: 0x1
      HandShakeType: Certificate(0x0B)
      Length: 517 (0x205)
    - Cert: 0x1
       CertLength: 514 (0x202)
     - Certificates:
        CertificateLength: 511 (0x1FF)
      + X509Cert: Issuer: SSL_Self_Signed_Fallback, Subject: SSL_Self_Signed_Fallback   <---- this is SQL Server's Self-Generated Certificate
      HandShakeType: Server Key Exchange(0x0C)
      Length: 233 (0xE9)
      ServerKeyExchange: Binary Large Object (233 Bytes)
      HandShakeType: Server Hello Done(0x0E)
      Length: 0 (0x0)

The certificate is a SSL_Self_Signed_Fallback certificate, which means that it cannot be validated.
The client terminates the connection.

686    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=...A...F, SrcPort=56277, DstPort=1433, PayloadLen=0,
710    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=...A...., SrcPort=1433, DstPort=56277, PayloadLen=0,
713    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=...A...F, SrcPort=1433, DstPort=56277, PayloadLen=0,
719    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=...A...., SrcPort=56277, DstPort=1433, PayloadLen=0,
```

> [!NOTE]
> This example shows SQL Server using a self-generated certificate, but any certificate could be in the Server Hello packet if it's not trusted on the client for some reason.

## Explanation

Check the network trace to understand the communication flow between the client and server.

- **Frame 590 - 599**: TCP handshake and PreLogin packet indicating data encryption is required.
- **Frame 605 - 617**: TLS handshake with Server Hello sending the server certificate.
- **Frame 686 - 719**: Termination of the connection due to certificate validation failure.

The client requests data encryption, which triggers the validation of the server certificate. However, the server responds by sending a self-signed certificate (`SSL_Self_Signed_Fallback`), which causes the validation to fail.

When the client requests data encryption (`Encrypt=yes` or `Use Encryption for Data=True`) or the server requires data encryption (`Force Encryption=Yes` for newer drivers only), the client driver tries to validate the server certificate.

> [!NOTE]
> If encryption isn't requested, the Login packet is still encrypted but the certificate isn't validated.

In order to validate the server certificate, the client's computer certificate store must contain a copy of the server certificate, a trusted root certificate, or a trusted intermediate certificate.

When you buy a certificate from a 3rd-party certificate authority (CA), Windows usually comes preinstalled with the root certificate and you don't have to do anything.

If your company has a CA, you need to push out the root or intermediate certificates via a Group Policy or add them manually.

If you have a self-signed certificate, you generally need to add it manually if the number of clients needing it are small. However, if the number of clients is large, you can use a Group Policy to distribute the certificate. Export it from the SQL Server without the Private Key for security.

If SQL Server isn't using a certificate, it generates one for itself.

## Mitigation

Short-term mitigation: set `TrustServerCertificate=Yes` in the applications' connection string.

Long-term mitigation: Purchase or generate a certificate for the server.

## More information

- [A network-related or instance-specific error occurred while establishing a connection to SQL Server](network-related-or-instance-specific-error-occurred-while-establishing-connection.md)
- [Configure SQL Server Database Engine for encryption](/sql/database-engine/configure-windows/configure-sql-server-encryption)
- [Certificate requirements for SQL Server](/sql/database-engine/configure-windows/certificate-requirements)
- [Connect to an availability group listener](/sql/database-engine/availability-groups/windows/listeners-client-connectivity-application-failover)