---
title: Disable and replace TLS 1.0 in ADFS
description: Provides guidance and considerations for disabling and replacing TLS 1.0 in ADFS.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-federation-services-ad-fs, csstroubleshoot
---
# Considerations for disabling and replacing TLS 1.0 in AD FS

This article provides guidance and considerations for disabling and replacing TLS 1.0 in Active Directory Federation Services (AD FS).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3194197

## Summary

Many customers are considering the option to disable TLS 1.0 and RC4 protocol in AD FS, and replace it with TLS 1.1 or a later version. This article discusses problems that can occur if you disable TLS 1.0, and provides guidance to help you complete the process.

After you disable TLS 1.0 on AD FS or AD FS proxy (WAP) servers, those servers might experience some of the following symptoms:

- Connectivity between an AD FS proxy and an AD FS server fails. This may cause any of the following conditions:

  - The proxy configuration fails either in the wizard or by using Windows PowerShell.
  - Events ID 422 is logged on AD FS proxies:

    > Unable to retrieve proxy configuration from the Federation Service.
  - Proxies cannot forward traffic to AD FS servers, and the following error message is generated:

    > Error HTTP 503 - The service is unavailable.

- AD FS cannot update the federation metadata of the Relying Party Trusts or Claims Provider Trusts that are configured.
- You receive an HTTP 503 error message:

    > The service is unavailable. HTTP 503 accessing to Office 365 services for federated domains.

- You receive an RDP error message:

    > RDP connectivity lost to the servers.

## Cause

