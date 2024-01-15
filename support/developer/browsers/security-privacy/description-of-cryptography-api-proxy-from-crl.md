---
title: Troubleshooting network retrieval of CRLs
description: This KB article describes the proxy detection mechanism that the Cryptography (Crypto) API uses to download a CRL from a CRL distribution point. It discusses the locations of the registry where proxy information is found.
ms.date: 06/03/2020
ms.reviewer: pphadke, macox
---
# Description of the Cryptography API proxy detection mechanism when downloading a Certificate Revocation List (CRL) from a CRL distribution point

[!INCLUDE [](../../../includes/browsers-important.md)]

The purpose of this article is to explain how the Crypto API tries to find a route by which it can successfully download a HTTP-based CRL distribution point URL, and meant to help in troubleshooting scenarios related to network retrieval of CRLs.

_Original product version:_ &nbsp; Windows Server 2003 Service Pack 2, Windows Vista Enterprise, Windows Server 2008 Enterprise, Windows 7 Enterprise, Windows Server 2008 R2 Enterprise, Windows 10, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 2623724

## Summary

Consider the following scenario. Your application uses the WinINet API, WinHTTP API, or the System.Net.HttpWebRequest class of the .NET framework to send an HTTP request over SSL/TLS. During SSL/TLS secure channel negotiation, the server sends back a Server Hello message to the Client with its Server Certificate to prove its identity to the client. When doing so, the server certificate information can also contain a list of Certificate Revocation List (CRL) distribution points. These CRL distribution points list contains a URL from where the client can download the CRL and can verify whether the server certificate has been revoked by the publisher of the certificate.

The Crypto API internally uses the WinHTTP API to download the HTTP-based URL for the CRL distribution point. Before downloading the URL, WinHTTP needs to know a route to reach the CRL URL. In situations where the environment has a proxy server, WinHTTP can either automatically detect the Proxy server or it can be asked by the application consuming the WinHTTP API to use a specific proxy to download the CRL.

The Crypto API internally tries to find a Proxy server first using the below logic, and if it finds any proxy server address it asks WinHTTP to use that specific proxy instance.

If the proxy instance is not reachable or is incorrect, WinHTTP will not be able to download the CRL, the certificate revocation check will fail, and your application will receive an error from the Crypto API indicating the revocation failure. It can report the same error to the user, and depending on the implementation the secure channel establishment can fail.

When trying to discover the proxy, the Crypto API uses the following logic:

