---
title: How to deploy custom cipher suite ordering in Windows Server 2016
description: Describes how to deploy custom cipher suite ordering in Windows Server 2016.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# How to deploy custom cipher suite ordering in Windows Server 2016

_Original product version:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4032720

## Summary

This article provides information to help you deploy custom cipher suite ordering for Schannel in Windows Server 2016. 

## More information

To deploy your own cipher suite ordering for Schannel in Windows, you must prioritize cipher suites that are compatible with HTTP/2 by listing these first. Cipher suites that are on the HTTP/2 ([RFC 7540](https://tools.ietf.org/html/rfc7540)) **Black List** must appear at the bottom of your list. For example:
C ipher block chaining (CBC) mode cipher suites: 
- TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256 
- TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384 
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256 
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384 

Non-PFS (perfect forward secrecy) cipher suites: 
- TLS_RSA_WITH_AES_256_GCM_SHA384 
- TLS_RSA _WITH_AES_128_GCM_SHA256 

If the cipher suites that are on the Black List are listed toward the top of your list, HTTP/2 clients and browsers may be unable to negotiate any HTTP/2-compatible cipher suite. This results in a failure to use the protocol.
For example, when you use Chrome, you may receive error **ERR_SPDY_INADEQUATE_TRANSPORT_SECURITY**.
 The default ordering in Windows Server 2016 is compatible with HTTP/2 cipher suite preference. Additionally, this ordering is good beyond HTTP/2, as it favors cipher suites that have the strongest security characteristics. Therefore, the default ordering makes sure that HTTP/2 on Windows Server 2016 won't have any cipher suite negotiation issues with browsers and clients. 

## Workaround

> **[!IMPORTANT]
>** This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: 
 [322756](https://support.microsoft.com/help/322756) - How to back up and restore the registry in Windows 

If the failure to use the protocol occurs, you must disable HTTP/2 temporarily while you reorder the cipher suites according to the guidelines in the "More information" section .  

To enable and disable HTTP/2, follow these steps: 
1. Start regedit (Registry Editor). 
2. Move to this subkey:
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HTTP\Parameters` 
3. Set **DWORD** type value **EnableHttp2Tls**  to one the following:
   - 
 Set to **0** to disable HTTP/2 
   -  
 Set to **1** to enable HTTP/2 
4. 
Restart the computer.

## Reference

For more information, see [Cipher suites in TLS/SSL (Schannel SSP)](https://msdn.microsoft.com/library/windows/desktop/aa374757%28v=vs.85%29.aspx <!--ERROR-->). 
For more information about HTTP/2, see [What is HTTP/2?](https://docs.microsoft.com/iis/get-started/whats-new-in-iis-10/http2-on-iis#what-is-http2).