This problem occurs if customers disable old protocols by using **SChannel** registry keys. For an example of this practice, see the [Disable old protocols in the registry](#disable-old-protocols-in-the-registry) section.

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

ADFS is developed by using Microsoft .NET Framework. For .NET applications to support strong cryptography (that is, TLS 1.1 and above), you must first install the updates that are described in the following security advisory: [Microsoft Security Advisory 2960358](/security-updates/SecurityAdvisories/2015/2960358).

> [!IMPORTANT]
> Customers who are running .NET Framework 3.5 applications on Windows 10 or .NET Framework 4.5/4.5.1/4.5.2 applications on systems that have the .NET Framework 4.6 installed must follow the steps that are provided in this advisory to manually disable RC4 in TLS. For more information, see the **Suggested Actions** section of the advisory.

> [!NOTE]
>
> - Systems that are running the .NET Framework 4.6 only are protected by default and do not have to be updated.
> - The additional steps from the security advisory require that you create the **SchUseStrongCrypto** registry key, as described in the advisory article.
>
>    Examples of subkeys for this new registry key:
>
>   - [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727] SchUseStrongCrypto=dword:00000001
>   - [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319] SchUseStrongCrypto=dword:00000001
>   - [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319] SchUseStrongCrypto=dword:00000001
>   - [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727] SchUseStrongCrypto=dword:00000001
>
> - To apply the change, you must restart the following services and applications:
>   - ADFS Service (adfssrv)
>   - Device Registration Service (drs)
>   - Any other .NET application that might be running in the server
>   - The Internet Information Services (IIS) application pool for ADFS (applies only to ADFS 2.0 and ADFS 2.1)

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

## Disable old protocols in the registry

An example of disabling old protocols by using **SChannel** registry keys would be to configure the values in registry subkeys in the following list. These disable SSL 3.0, TLS 1.0, and RC4 protocols. Because this situation applies to SChannel, it affects all the SSL/TLS connections to and from the server.

> reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client" /v Enabled /t REG_DWORD /d 00000000  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server" /v Enabled /t REG_DWORD /d 00000000  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" /v Enabled /t REG_DWORD /d 00000000  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled /t REG_DWORD /d 00000000  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128" /v Enabled /t REG_DWORD /d 00000000  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128" /v Enabled /t REG_DWORD /d 00000000  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128" /f  
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128" /v Enabled /t REG_DWORD /d 00000000

> [!NOTE]
> You must restart the computer after you change these values.

To verify that a server that's connected to the Internet has successfully disabled old protocols, you can use any online SSL Test verifier such as Qualys SSL Labs. For more information, see [SSL Server Test](https://www.ssllabs.com/ssltest/).

## Alternative solution

As an alternative to using the **SchUseStrongCrypto** registry key, you can use the **SystemDefaultTlsVersions** registry key when you use the .NET Framework 3.5.1.

**SystemDefaultTlsVersions** is available after you install [update 3154518](https://support.microsoft.com/help/3154518).

After the registry keys are set, the ADFS service honors SChannel defaults and work.

## Known side effects

Here are know side effects.

### Client applications can't connect to ADFS server or ADFS proxy for authentication

When you disable TLS 1.0 and earlier versions on ADFS servers and proxies, the client applications that are trying to connect to it must support TLS 1.1 or later versions.

This is true, for example, of Android mobile 4.1.1 when you use the Intune Company Portal application to enroll that device. The Intune application cannot show the ADFS sign-in page.

This is expected in this Android version because TLS 1.1 is disabled by default.

You can get more details about these potential problems by collecting network traces on the ADFS server or proxies while you reproduce the connection failure. In this scenario, you can work with the client OS vendor or application vendor to verify that newer TLS versions are supported. ADFS cannot update federation metadata.

#### Scenario 1

- ADFS cannot automatically retrieve the Federationmetadata.xml from the Relying Party Trusts or Claims Provider Trusts.
- When you try to update the XML file manually, you receive the following error message:

    > An error occurred during an attempt to read the federation metadata.
- Or, you receive the following error message when you use Windows PowerShell:

    > The underlying connection was closed. An unexpected error occurred on a receive.

By analyzing the underlying exception more closely, we can see the following information:

> PS C:\> Update-AdfsRelyingPartyTrust -TargetName "Microsoft Office 365 Identity Platform"  
Update-AdfsRelyingPartyTrust : The underlying connection was closed: An unexpected error occurred on a receive.  
At line:1 char:1  
\+ Update-AdfsRelyingPartyTrust -TargetName "Microsoft Office 365 Identity Platform ...
\+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
 \+ CategoryInfo : NotSpecified: (Microsoft.Ident...lyingPartyTrust:RelyingPartyTrust) [Update-AdfsRelyingP
 artyTrust], WebException  
 \+ FullyQualifiedErrorId : The underlying connection was closed: An unexpected error occurred on a receive.,Microso
 ft.IdentityServer.Management.Commands.UpdateRelyingPartyTrustCommand  
>
> PS C:\> $error[0] | fl * -f  
writeErrorStream : True  
PSMessageDetails :  
Exception : System.Net.WebException: The underlying connection was closed: An unexpected error occurred on
 a receive. ---> System.ComponentModel.Win32Exception: The client and server cannot
 communicate, because they do not possess a common algorithm  
 at System.Net.SSPIWrapper.AcquireCredentialsHandle(SSPIInterface SecModule, String package,
 CredentialUse intent, SecureCredential scc)  
 at System.Net.Security.SecureChannel.AcquireCredentialsHandle(CredentialUse credUsage,
 SecureCredential& secureCredential)  
 at System.Net.Security.SecureChannel.AcquireClientCredentials(Byte[]& thumbPrint)  
 at System.Net.Security.SecureChannel.GenerateToken(Byte[] input, Int32 offset, Int32 count,
 Byte[]& output)  
 at System.Net.Security.SecureChannel.NextMessage(Byte[] incoming, Int32 offset, Int32 count)  
 at System.Net.Security.SslState.StartSendBlob(Byte[] incoming, Int32 count,
 AsyncProtocolRequest asyncRequest)  
 at System.Net.Security.SslState.ForceAuthentication(Boolean receiveFirst, Byte[] buffer,
 AsyncProtocolRequest asyncRequest)  
 at System.Net.Security.SslState.ProcessAuthentication(LazyAsyncResult lazyResult)  
 at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext,
 ContextCallback callback, Object state, Boolean preserveSyncCtx)  
 at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback
 callback, Object state, Boolean preserveSyncCtx)  
 at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback
 callback, Object state)  
 at System.Net.TlsStream.ProcessAuthentication(LazyAsyncResult result)  
 at System.Net.TlsStream.Write(Byte[] buffer, Int32 offset, Int32 size)  
 at System.Net.ConnectStream.WriteHeaders(Boolean async)  
 --- End of inner exception stack trace ---  
 at System.Net.HttpWebRequest.GetResponse()  
 at Microsoft.IdentityServer.Management.Resources.Managers.RelyingPartyTrustManager.ApplyMeta
 dataFromUrl(RelyingPartyTrust party, Uri metadataUrl, String& warnings)  
 at Microsoft.IdentityServer.Management.Commands.UpdateRelyingPartyTrustCommand.OperateOnRely
 ingPartyTrust(RelyingPartyTrust party)  
 at
 Microsoft.IdentityServer.Management.Commands.RemoveRelyingPartyTrustCommand.ProcessRecord()  
