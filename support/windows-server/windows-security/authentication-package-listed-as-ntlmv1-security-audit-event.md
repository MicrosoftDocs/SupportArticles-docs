---
title: Audit event shows authentication package as NTLMv1 instead of NTLMv2
description: Discusses an issue where the authentication was actually using NTLMv2 but reporting NTLMv1 in the event log.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: herbertm, kaushika
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
---
# Audit event shows authentication package as NTLMv1 instead of NTLMv2

This article discusses an issue where the authentication was actually using NTLMv2 but reporting NTLMv1 in the event log.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2701704

## Summary

You're using lmcompatibilitylevel on 3 or higher on all machines in the domain to force clients to use only NTLMv2. In testing connections to network shares by IP address to force NTLM, you discover the "Authentication Package" was still listed as NTLMv1 on the security audit event (Event ID 4624) logged on the server.

For example, you test with a Windows 7 client connecting to a file share on Windows Server 2008 R2. The network trace showed the authentication was actually using NTLMv2 but reporting NTLMv1 in the event log:

> Log Name:      Security  
Source:        Microsoft-Windows-Security-Auditing  
Event ID:      4624  
Task Category: Logon  
Level:         Information  
Keywords:      Audit Success  
Description:  
An account was successfully logged on.  
                Account Name:                               user  
                Account Domain:                            contoso  
Detailed Authentication Information:  
                Logon Process:                 NtLmSsp  
                Authentication Package:             NTLM  
                Transited Services:         -  
                Package Name (NTLM only):     NTLM V1  
                Key Length:                       128  

## More information

There are two known scenarios that can lead to this result.

- Scenario A: Windows Server 2003 Domain Controllers  

    We discovered that we can reproduce this behavior when the domain controller validating the users' credentials is a 2003 based server. Windows Server 2003 didn't have the "authentication package" field in its event logging, this was a new feature added in Windows Vista.

    If the domain controller is Windows Server 2008 or newer the server will show the authentication package listed correctly as NTLMv2. If the reporting of the authentication protocol version is important, we suggest using Windows Server 2008 or newer Domain Controllers.

    Windows Server 2003 is in the extended support phase, the support is retired in July 2015. See [Search product lifecycle](https://support.microsoft.com/lifecycle/?c2=1163).

- Scenario B: Negotiation of security levels uses "legacy" methods that mean best effort

    This scenario involves third-party clients:

    1. The customer has a third-party SMB client that is configured for NTLMv1.
    2. The file server is configured for LmCompatiblityLevel=5 and minimum sesion security NTLMv2, the DC is configured for LmCompatiblityLevel=4.
    3. A user on the third-party client connects. In the SMB, you see the security blob in the SMB session negotiation with the expected name fields and NegotiateFlags, the server rejects the negotiation:

        ```console
        NegotiateFlags: 0x60000215 (NTLM v1128-bit encryption, , Sign)
        NegotiateNTLM:                    (......................1.........) Requests usage of the NTLM v1 session security protocol.
        NegotiateNTLM2:                   (............0...................) Does NOT request usage of the NTLM v1 using the extended session security.
        ```

    4. The third-party client then retries without using the security blob (which indicates extended session security). In this format, you don't see the same known list of name fields and maybe also noNegotiateFlags. Some fields like "ClientChallenge" might indicate that the client tries to perform NTLMv2 hash processing. But because of the lack of NegotiateFlags this doesn't arrive as a NTLMv2 authentication request at the DC.
    5. The server forwards the package to the DC that authenticates the request, and since the DC is OK to use NTLMv1, it authenticates the request.
    6. The server receives the successful logon and audits that as NTLMv1 as specified by the DC.

    For logons without extended session security, the server has no option to block the logon request based on the client flags. It has to forward the request with the best flags it got to the DC. On return, it also has to accept any decision the DC makes on the logon. In this case, it accepts the logon and logs it as NTLMv1 logon, even though the resource server is configured to only allow NTLMv2.
