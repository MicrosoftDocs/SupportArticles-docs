---
title: Optimize performance with automatic proxy-configuration scripts
description: This article describes how to optimize the performance of an automatic proxy-configuration script (PAC file, also known as Wpad.dat).
ms.date: 9/10/2020
ms.prod-support-area-path: 
ms.reviewer: heikom
---
# Optimizing performance with automatic proxy-configuration scripts (PAC)

## Summary

This topic explains how to optimize the performance of an automatic proxy-configuration script (PAC file, also known as Wpad.dat). This document focuses on how to resolve issues with the intranet servers directly and external internal traffic through a proxy-server.

## More information

For more information about the functions that are used to evaluate an address (URL or hostname), see: [Use proxy autoconfiguration (.pac) files with IEAK 11](https://docs.microsoft.com/internet-explorer/ie11-ieak/proxy-auto-config-examples).

> [!NOTE]
> The `isInNet()`, `isResolvable()`, and `dnsResolve()` functions send queries to the DNS-subsystem. Therefore, you should avoid, or, at least, minimize the use of these functions.

### Query for NetBIOS names

NetBIOS names (server names that contain no period) are used in the intranet only and are not routed through the proxy:

```js
if (isPlainHostName(host))
    return "DIRECT";
```

### Query for internal DNS suffixes

Internally used DNS zones are typically routed directly. The easiest way to determine such hosts is by using the `dnsDomainis` function:

```js
if (dnsDomainIs(host, ".dns.company.com"))
    return "DIRECT";
```

An alternative and faster method for the same result can be obtained by using `ShExMatch()`. This function does a string compare. It returns the same result but adds an asterisk (*) as a wildcard character:

```js
if (shExpMatch(host, "*.dns.company.com"))
    return "DIRECT";
```

### Query for IP ranges

If the IP address of the host belongs to the local intranet, regardless of the web server name, it should bypass the proxy in order to navigate directly.

If the IP address is entered directly into the address bar, you do not have to resolve it again. You can use the following code to check whether the host is already in the IP address format:

```js
var isIpV4Addr = /^(\d+.){3}\d+$/;
  ret = isIpV4Addr.test(host);
```

This code checks whether the variable host contains three numerals that are followed by a period and then followed by another numeral. The result is then passed to the variable return. The result is "true" for an IP and "false" otherwise.

In the following code snippet, the variable host IP contains the IP address for use in future checks:

```js
var hostIP;
var isIpV4Addr = /^(\d+.){3}\d+$/;
if (isIpV4Addr.test(host))
    hostIP = host;
else
    hostIP = dnsResolve(host);
```

When a non-existing host is passed to the function (for example, the user entered something wrong in the address bar), the result in host IP might be zero. Any additional error handling will be done by the proxy:

```js
if (hostIP==0)
    return "PROXY myproxy:80";
```

Because we have the IP address of the host, the internal IP ranges have to be checked.
Whenever possible, use the `shExpMatch` function instead of `isInNet`. The following code snippets have identical results, although `shExpMatch` runs faster:

```js
if (isInNet(hostIP, "95.53.0.0", "255.255.0.0"))
    return "DIRECT";
if (shExpMatch(hostIP, "95.53.*))
        return "DIRECT";
```

### JavaScript is case-sensitive

The proxy script uses the JavaScript language. JavaScript is case-sensitive. Therefore, an IF clause that is uppercase will never become true, while other parameters use lowercase. Internet Explorer itself converts the variables host and URL into lowercase before the `FindProxyForURL` function is called.

This condition is not true for `WinHTTP`. This is because `WinHTTP` passes the host and the URL directly to the function.

Therefore, the parameters that are checked within the PAC file should be converted within the PAC before they are evaluated:

```js
host = host.toLowerCase();
```

### Using IPv6

If you want to use and handle IPv6 addresses, Internet Explorer supports them because Internet Explorer is included in every currently supported Windows version (and in WinHTTP since Windows Vista). However, in this case, you have to use "Ex" functions (such as `isInNetEx()`), as mentioned in the following article:

[IPv6-Aware Proxy Helper API Definitions](/windows/win32/winhttp/ipv6-aware-proxy-helper-api-definitions)

For an example of `myIpAddressEx` implementation, see ["myIpAddress" function returns incorrect result in Internet Explorer 9](https://support.microsoft.com/help/2839111).

### Testing a PAC file

If the script contains any syntax error (for example, a missing ")" character in an IF statement), the script is not run. To minimize errors, consider using a script editor that runs syntax checking. By using Visual Studio, you can rename the extension of the PAC file to JavaScript during editing.

> [!NOTE]
> Starting in Windows 10, you can no longer use file-based PAC files. For more information, see the following articles:
>
> - [Windows 10 does not read a PAC file referenced by a file protocol](/troubleshoot/browsers/cannot-read-pac-file)
> - [Debugging Proxy Configuration Scripts in the new Edge](https://textslashplain.com/2020/03/25/debugging-proxy-configuration-scripts-in-the-new-edge/)

### Testing with Autoprox.exe

Sometimes, you have to test the PAC file even if you have no access to the website. To do this, you can use the [Autoprox.exe command line tool](https://ieee.azurewebsites.net/pierrelc/autoprox.exe).

If you open the tool within a command without using additional parameters, the following output is returned:

```console
C:\temp>autoprox
Version : 2.1.0.0
Usage : AUTOPROX -s  (calling DetectAutoProxyUrl and saving wpad.dat file in temporary file)
Usage : AUTOPROX  [-h] url [Path to autoproxy file]
       -h: calls InternetInitializeAutoProxyDll with helper functions implemented in AUTOPROX
AUTOPROX url: calling DetectAutoProxyUrl and using WPAD.DAT logic to find the proxy for the url
AUTOPROX url path: using the autoproxy file from the path to find proxy for the url
Example: autoprox -s
Example: autoprox http://www.microsoft.com
Example: autoprox -h http://www.microsoft.com c:\inetpub\wwwroot\wpad.dat
Example: autoprox http://www.microsoft.com http://proxy/wpad.dat
```

Here is the output if it uses our sample:

```console
C:\temp>autoprox http://us.msn.com c:\temp\sample.pac
The Winsock 2.2 dll was found okay
url: http://us.msn.com
autoproxy file path is : c:\temp\sample.pac
Calling InternetInitializeAutoProxyDll with c:\temp\sample.pac
        Calling InternetGetProxyInfo with url http://us.msn.com and host us.msn.com
        Proxy returned for url http://us.msn.com is:
PROXY myproxy:80;
```

When you want to see which DNS-related functions have been called, you can also use the `-h` parameter. In this case, the output resembles the following:

```console
C:\temp>autoprox -h http://us.msn.com c:\temp\sample.pac
The Winsock 2.2 dll was found okay
Will call InternetInitializeAutoProxyDll with helper functions
url: http://us.msn.com
autoproxy file path is : c:\temp\sample.pac
Calling InternetInitializeAutoProxyDll with c:\temp\sample.pac
        Calling InternetGetProxyInfo with url http://us.msn.com and host us.msn.com
ResolveHostByName called with lpszHostName: us.msn.com
ResolveHostByName returning lpszIPAddress: 65.55.206.229
        Proxy returned for url http://us.msn.com is:
PROXY myproxy:80;
```

### Error handling in Autoprox.exe

If you specify a non-existing PAC file (for example, a typo in the command line), the result from Autoprox.exe is as follows:

> ERROR: InternetInitializeAutoProxyDll failed with error number 0x6 6.

If the PAC file contains syntax errors, you receive the following message:

> ERROR: InternetGetProxyInfo failed with error number 0x3eb 1003.

After you finish the local test, you should copy the PAC file to the web server on which it will be accessed through the HTTP protocol.

Example:

```js
function FindProxyForURL(url, host) {
    // NetBIOS-names
    if (isPlainHostName(host))
        return "DIRECT";
    // change to lower case – if not already been done
    host = host.toLowerCase();
    // internal DNS-suffixes
    if (shExpMatch(host, "*.corp.company.com") ||
        shExpMatch(host, "*.dns.company.com"))
        return "DIRECT";
    // Save the IP-address to variable hostIP
    var hostIP;
    var isIpV4Addr = /^(\d+.){3}\d+$/;
    if (isIpV4Addr.test(host))
        hostIP = host;
    else
        hostIP = dnsResolve(host);
    // IP could not be determined -> go to proxy
    if (hostIP == 0)
        return "PROXY myproxy:80";
    // These 3 scopes are used only internally
    if (shExpMatch(hostIP, "95.53.*") ||
        shExpMatch(hostIP, "192.168.*") ||
        shExpMatch(hostIP, "127.0.0.1"))
        return "DIRECT";
    // Eveything else goes through the proxy
    return "PROXY myproxy:80;";
}
```

[!INCLUDE [Third party disclaimer](../includes/third-party-contact-disclaimer.md)]
