---
title: Slow browsing in Internet Explorer
description: This article provides a resolution for the problem where an issue causes Internet Explorer to browse more slowly than expected.
ms.date: 01/04/2021
ms.reviewer: 
ms.topic: troubleshooting
---
# Slow browsing in Internet Explorer because of multiple isInNet function calls

[!INCLUDE [](../../../includes/browsers-important.md)]

This article helps you resolve the problem where an issue causes Internet Explorer to browse more slowly than expected.

_Applies to:_ &nbsp; Internet Explorer 9, Internet Explorer 10  
_Original KB number:_ &nbsp; 3140773

## Symptoms

Consider the following scenario:

- Internet Explorer is configured to use a Proxy Auto Configuration (PAC) file or WPAD for proxy settings.
- The PAC file contains several calls to the `isInNet()` function, which resemble the following:

    ```js
    function FindProxyForURL(url, host)
    {
    
        if (isInNet(host, "192.168.3.0","255.255.255.0")) ||
        isInNet(host, "10.10.1.0", "255.255.255.0") ||
        isInNet(host, "72.10.0.0", "255.255.0.0")) ||
        isInNet(host, "172.16.0.0", "255.255.0.0"))
        {
        
            return PROXY <proxyname:PORT>;
        
        }
    }
    ```

If there are several such `isInNet()` calls in the PAC file, Internet Explorer takes longer than expected to browse to a webpage.

## Cause

This issue occurs because Internet Explorer must make additional calls to the DNS subsystem to determine the IP address of the host parameter. It must do this in order to compare the IP address of the host parameter against the IP address range that's provided in the `isInNet()` function call.

## Resolution

To prevent these additional calls to the DNS subsystem every time a host is passed to the `isInNet()` function call, take steps to resolve the host name to the IP address outside of the `isInNet()` calls by passing the IP address instead of the host name.

To do this, modify the sample code in the [Symptoms](#symptoms) section as follows:

```js
function FindProxyForURL(url, host)
{
    var resolved_IP = dnsResolve(host);
    if (isInNet(resolved_IP, "192.168.3.0","255.255.255.0")) ||
    isInNet(resolved_IP, "10.10.1.0", "255.255.255.0") ||
    isInNet(resolved_IP, "72.10.0.0", "255.255.0.0")) ||
    isInNet(resolved_IP, "172.16.0.0", "255.255.0.0"))
    {
        return PROXY <proxyname:PORT>;
    }
}
```

## References

For more information, see [Optimizing performance with automatic proxy-configuration scripts (PAC)](/troubleshoot/browsers/optimize-pac-performance).
