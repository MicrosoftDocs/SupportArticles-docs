---
title: Errors when applications try to connect to SQL Server in Windows
description: Fixes an issue that occurs when an application tries to open a connection to a SQL Server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: sureshka, arrenc, juburke, stacygr, jburchel, diassis, stefze, mastewa, ardenw, kaushika
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Transport Layer Security (TLS) or Schannel (SSL), csstroubleshoot
---
# Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows

This article helps fix an issue that occurs when an application tries to open a connection to a SQL Server.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4557473

## Symptoms

When an application tries to open a connection to a SQL Server,  one of the following error messages is displayed:

> A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - An existing connection was forcibly closed by the remote host.)

> A connection was successfully established with the server, but then an error occurred during the pre-login handshake. (provider: TCP Provider, error: 0 - An existing connection was forcibly closed by the remote host.)

If you enabled [SChannel logging](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn786445%28v=ws.11%29#how-to-enable-schannel-event-logging) on the Server, you'll receive [Event ID 36888 (A Fatal Alert was generated)](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn786445%28v=ws.11%29#event-id-36888-a-fatal-alert-was-generated) when the issue occurs.

> [!NOTE]  
>
> - Depending on the provider or driver that you're using, the error message may slightly vary.
> - This issue also occurs when an application running on Windows Server 2012 R2 tries to connect to SQL Server running on Windows Server 2019.
> - Other client-server applications may encounter a similar issue.

## Cause

Windows 10, version 1511 and later versions of Windows, including Window Server 2016 or Windows 10, version 1607 that has updates released on Feb 25thor later updates installed, contains a leading zero update. Meanwhile, all Windows versions that released before that don't contain the leading zero updates.  

The TLS client and server need to calculate keys exactly the same way otherwise they get different results. TLS connections randomly fail if leading zeros are computed differently by the TLS client and TLS Servers.  

When a [Diffie-Hellman key exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange) group has leading zeros, unpatched computers may incorrectly compute the mac by not accounting for the padded zeros. This issue is typically seen when interacting with non-Windows-based crypto implementations and can cause intermittent negotiation failures.  

The error messages are returned when the secure TLS handshake is negotiated between the client and the server by using TLS_DHE cipher suite. The use of one of the affected cipher suites can be identified in the "Server Hello" packet. For more information, see the network snippet in the "More information" section.  

## Resolution

To fix this issue, make sure that both the client and server involved in a connection are running Windows that have the leading zero fixes for TLS_DHE installed. It's recommended to install the updates since they enhance the conformance to TLS_DHE specifications.

The following list the operating system version according to the updates that are installed.

### Windows versions that contain the leading zero fixes for TLS_DHE

- Windows Server 2016, version 1607  
  - KB 4537806: February 25, 2020-KB4537806 (OS Build 14393.3542)  
  - KB 4540670: March 10, 2020-KB4540670 (OS Build 14393.3564)  
  - Updates that supersede KB4537806 and KB4540670 for the respective OS versions  
- Windows Server 2019 RTM and later versions.  
- Windows 10, version 1511, and later versions of Windows 10 (see [release history](https://en.wikipedia.org/wiki/Windows_10_version_history))  

### Windows versions that don't contain the leading zero fixes for TLS_DHE

- Windows Server 2016, version 1607 servers that don't have the patches KB 4537806 and KB 4540670 applied.  
- Windows 10, version 1507  
- Windows 8.1  
- Windows 7  
- Windows Server 2012 R2 and earlier versions of Windows Server  

## Workaround

If you can't update Windows, as a workaround, you can disable the TLS_DHE ciphers by using one of the two methods.

### Using Group Policy

TLS_DHE_* ciphers can be disabled by using Group Policy. Refer to [Prioritizing Schannel Cipher Suites](/windows/win32/secauthn/prioritizing-schannel-cipher-suites) to configure the "SSL Cipher Suite Order" group policy.

Policy URL: Computer Configuration -> Administrative Templates -> Network -> SSL Configuration Settings  
Policy Setting: SSL Cipher Suite Order setting.​

### Using a PowerShell script

```powershell
foreach ($CipherSuite in $(Get-TlsCipherSuite).Name)
{
    if ( $CipherSuite.substring(0,7) -eq "TLS_DHE" )
    {
       "Disabling cipher suite: " + $CipherSuite
       Disable-TlsCipherSuite -Name $CipherSuite
    }
    else
    {
        "Existing enabled cipher suite will remain enabled: " + $CipherSuite
    }
}
```

## More information

You can confirm that you're encountering this issue during the connection establishment. When the issue occurs, you can see the following sequence in the network trace on the server.

```output
1103479 <DateTime> 382.4104867 <Application IP> <Server IP> TCP:Flags=CE....S., SrcPort=62702, DstPort=1433, PayloadLen=0, Seq=829174047, Ack=0, Win=8192 ( Negotiating scale factor 0x8 ) = 8192  
1103486 <DateTime> 382.4105589 <Server IP> <Application IP> TCP: [Bad CheckSum]Flags=...A..S., SrcPort=1433, DstPort=62702, PayloadLen=0, Seq=267349053, Ack=829174048, Win=65535 ( Negotiated scale factor 0x8 ) = 16776960  
1103493 <DateTime> 382.4113628 <Application IP> <Server IP> TCP:Flags=...A...., SrcPort=62702, DstPort=1433, PayloadLen=0, Seq=829174048, Ack=267349054, Win=513 (scale factor 0x8) = 131328  
1103515 <DateTime> 382.4117349 <Application IP> <Server IP> TDS:Prelogin, Version = 7.300000(No version information available, using the default version), SPID = 0, PacketID = 1, Flags=...AP..., SrcPort=62702, DstPort=1433, PayloadLen=88, Seq=829174048 - 829174136, Ack=267349054, Win=131328  
1103525 <DateTime> 382.4118186 <Server IP> <Application IP> TDS:Response, Version = 7.300000(No version information available, using the default version), SPID = 0, PacketID = 1, Flags=...AP..., SrcPort=1433, DstPort=62702, PayloadLen=48, Seq=267349054 - 267349102, Ack=829174136, Win=2102272  
1103547 <DateTime> 382.4128101 <Application IP> <Server IP> TLS:TLS Rec Layer-1 HandShake: Client Hello.  
1103584 <DateTime> 382.4151314 <Server IP> <Application IP> TLS:TLS Rec Layer-1 HandShake: Server Hello. Certificate. Server Key Exchange. Server Hello Done.  
1103595 <DateTime> 382.4161185 <Application IP> <Server IP> TCP:Flags=...A...., SrcPort=62702, DstPort=1433, PayloadLen=0, Seq=829174322, Ack=267351024, Win=513 (scale factor 0x8) = 131328  
1103676 <DateTime> 382.4782629 <Application IP> <Server IP> TLS:TLS Rec Layer-1 HandShake: Client Key Exchange.; TLS Rec Layer-2 Cipher Change Spec; TLS Rec Layer-3 HandShake: Encrypted Handshake Message.  
1103692 <DateTime> 382.4901904 <Server IP> <Application IP> TCP:[Segment Lost] [Bad CheckSum]Flags=...A...F, SrcPort=1433, DstPort=62702, PayloadLen=0, Seq=267351024, Ack=829174648, Win=8210 (scale factor 0x8) = 2101760  
1103696 <DateTime> 382.4918048 <Application IP> <Server IP> TCP:Flags=...A...., SrcPort=62702, DstPort=1433, PayloadLen=0, Seq=829174648, Ack=267351025, Win=513 (scale factor 0x8) = 131328  
1103718 <DateTime> 382.4931068 <Application IP> <Server IP> TCP:Flags=...A...F, SrcPort=62702, DstPort=1433, PayloadLen=0, Seq=829174648, Ack=267351025, Win=513 (scale factor 0x8) = 131328  
1103723 <DateTime> 382.4931475 <Server IP> <Application IP> TCP: [Bad CheckSum]Flags=...A...., SrcPort=1433, DstPort=62702, PayloadLen=0, Seq=267351025, Ack=829174649, Win=8210 (scale factor 0x8) = 2101760  
```

Examining the Server Hello packet to see the cipher suite being used:

```output
Frame: Number = 1103584, Captured Frame Length = 2093, MediaType = NetEvent  
+NetEvent:  
+MicrosoftWindowsNDISPacketCapture: Packet Fragment (1976 (0x7B8) bytes)  
+Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[00-00-0C-9F-F4-5C],SourceAddress:[00-1D-D8-B8-3A-7B]  
+Ipv4: Src = <Server IP>, Dest = <Application IP>, Next Protocol = TCP, Packet ID = 16076, Total IP Length = 0  
+Tcp: [Bad CheckSum]Flags=...AP..., SrcPort=1433, DstPort=62702, PayloadLen=1938, Seq=267349102 - 267351040, Ack=829174322, Win=8211 (scale factor 0x8) = 2102016  
+Tds: Prelogin, Version = 7.300000(No version information available, using the default version), SPID = 0, PacketID = 0, Flags=...AP..., SrcPort=1433, DstPort=62702, PayloadLen=1938, Seq=267349102 - 267351040, Ack=829174322, Win=2102016  
TLSSSLData: Transport Layer Security (TLS) Payload Data  
-TLS: TLS Rec Layer-1 HandShake: Server Hello. Certificate. Server Key Exchange. Server Hello Done.  
-TlsRecordLayer: TLS Rec Layer-1 HandShake:  
ContentType: HandShake:  
+Version: TLS 1.2  
Length: 1909 (0x775)  
-SSLHandshake: SSL HandShake Server Hello Done(0x0E)  
HandShakeType: ServerHello(0x02)  
Length: 81 (0x51)  
-ServerHello: 0x1  
+Version: TLS 1.2  
+RandomBytes:  
SessionIDLength: 32 (0x20)  
SessionID: Binary Large Object (32 Bytes)  
TLSCipherSuite: TLS_DHE_RSA_WITH_AES_256_GCM_SHA384 { 0x00, 0x9F }  
CompressionMethods: 0 (0x0)  
ExtensionsLength: 9 (0x9)  
+ServerHelloExtension: Unknown Extension Type  
+ServerHelloExtension: Renegotiation Info(0xFF01)  
HandShakeType: Certificate(0x0B)  
Length: 778 (0x30A)  
+Cert: 0x1  
HandShakeType: Server Key Exchange(0x0C)  
Length: 1034 (0x40A)  
ServerKeyExchange: Binary Large Object (1034 Bytes)  
HandShakeType: Server Hello Done(0x0E)  
Length: 0 (0x0)  
+Tds: Prelogin, Version = 7.300000(No version information available, using the default version), Reassembled Packet
```

## Reference

For more information, see the following articles:

- [Manage Transport Layer Security (TLS)](/windows-server/security/tls/manage-tls)
- [TLS](/powershell/module/tls)  