TargetObject : Microsoft.IdentityServer.Management.Resources.RelyingPartyTrust  
CategoryInfo : NotSpecified: (Microsoft.Ident...lyingPartyTrust:RelyingPartyTrust)  
 [Update-AdfsRelyingPartyTrust], WebException  
FullyQualifiedErrorId : The underlying connection was closed: An unexpected error occurred on a
 receive.,Microsoft.IdentityServer.Management.Commands.UpdateRelyingPartyTrustCommand  
ErrorDetails : The underlying connection was closed: An unexpected error occurred on a receive.
InvocationInfo : System.Management.Automation.InvocationInfo  
ScriptStackTrace : at \<ScriptBlock>, \<No file>: line 1  
PipelineIterationInfo : {0, 1}

When we analyze the network traces, we don't see any ClientHello. Also, the client itself (ADFS) is closing the connection (TCP FIN) when we would expect it to send the ClientHello:

> 3794 *\<DateTime>* 4.0967400 (4588) adfs1 nexus.microsoftonline-p.com.nsatc.net TCP 8192 TCP: [Bad CheckSum]Flags=CE....S., SrcPort=56156, DstPort=HTTPS(443)  
4013 *\<DateTime>* 4.1983176 (0) nexus.microsoftonline-p.com.nsatc.net adfs1 TCP 2097152 TCP:Flags=...A..S., SrcPort=HTTPS(443), DstPort=56156  
4021 *\<DateTime>* 4.1983388 (0) adfs1 nexus.microsoftonline-p.com.nsatc.net TCP 131328 TCP: [Bad CheckSum]Flags=...A...., SrcPort=56156, DstPort=HTTPS(443)  
4029 *\<DateTime>* 4.1992083 (4588) adfs1 nexus.microsoftonline-p.com.nsatc.net TCP 131328 TCP: [Bad CheckSum]Flags=...A...F, SrcPort=56156, DstPort=HTTPS(443)  
4057 *\<DateTime>* 4.2999711 (0) nexus.microsoftonline-p.com.nsatc.net adfs1 TCP 0 TCP:Flags=...A.R.., SrcPort=HTTPS(443), DstPort=56156

The reason for this is that the SChannel registry keys were created. These remove support for SSL 3.0 or TLS 1.0 as a client.

However, the **SchUseStrongCrypto** key wasn't created. So after we establish the TCP/IP session, the ClientHello should be sent by having these conditions:

- .NET by using weak cryptography (only TLS 1.0 and earlier versions)
- SChannel configured to use only TLS 1.1 or later versions

Resolution: Apply SchUseStrongCrypto and reboot.

HTTP 503 in access to Office 365 services

#### Scenario 2

- Only TLS 1.1 and later versions are supported in the ADFS serviceOffice.
- You have a O365 federated domain.
- The client is accessing some O365 service that is using proxiedauthentication: Client application sent the credential using HTTP Basic, and the O365 service is using those credentials in a new connection to ADFS to authenticate the user.
- The cloud service sends a TLS 1.0 to ADFS, and ADFS closes the connection.
- The client receives a response HTTP 503.

