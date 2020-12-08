---
title: Prompt for credentials when you access WebDav-based FQDN sites in Windows
description: Describes a problem in which you are prompted to enter your credentials when you access an FQDN site on a Windows Vista, Windows 7, or Windows 10-based client computer that has no proxy configured. Provides a resolution.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: tonyga, stevenxu, kishore
---
# Prompt for credentials when you access WebDav-based FQDN sites in Windows

_Original product version:_ &nbsp; Windows Server version 1803, Windows Server version 1709, Windows Server version 1803, Windows Server 2016  
_Original KB number:_ &nbsp; 943280

## Symptoms

Consider the following scenario:

- You use a computer that is running Windows Vista or a later version of Windows.
- You use Web Distributed Authoring and Versioning (WebDav) to access a fully qualified domain names (FQDN) site.
In this scenario, you are prompted to enter your credentials or you are denied access even though the user account that you are using has sufficient permissions to access this site.

You may also receive the following error message when you work with moved folders through the explorer view:
Your client does not support opening this list with Windows Explorer.

## Cause

In Windows Vista or later Windows versions, t he WebClient service is used to allow Windows Explorer to interact with a WebDAV resource. The WebClient Service uses Windows HTTP Services (WinHTTP) to perform network I/O operations to the remote host. 
 WinHTTP sends user credentials only in response to requests that occur on a local intranet site. However, WinHTTP does not check the security zone settings in Internet Explorer to determine whether a website is in a zone that allows credentials to be sent automatically. 
 If no proxy is configured, WinHTTP sends credentials only to local intranet sites. 

**Note** If the URL contains no period in the server name, such as in the following example, the server is assumed to be on a local intranet site:
http://sharepoint/davshareIf the URL contains periods, the server is assumed to be on the Internet. The periods indicate that you use an FQDN address. Therefore, no credentials are automatically sent to this server unless a proxy is configured and unless this server is indicated for proxy bypass.

**Note** A server can be indicated for proxy bypass through either the bypass list or the proxy configuration script.

In this situation, you are either denied access or prompted to enter your credentials when the website asks for credentials. Even when this occurs, the security zone settings are ignored.

## Resolution

**Important**  

This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

### Registry information

To resolve this problem, create a registry entry. To do this, follow these steps:
1. Click **Start**, type **regedit**, and then press Enter .
2. Locate and then select the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters` 

3. On the **Edit** menu, point to **New**, and then click **Multi-String Value**.
4. Type **AuthForwardServerList**, and then press Enter .
5. On the **Edit** menu, click **Modify**.
6. In the **Value data** box, type the URL of the server that hosts the web share, and then click **OK**.

> [!NOTE]
> You can also type a list of URLs in the **Value data** box. For more information, see the "Sample URL list" section in this article.
7. Exit Registry Editor.
  **Notes**  
 
- If you have added the **AuthForwardServerList** registry entry, be aware that if Basic authentication or Digest authentication is implemented in the network, using the registry entry cannot prevent the prompt for credentials. This behavior is by design for Basic authentication and Digest authentication.
- You must restart the WebClient service after you modify the registry.
 

### Sample URL list

In the **Value data** box for the new entry, you can enter a list of URLs, such as the following example:
```
 https://*.Contoso.com http://*.dns.live.com *.microsoft.com
```

This URL list enables the WebClient service to send credentials through the following channels:
 
- Any encrypted channel to a child domain of a domain whose name is Contoso.com.
- Any nonsecure channel to a child domain of a domain whose name is dns.live.com.
- Any channel to a server whose name ends in ".microsoft.com."
 
 **Note** After you configure the URL list, the credentials will automatically authenticate to the WebDAV servers, even if these servers are on the Internet. 

### Things to avoid in the URL list


- Do not add an asterisk (*) character at the end of a URL. This can create a security risk. For example, do not use the following URL:

- http://*.dns.live.*  

- Do not add an asterisk (*) before or after a string. This can cause the WebClient service to send user credentials to additional servers. For example, do not use the following URLs:

- http://*Contoso.com

In this example, the service also sends user credentials to http:// **extra_characters** Contoso.com.

- http://Contoso*.com

In this example, the service also sends user credentials to http://Contoso **extra_characters**.com.
 
- In the URL list, do not type the UNC name of a host. For example, do not use the following URL:

- http://*.contoso.com@SSL
 
- In the URL list, list, do not end the URL in a backslash, and do not include the share name or the port number to be used. For example, do not use the following URLs:

- http://*.dns.live.com/ 
  - http://*.dns.live.com/DavShare
  - http://*dns.live.com:80
 
- Do not use IPv6 in the URL list.
 **Important**  

This URL list does not affect the security zone settings. This URL list is used only for the specific purpose of forwarding the credentials to WebDAV servers. The list should be created as restrictively as possible to avoid any security issues. Also, because there is no specific deny list, the credentials are forwarded to all the servers that match this list.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
