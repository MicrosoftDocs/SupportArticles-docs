---
title: Certificate Validation Failure
description: Troubleshoots Certificate Validation Failure.
ms.date: 12/05/2023
ms.reviewer: prmadhes, jopilov, v-sidong
ms.custom: sap:Connection issues
---
# Certificate Validation Failure

In this article
Network Trace
Network Trace with Comments
Explanation

This topic shows the usual pattern of packets when the client fails to validate the server certificate.
In the client application, the error message is similar to this:

System.Data.SqlClient.SqlException:
A connection was successfully established with the server, but then an error occurred during the login process.
(provider: SSL Provider, error: 0 - The certificate chain was issued by an authority that is not trusted.)
---> System.ComponentModel.Win32Exception: The certificate chain was issued by an authority that is not trusted

> [!NOTE]
> This article intended for someone familiar with taking and reading network traces.

## Network Trace Example

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

## Network Trace example With Comments

Frame  Date and Time        Source IP    Dest IP      Description
-----  -------------------  -----------  -----------  -----------------------------------------------------------------------------------
TCP 3-way handshake establishes a basic TCP connection.

590    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=CE....S., SrcPort=56277, DstPort=1433, PayloadLen=0, 
593    8:34:51 AM 3/9/2022  10.10.10.20  10.10.10.10  TCP:Flags=.E.A..S., SrcPort=1433, DstPort=56277, PayloadLen=0, 
596    8:34:51 AM 3/9/2022  10.10.10.10  10.10.10.20  TCP:Flags=...A...., SrcPort=56277, DstPort=1433, PayloadLen=0, 

The PreLogin packet from the client indicates data encryption is required.
This also implies the client will try to validate the certificate.

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

## Explanation

Check the network trace to understand the communication flow between the client and server.

- Frame 590 - 599: TCP handshake and PreLogin packet indicating data encryption is required.
- Frame 605 - 617: TLS handshake with Server Hello sending the server certificate.
- Frame 686 - 719: Termination of the connection due to certificate validation failure.

Here client requests data encryption, triggering validation of the server certificate,the server sends a self-signed certificate (SSL_Self_Signed_Fallback), causing validation failure.

When the client requests data encryption (Encrypt=yes or Use Encryption for Data=True) or the server requires data encryption (Force Encryption=Yes for newer drivers only), then the client driver will try to validate the server certificate.
Note: If encryption is not requested, then the Login packet is still encrypted but the certificate is not validated.
In order to validate the server certificate, the client's computer (CA) certificate store must contain a copy of the server certificate or a trusted root certificate or a trusted intermediate certificate. When you buy a certificate from a 3rd-party certificate authority, Windows usually comes preinstalled with the root certificate and you don't have to do anything.
If your company has a certificate authority, then you need to push out the root or intermediate certificates via a Group Policy or add them manually.
If you have a self-signed certificate, then you generally need to add that manually if the number of clients needing it are small, but you can use a Group Policy. Export it from the SQL Server without the Private Key for security.

If SQL Server is not using a certificate, then it will generate one for itself. 

Short-term mitigation: set TrustServerCertificate=Yes in the applications' connection string. 

Long-term mitigation: Purchase or generate a certificate for the server.
This example shows SQL Server using a self-generated certificate, but any certificate could be in the Server Hello packet if it's not trusted on the client for some reason.

## See also

A network-related or instance-specific error occurred while establishing a connection to SQL Server

Configure SQL Server Database Engine for encryption - SQL Server | Microsoft Learn
Certificate requirements for SQL Server - SQL Server | Microsoft Learn
Connect to an availability group listener - SQL Server Always On | Microsoft Learn