For example, this is true when you access Autodiscover. In this scenario, Outlook clients are affected. This can be easily reproduced by opening a web browser and going to `https://autodiscover-s.outlook.com/Autodiscover/Autodiscover`.

`xmlRequest` sent:

> GET `https://autodiscover-s.outlook.com/Autodiscover/Autodiscover.xml` HTTP/1.1  
Host: autodiscover-s.outlook.com  
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0  
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8  
Accept-Language: en-US,en;q=0.5  
Accept-Encoding: gzip, deflate, br  
Connection: keep-alive  
Authorization: Basic (REMOVED FOR PRIVACY)

Response received from Exchange Online service:  

> HTTP/1.1 503 Service Unavailable  
Cache-Control: private  
Retry-After: 30  
Server: Microsoft-IIS/8.0  
request-id: 33c23dc6-2359-44a5-a819-03f3f8e85aae  
X-CalculatedBETarget: db4pr04mb394.eurprd04.prod.outlook.com  
X-AutoDiscovery-Error: LiveIdBasicAuth:FederatedStsUnreachable:\<X-forwarded-for:*\<IP Address>*>\<FederatedSTSFailure>System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send.;  
X-DiagInfo: DB4PR04MB394  
X-BEServer: DB4PR04MB394  
X-AspNet-Version: 4.0.30319  
Set-Cookie: X-BackEndCookie2=; expires=*\<DateTime>*; path=/Autodiscover; secure; HttpOnly  
Set-Cookie: X-BackEndCookie=; expires=*\<DateTime>*; path=/Autodiscover; secure; HttpOnly  
X-Powered-By: ASP.NET  
X-FEServer: AM3PR05CA0056  
Date: *\<DateTime>*  
Content-Length: 0

Analyzing network traces in the WAP server, we can see several connections coming from our cloud, as follows. WAP terminates (TCP RST) these connections soon after it receives the Client Hello.

> 3282 *\<DateTime>* 10.8024332 (0) 132.245.225.68 62047 (0xF25F) 10.10.1.5 443 (0x1BB) TCP 52 (0x34) 32 8192 TCP:Flags=CE....S., SrcPort=62047, DstPort=HTTPS(443), PayloadLen=0, Seq=1681718623, Ack=0, Win=8192 ( Negotiating scale factor 0x8 ) = 8192  
3285 *\<DateTime>* 10.8025263 (0) 10.10.1.5 443 (0x1BB) 132.245.225.68 62047 (0xF25F) TCP 52 (0x34) 32 8192 TCP: [Bad CheckSum]Flags=.E.A..S., SrcPort=HTTPS(443), DstPort=62047, PayloadLen=0, Seq=3949992650, Ack=1681718624, Win=8192 ( Negotiated scale factor 0x8 ) = 8192  
3286 *\<DateTime>* 10.8239153 (0) 132.245.225.68 62047 (0xF25F) 10.10.1.5 443 (0x1BB) TCP 40 (0x28) 20 517 TCP:Flags=...A...., SrcPort=62047, DstPort=HTTPS(443), PayloadLen=0, Seq=1681718624, Ack=3949992651, Win=517  
3293 *\<DateTime>* 10.8244384 (0) 132.245.225.68 62047 (0xF25F) 10.10.1.5 443 (0x1BB) TLS 156 (0x9C) 136 517 TLS:TLS Rec Layer-1 HandShake: Client Hello.  
3300 *\<DateTime>* 10.8246757 (4) 10.10.1.5 443 (0x1BB) 132.245.225.68 62047 (0xF25F) TCP 40 (0x28) 20 0 TCP: [Bad CheckSum]Flags=...A.R.., SrcPort=HTTPS(443), DstPort=62047, PayloadLen=0, Seq=3949992651, Ack=1681718740, Win=0 (scale factor 0x0) = 0