1. It checks if there are any static proxy settings configured on the machine from where the CRL check is being done. Typically this configuration is done using the netsh utility to set the proxy manually on Windows Vista, Windows 2008, Windows 7, or Windows 2008 R2. If a static proxy is found, then the Crypto API uses the statically discovered proxy to download the CRL through WinHttp. For more information on netsh, see [Netsh Commands for Windows Hypertext Transfer Protocol (WINHTTP)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731131(v=ws.10)) in the [More information](#more-information) section below.

    > [!NOTE]
    > This check is only performed on Windows Vista, Windows 2008, Windows 7 and Windows 2008 R2. On Windows 2003, Crypto API does not check static proxy settings.

2. If a statically configured proxy is not found, the Crypto API tries to retrieve the Internet Explorer proxy settings for the user context under which the Crypto API is executing.

    Depending on what your process is running as, this can be either the identity of the currently logged on user, or it can by any specific user or it can be any of the systems provided accounts - LOCAL SYSTEM, NETWORK SERVICE, LOCAL SERVICE. The following registry locations are queried based on the executing identity:

    - Currently logged on user: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings`
    - NETWORK SERVICE: `HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\Internet Settings`
    - LOCAL SYSTEM: `HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Internet Settings`
    - LOCAL SERVICE: `HKEY_USERS\S-1-5-19\Software\Microsoft\Windows\CurrentVersion\Internet Settings`
    - Any Other user: `HKEY_USERS\<<SID of that user>>\Software\Microsoft\Windows\CurrentVersion\Internet Settings`

    Depending on the registry information, the proxy settings for that user will be returned. If the proxy settings are absent, no information will be returned. If the proxy settings are returned, it can contain a combination of the below options:
    - Automatically detect settings.
    - Use automatic configuration script.
    - Proxy server.

    > [!NOTE]
    > In situations where the process is running as a different identity than the currently logged-on user, there may be an inconsistency in the proxy settings depending on how the proxy settings were configured for that user. In such cases, you may observe that browsing to the CRL location using Internet Explorer as the current user successfully downloads the CRL, but the same process fails when used from the Crypto API which is executing as another user. In such situations it is highly recommend that you check the Internet Settings of all users and make sure that they are consistent.

    The Internet Settings should ideally not be present for any non-interactive users such as NETWORK SERVICE, LOCAL SYSTEM or LOCAL SERVICE, since there will never be a need to open up Internet Explorer with those identities. In such cases, you need to ensure that these non-interactive users do not have any proxy settings configured for Internet Explorer, or make sure that they are consistent with the proxy settings for the user with which the CRL download succeeds using Internet Explorer.

3. If the Internet Explorer proxy settings are not present for the executing user or if the Internet Explorer settings for the process identity indicate. **Automatically detect settings** or **Use automatic configuration script**, the Crypto API will try to automatically discover a proxy for the CRL in question. This will either return specific proxy information or return 'no proxy' if the automatic proxy discovery fails or if the URL does not require a proxy.

    The Crypto API will attempt to use the WinHTTP API to download the CRL URL using the discovered proxy (or no proxy if the proxy could not be discovered or if the URL does not require a proxy).

    If the proxy is unreachable or if the proxy information is wrong, the fetch of the CRL URL will fail. The Crypto API will then report this error to the calling API, and depending on the implementation, the caller of the Crypto API can then decide whether to abort the request or let it through.

    > [!NOTE]
    > In cases where the application itself is consuming the WinHTTP API and has set the proxy information either in the WinHttpOpen call or WinHttpSetOption call, the Crypto API does not have access to the Proxy information that the application has set and will still try to discover the proxy information as above. The usage of the WinHttp API from the Crypto API and from your own application are independent and do not share any information with each other.

In Windows 10, CryptoAPI 2 (CAPI2) is updated so that it does not have its own proxy settings. The change is implemented in a [WinHttpOpen function](/windows/desktop/api/winhttp/nf-winhttp-winhttpopen) call where starting from Windows 10, CAPI2 uses the **WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY** flag.

|Flag Name|Description|
|---|---|
|WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY|Uses system and per-user proxy settings (including the Internet Explorer proxy configuration) to determine which proxy/proxies to use. Automatically attempts to handle failover between multiple proxies, different proxy configurations per interface, and authentication. Supported in Windows 8.1 and newer.|

> [!NOTE]
> Previous Windows versions have used the **WINHTTP_ACCESS_TYPE_DEFAULT_PROXY** flag.

The WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY flag means that WinHttp will handle the proxy detection logic, and the caller should not write any code to handle proxy configuration. If the **WINHTTP_ACCESS_TYPE_AUTOMATIC_PROXY** flag is set, WinHttp will check the default proxy configuration by using the netsh utility and then the Internet Explorer proxy settings.

> [!NOTE]
> Internet Explorer proxy settings are per-user, which means the caller should impersonate the logged-on user.

If you do not want to set a proxy for each logged-on user, you can set up a machine-wide proxy by setting the **ProxySettingsPerUser** key to 0.

|Registry Key|HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\InternetSettings\ProxySettingsPerUser|
|---|---|
|Type|REG DWORD|
|Value|<br/>0: per-machine proxy<br/>1 or no value: per-user|

After you set the registry key, you can configure the proxy with Internet Properties (Inetcpl.cpl). Machine-wide proxy settings can be changed by administrators or using the Group Policy.

## More information

For more information, see:

- [Cryptography](/windows/win32/seccrypto/cryptography-portal)
- [Netsh Commands for Windows Hypertext Transfer Protocol (WINHTTP)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731131(v=ws.10)?redirectedfrom=MSDN)
- [Windows HTTP Services](/windows/win32/winhttp/winhttp-start-page)
- [WinHttpGetDefaultProxyConfiguration function](/windows/win32/api/winhttp/nf-winhttp-winhttpgetdefaultproxyconfiguration)
- [WinHttpGetIEProxyConfigForCurrentUser function](/windows/win32/api/winhttp/nf-winhttp-winhttpgetieproxyconfigforcurrentuser)
