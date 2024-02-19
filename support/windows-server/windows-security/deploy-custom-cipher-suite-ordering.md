---
title: How to deploy custom cipher suite ordering in Windows Server 2016
description: Describes how to deploy custom cipher suite ordering in Windows Server 2016.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:secure-channel-issues, csstroubleshoot
---
# How to deploy custom cipher suite ordering in Windows Server 2016

This article provides information to help you deploy custom cipher suite ordering for Schannel in Windows Server 2016.

_Applies to:_ &nbsp; Windows Server 2016  
_Original KB number:_ &nbsp; 4032720

## Summary

To deploy your own cipher suite ordering for Schannel in Windows, you must prioritize cipher suites that are compatible with HTTP/2 by listing these first. Cipher suites that are on the HTTP/2 ([RFC 7540](https://tools.ietf.org/html/rfc7540)) block list must appear at the bottom of your list. For example:

Cipher block chaining (CBC) mode cipher suites:

- TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
- TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384

Non-PFS (perfect forward secrecy) cipher suites:

- TLS_RSA_WITH_AES_256_GCM_SHA384
- TLS_RSA_WITH_AES_128_GCM_SHA256

If the cipher suites that are on the block list are listed toward the top of your list, HTTP/2 clients and browsers may be unable to negotiate any HTTP/2-compatible cipher suite. This results in a failure to use the protocol.

For example, when you use Chrome, you may receive the error ERR_SPDY_INADEQUATE_TRANSPORT_SECURITY.

The default ordering in Windows Server 2016 is compatible with HTTP/2 cipher suite preference. Additionally, this ordering is good beyond HTTP/2, as it favors cipher suites that have the strongest security characteristics. Therefore, the default ordering makes sure that HTTP/2 on Windows Server 2016 won't have any cipher suite negotiation issues with browsers and clients.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

If the failure to use the protocol occurs, you must disable HTTP/2 temporarily while you reorder the cipher suites.  

To enable and disable HTTP/2, follow these steps:

1. Start regedit (Registry Editor).
2. Move to this subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HTTP\Parameters`.
3. Set DWORD type value EnableHttp2Tls to one the following:
    - Set it to 0 to disable HTTP/2.
    - Set it value to 1 to enable HTTP/2.
4. Restart the computer.

## References

- [Cipher suites in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/cipher-suites-in-schannel)

- [What is HTTP/2?](/iis/get-started/whats-new-in-iis-10/http2-on-iis#what-is-http2)