We also see that Client Hello is using TLS 1.0:

> Frame: Number = 3293, Captured Frame Length = 271, MediaType = NetEvent  
\+ NetEvent:  
\+ MicrosoftWindowsNDISPacketCapture: Packet Fragment (170 (0xAA) bytes)  
\+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[00-0D-3A-24-43-98],SourceAddress:[12-34-56-78-9A-BC]  
\+ Ipv4: Src = *\<IP Address>*, Dest = *\<IP Address>*, Next Protocol = TCP, Packet ID = 31775, Total IP Length = 156  
\+ Tcp: Flags=...AP..., SrcPort=62047, DstPort=HTTPS(443), PayloadLen=116, Seq=1681718624 - 1681718740, Ack=3949992651, Win=517  
 TLSSSLData: Transport Layer Security (TLS) Payload Data  
\- TLS: TLS Rec Layer-1 HandShake: Client Hello.  
 \- TlsRecordLayer: TLS Rec Layer-1 HandShake:  
 ContentType: HandShake:  
 \- Version: TLS 1.0  
 Major: 3 (0x3)  
 Minor: 1 (0x1)  
 Length: 111 (0x6F)  
 \- SSLHandshake: SSL HandShake ClientHello(0x01)  
 HandShakeType: ClientHello(0x01)  
 Length: 107 (0x6B)  
 \- ClientHello: TLS 1.0  
 \+ Version: TLS 1.0  
 \+ RandomBytes:  
 SessionIDLength: 0 (0x0)  
 CipherSuitesLength: 14  
 \+ TLSCipherSuites: TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA { 0xC0,0x14 }  
 \+ TLSCipherSuites: TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA { 0xC0,0x13 }  
 \+ TLSCipherSuites: TLS_RSA_WITH_AES_256_CBC_SHA { 0x00, 0x35 }  
  \+ TLSCipherSuites: TLS_RSA_WITH_AES_128_CBC_SHA { 0x00, 0x2F }  
 \+ TLSCipherSuites: TLS_RSA_WITH_3DES_EDE_CBC_SHA { 0x00,0x0A }  
 \+ TLSCipherSuites: TLS_RSA_WITH_RC4_128_SHA { 0x00,0x05 }  
 \+ TLSCipherSuites: TLS_RSA_WITH_RC4_128_MD5 { 0x00,0x04 }  
 CompressionMethodsLength: 1 (0x1)  
 CompressionMethods: 0 (0x0)  
 ExtensionsLength: 52 (0x34)  
 \- ClientHelloExtension: Server Name(0x0000)  
 ExtensionType: Server Name(0x0000)  
 ExtensionLength: 19 (0x13)  
 NameListLength: 17 (0x11)  
 NameType: Host Name (0)  
 NameLength: 14 (0xE)  
 ServerName: sts.contoso.net  
 \+ ClientHelloExtension: Elliptic Curves(0x000A)  
 \+ ClientHelloExtension: EC Point Formats(0x000B)  
 \+ ClientHelloExtension: SessionTicket TLS(0x0023)  
 \+ ClientHelloExtension: Unknown Extension Type  
 \+ ClientHelloExtension: Renegotiation Info(0xFF01)

In this scenario, it's expected that ADFS proxy is rejecting the connection. This problem has been reported to Exchange Online team and is under investigation.

Workarounds:  

- Use Modern Authentication.

    > [!NOTE]
    > This has not been tested. However, conceptually, the connection to ADFS is directly from the client application. Therefore, it should work if it supports TLS 1.1.

- Re-enable TLS 1.0 Server in WAP/ADFS proxy.

## References

- [Payment Card Industry (PCI) Data Security Standard (DSS)](/microsoft-365/compliance/offering-pci-dss)

- [Error While Configuring WAP–"The Underlying Connection Was Closed"–Part 2](/archive/blogs/keithab/error-while-configuring-wapthe-underlying-connection-was-closedpart-2)  

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
