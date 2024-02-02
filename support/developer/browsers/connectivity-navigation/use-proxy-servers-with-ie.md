---
title: Use Proxy Servers with Internet Explorer
description: This article describes how to use the Internet Explorer in proxy environments.
ms.date: 07/14/2020
ms.reviewer: heikom, axelr
---

# Using Proxy Servers together with Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article discusses how to use Microsoft Internet Explorer in proxy environments.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 4551930

## Bypass proxy servers for web requests

Some network requests have to bypass the proxy. The most common reason is for local (intranet) addresses. Generally, these addresses don't contain periods.

To bypass the proxy, select the **Bypass proxy server for local (intranet) addresses** check box in the **Local Area Network (LAN) Settings** dialog box. This method bypasses the proxy for all addresses that don't contain a period (for example, `http://compserv`). These addresses will also be resolved directly.

To bypass more complex addresses, set up exceptions for specific addresses or wildcards by using either of the following procedures.

### Use the browser settings

If you're configuring proxy settings on a user's computer after the deployment, follow these steps:

1. In Internet Explorer, open the **Tools** menu, and then select **Internet Options**.

1. On the **Connections** tab, select **LAN Settings**.

1. In the **Local Area Network Settings** dialog box, select the **Use a proxy server for your LAN settings** check box.

1. Select the **Advanced** tab, and enter the appropriate exceptions in the **Do not use proxy server for addresses beginning with:** box.

   > [!NOTE]
   > Multiple exceptions should be separated by semicolons (";").

   :::image type="content" source="media/use-proxy-servers-with-ie/browser-setting-to-bypass-address.png" alt-text="Screenshot shows the browser settings windows." border="true":::

For more information, see [Internet Explorer uses Proxy Server for Local IP address even if the "Bypass Proxy Server for Local Addresses" option is turned on](https://support.microsoft.com/help/262981).

### Use the Proxy setting in the Internet Explorer Customization Wizard

For more information about this method, see [Use the Proxy Settings page in the IEAK 11 Wizard](/internet-explorer/ie11-ieak/proxy-settings-ieak11-wizard).

### Use Group Policy

In earlier versions of the Windows operating system, Internet Explorer Maintenance (IEM) is used to configure Internet Explorer settings by using Group Policy. In Windows 8, the IEM settings have been deprecated in favor of Group Policy Preferences, Administrative Templates (.admx), and the Internet Explorer Administration Kit 10 (IEAK 10).

To configure the proxy setting through a group policy, see [How to configure Proxy Settings for Internet Explorer 10 and Internet Explorer 11 as IEM is not available](/archive/blogs/askie/how-to-configure-proxy-settings-for-ie10-and-ie11-as-iem-is-not-available).

### More information

A proxy bypass entry might begin by using an **http://**, **https://**, **ftp://**, or **gopher://** protocol type.

If a protocol type is used, the exception entry applies only to requests for that protocol.

> [!NOTE]
> The protocol value is case insensitive. Multiple entries should be separated by semicolons.

If no protocol is specified, any request that uses the address will be bypassed.

If a protocol is specified, requests that use the address will be bypassed only if they are of the indicated protocol type. Address entries are case insensitive, the same as they are for the protocol type.

If a port number is given, the request is processed only if all previous requirements are met and the request uses the specified port number.

To bypass servers, use an asterisk ("*") as a wildcard to replace actual characters in the exceptions area of the **Proxy Settings** dialog box.

- Enter a wildcard at the beginning of an Internet address, IP address, or domain name that has a common ending. For example, use ***.example.com** to bypass any entries that end in **.example.com**, such as some.example.com and www.example.com.

- Enter a wildcard in the middle of an Internet address, IP address, or domain name that has a common beginning and ending. For example, the entry **www.*.com** matches any entry that starts as **www** and ends as **com**.

- Enter a wildcard at the end of an Internet address, IP address, or domain name that has a common beginning. For example, use **www.microsoft.*** to bypass any entries that begin as **www.microsoft.**, such as `www.microsoft.com`, `www.microsoft.org`, but not `www.microsoftcorporation.com`.

- The list is intended to bypass servers, and not URLs. Therefore don't enter subwebs or trailing slashes, such as **https://www.microsoft.com/en-us** or **www.microsoft.com/**, as they are invalidating the whole list otherwise.

To bypass addresses that have similar patterns, use multiple wildcards. For example, use 123.1*.66.* to bypass addresses such as 123.144.66.12, 123.133.66.15, and 123.187.66.13.

> [!NOTE]
> Use wildcards carefully. For example, the entry **www.*.com** causes Internet Explorer to bypass the proxy for most websites.

If you bypass the proxy for a local domain, use ***.domain.com**. This method doesn't use the proxy for any computer name that ends in **.domain.com**. You can use the wildcard for any part of the name. For more information, see [The Intranet Zone](/archive/blogs/ieinternals/the-intranet-zone).

## Proxy Auto Configuration (PAC)

### Example of a simple PAC file

The following is a simple PAC file:

```vb
function FindProxyForURL(url, host)
{
 return "PROXY proxyserver:portnumber";
}
```

> [!NOTE]
> This PAC always returns the proxy **proxyserver:portnumber**. For more information about how to write a PAC file and the different functions of a PAC file, see [Introduction of FindProxyForURL](https://findproxyforurl.com/).

## References

- [How can I configure Proxy AutoConfigURL Setting using Group Policy Preference (GPP)?](/archive/blogs/askie/how-can-i-configure-proxy-autoconfigurl-setting-using-group-policy-preference-gpp)
- [How to use GPP Registry to uncheck automatically detect settings?](/archive/blogs/askie/how-to-use-gpp-registry-to-uncheck-automatically-detect-settings)
- [How to configure a proxy server URL and Port using GPP Registry?](/archive/blogs/askie/how-to-configure-a-proxy-server-url-and-port-using-gpp-registry)
- [How to configure Group Policy Preference settings for Internet Explorer 11 in Windows 8.1 or Windows Server 2012 R2](https://support.microsoft.com/kb/2898604)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]