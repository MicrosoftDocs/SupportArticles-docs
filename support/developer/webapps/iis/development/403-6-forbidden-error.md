---
title: HTTP error 403.6 when you open a webpage
description: This article helps to fix the HTTP error 403.6 when you visit a web site that is hosted on Microsoft Internet Information Services (IIS).
ms.date: 07/17/2020
ms.custom: sap:Development
ms.reviewer: clinth
ms.technology: development
---
# HTTP error 403.6 when you open an IIS Webpage

This article helps to fix the HTTP error 403.6 that occurs when you visit a web site that is hosted on Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services (IIS)  
_Original KB number:_ &nbsp; 248043

> [!NOTE]
> The target audience for this article is Website administrator. If you are an end-user, you have to contact the Website administrators in order to let them know that this error has occurred for this URL address.

## Symptoms

You have a web site that is hosted on Internet Information Services (IIS). When you visit the Web site in a Web browser, you may receive an error message that resembles the follow:

> HTTP 403.6 - Forbidden: IP address rejected

## Cause

Each client has a unique IP address. If the server defines a list of IP addresses that are not allowed to access the site and the IP address you are using is on this list, you will receive the error message.

This is a feature that grants or denies specific users access to a Web site, directory, or file.

## Resolution

To resolve this problem, follow these steps.

1. Using the **Internet Service Manager** (Microsoft Management Console), open the Internet Information Server (IIS) snap-in and select the Web site reporting the 403.6 error. Right-click the Web site, virtual directory, or file where the error is occurring. Click **Properties** to display the property sheet for that item.

2. Select the appropriate **Directory Security** or **File Security** property page. Under **IP Address** and **Domain Name Restrictions**, click **Edit**.

3. In the **IP Address** and **Domain Name Restrictions** dialog box, if the **Denied Access** option is selected, then add the IP address, network ID, or domain of the computer that requires access to the exceptions list.

In the **IP Address** and **Domain Name Restrictions** dialog box, if the **Granted Access** option is selected, then remove the IP address, network ID, or domain of the computer that requires access to the exceptions list.

> [!IMPORTANT]
>
> - When you set security properties for a specific Web site, you automatically set the same security properties for directories and files belonging to that site, unless the security properties of the individual directories and files have been previously set.
> - Your Web server will prompt you for permission to reset the properties of individual directories and files when you attempt to set security properties for your Web site. If you choose to reset these properties, your previous security settings will be replaced by the new settings. The same condition applies when you set security properties for a directory containing subdirectories or files with previously set security properties.

> [!NOTE]
>
> - By default, some sites are only granted access from the IP address 127.0.0.1, which corresponds to the computer name *localhost* and is considered a different address/name than the NetBIOS or fully qualified domain name (FQDN) of the Web server. To access a site restricted to localhost, you must be at the console of the computer with the localhost restriction.
> - Computers accessing your server across proxy servers will appear to have the IP address of the proxy server.
> - Restricting by domain name is not recommended because it decreases the performance of your Web server by forcing the Web server to perform a reverse DNS lookup for each connection to that site. In addition to increasing the load on the Web server, reverse lookups can also result in unexpected denials.

## References

[Microsoft TCP/IP host name resolution order](https://support.microsoft.com/help/172218)
