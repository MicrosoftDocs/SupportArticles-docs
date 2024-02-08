---
title: Optimize performance with automatic proxy-configuration scripts
description: This article describes how to optimize the performance of an automatic proxy-configuration script (PAC file, also known as Wpad.dat).
ms.date: 02/17/2022
ms.reviewer: heikom
---
# Optimizing performance with automatic proxy-configuration scripts (PAC)

[!INCLUDE [](../../../includes/browsers-important.md)]

This topic explains how to optimize the performance of an automatic proxy-configuration script (PAC file, also known as Wpad.dat). This document focuses on how to resolve issues with the intranet servers directly and external internal traffic through a proxy-server.

For more information about the functions that are used to evaluate an address (URL or hostname), see: [Use proxy autoconfiguration (.pac) files with IEAK 11](/internet-explorer/ie11-ieak/proxy-auto-config-examples).

> [!NOTE]
> The `isInNet()`, `isResolvable()`, and `dnsResolve()` functions send queries to the DNS-subsystem. Therefore, you should avoid, or, at least, minimize the use of these functions.

## Query for NetBIOS names

NetBIOS names (server names that contain no period) are used in the intranet only and are not routed through the proxy:

```js
if (isPlainHostName(host))
    return "DIRECT";
```

## Query for internal DNS suffixes

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

## Query for IP ranges

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
if (shExpMatch(hostIP, "95.53.*"))
    return "DIRECT";
```

## JavaScript is case-sensitive

The proxy script uses the JavaScript language. JavaScript is case-sensitive. Therefore, an `if` clause that is uppercase will never become true, while other parameters use lowercase. Internet Explorer itself converts the variables `host` and `url` into lowercase before the `FindProxyForURL` function is called.

This condition is not true for `WinHTTP`. This is because `WinHTTP` passes the `host` and the `url` directly to the function.

Therefore, the parameters that are checked within the PAC file should be converted within the PAC before they are evaluated:

```js
host = host.toLowerCase();
```

## Using IPv6

If you want to use and handle IPv6 addresses, Internet Explorer supports them because Internet Explorer is included in every currently supported Windows version (and in WinHTTP since Windows Vista). However, in this case, you have to use "Ex" functions (such as `isInNetEx()`), as mentioned in the following article:

[IPv6-Aware Proxy Helper API Definitions](/windows/win32/winhttp/ipv6-aware-proxy-helper-api-definitions)

For an example of `myIpAddressEx` implementation, see ["myIpAddress" function returns incorrect result in Internet Explorer 9](https://support.microsoft.com/help/2839111).

## Testing a PAC file

If the script contains any syntax error (for example, a missing ")" character in an `if` statement), the script is not run. To minimize errors, consider using a script editor that runs syntax checking. By using Visual Studio, you can rename the extension of the PAC file to ".js" during editing, but rename it back to ".pac" before uploading it to the webserver.

> [!NOTE]
> Starting in Windows 10, you can no longer use file-based PAC files. For more information, see the following articles:
>
> - [Windows 10 does not read a PAC file referenced by a file protocol](/troubleshoot/browsers/cannot-read-pac-file)
> - [Debugging Proxy Configuration Scripts in the new Edge](https://textslashplain.com/2020/03/25/debugging-proxy-configuration-scripts-in-the-new-edge/)

## Testing with Autoprox.exe

Sometimes, you have to test the PAC file even if you have no access to the website. To do this, you can use the [Autoprox.exe command line tool](https://emeaie.azurewebsites.net/pierrelc/autoprox.zip).

If you open the tool within a command without using additional parameters, the following output with the help is returned:

```console
C:\temp>autoprox
Help for AUTOPROX.EXE
Version : 2.44 (12/16/2019)
Usage : AUTOPROX -a  (calling DetectAutoProxyUrl and saving wpad.dat file in temporary file if success)
Usage : AUTOPROX -n  (calling DetectAutoProxyUrl with PROXY_AUTO_DETECT_TYPE_DNS_A only and saving wpad.dat file in temporary file if success)
Usage : AUTOPROX  [-o] [-d] [-v] [-u:url] [-p:Path to autoproxy file] [-i:IP address]
      -o: calls InternetInitializeAutoProxyDll with helper functions implemented in AUTOPROX
       -i:IP Address: calls InternetInitializeAutoProxyDll with helper functions implemented in AUTOPROX and using provided IP Address
       -v: verbose output for helper functions
For debugging: -d plus HKEY_CURRENT_USER\Software\Microsoft\Windows Script\Settings\JITDebug=1
AUTOPROX -u:url: calling DetectAutoProxyUrl and using autoproxy file to find the proxy for the url
AUTOPROX -u:url -p:path: using the autoproxy file/url from the path to find proxy for the url
Example: autoprox http://www.microsoft.com -> calling DetectAutoProxyUrl and using WPAD if found
Example: autoprox -o -u:http://www.microsoft.com -p:c:\inetpub\wwwroot\wpad.dat
Example: autoprox -u:http://www.microsoft.com -p:http://proxy/wpad.dat
Example: autoprox -d -u:http://www.microsoft.com -p:http://proxy/wpad.dat
```

Here is the output if it uses our sample:

```console
C:\temp>autoprox -u:https://us.msn.com -p:c:\temp\sample.pac
Searching proxy for url : https://us.msn.com
Searching proxy using file : c:\temp\sample.pac
The Winsock 2.2 dll was found okay
Calling InternetInitializeAutoProxyDll with c:\temp\sample.pac
        Calling InternetGetProxyInfo for url https://us.msn.com and host us.msn.com
        Proxy returned for url https://us.msn.com is:
PROXY myproxy:80;
```

## Error handling in Autoprox.exe

If the PAC file contains syntax errors, you receive the following message:

> ERROR: InternetGetProxyInfo failed with error number 0x3eb 1003.

After you finish the local test, you should copy the PAC file to the web server on which it will be accessed through the HTTP protocol.

Example:

```js
function FindProxyForURL(url, host) {
    // NetBIOS-names
    if (isPlainHostName(host))
        return "DIRECT";
    // change to lower case, if not already been done
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

[!INCLUDE [Third party disclaimer](../../../includes/third-party-contact-disclaimer.md)]
