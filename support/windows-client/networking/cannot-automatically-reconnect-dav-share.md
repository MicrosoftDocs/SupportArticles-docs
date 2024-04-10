---
title: Windows 7 can't automatically reconnect a DAV share when Basic Authentication is used
description: Describe a by-design behavior where Windows 7 can't automatically reconnect a DAV share when Basic Authentication is used.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: waltere, kaushika,v-jesits
ms.custom: sap:Network Connectivity and File Sharing\WebClient and WebDAV, csstroubleshoot
---
# Windows 7 can't automatically reconnect a DAV share when Basic Authentication is used

This article describes a by-design behavior where Windows 7 can't automatically reconnect a DAV share when Basic Authentication is used.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2673544

## Symptoms

Consider the following scenario on a Windows 7-based computer:

- You used the Map Network Drive wizard or the Add Network Location wizard to connect a WebDav share or folder.
- Basic Authentication is used for this resource.

    > [!Note]
    > Basic Authentication is often used for connections to third-party DAV servers, such as Apache, Oracle, and SAP.

In this scenario, the resource isn't accessible after a system restart or a user logoff and logon.

Additionally, Windows can't access the SSL WebDav folder. Instead, it returns one of the following network error messages.

### Error message 1  

> Windows cannot access \\\\`server.company.com`@SSL\\davWWWRoot\\folder1\\folder2\\folder3\\docs.  
Check the spelling of the name. Otherwise, there might be a problem with your network. To try to identify and resolve network problems, click diagnose.  
Error code: 0x80070035  
The network path was not found.  

> [!Note]
> Error code 0x80070035 maps to ERROR_BAD_NETPATH.

### Error message 2  

> System Error 1244:  
The operation being requested was not performed because the user has not been authenticated.

 > [!Note]
 > Error code 1244 maps to ERROR_NOT_AUTHENTICATED.

## Resolution

Starting in Windows 7, Basic Authentication cannot be persisted by the Credential Manager. The only method to reconnect in Basic Authentication mode is to disconnect and reconnect the drive. This is because WinHttp can't retrieve saved Basic Authentication or Digest Authentication credentials.  

For persistent connections, make sure that an authentication scheme is selected that enables persistent credentials through a restart. For example, Kerberos enables persistent credentials for authentication or certificate-based authentication.  

## Workaround

Use a logon script that reconnects the DAV share at user logon. For example, include either of the following lines in the user logon script:

net use X: `http://server.company.com@8080/folder1/folder2/docs` /persistent:no  

net use X: \\\\`server.company.com`@SSL\\davWWWRoot\\folder1\\folder2\\docs  

> [!Note]
> 8080 is the TCP port number for the SSL connection to the DAV server.

## Status

This behavior is by design in Basic Authentication mode in Windows 7.

## More information

Basic Authentication is a widely used, industry-standard method for collecting user name and password information. The advantage of Basic Authentication is that it's part of the HTTP specification and is supported by most browsers.

However, Basic Authentication prompts the user for a user name and password. This information is then sent unencrypted over the network.

The Basic Authentication method isn't recommended unless you're sure that the connection between the user and the web server is secure (for example, by using SSL or a direct connection).

In Basic Authentication, the password is sent over the network in plain text. If this password is intercepted over the network by a network sniffer, an unauthorized user can determine the user name and password, and reuse these credentials.

It's because of this security risk that Office 2010 applications disable Basic Authentication over a non-SSL connection in the default configuration.

### Specific situations

[2123563](https://support.microsoft.com/help/2123563) You cannot open Office file types directly from a server that supports only Basic authentication over a non-SSL connection

Basic authentication in Windows 7 isn't enabled by default if you're trying to connect to HTTP resources. For HTTP access, the BasicAuthLevel=2 key must be set (2 = Basic authentication enabled for SSL and for non-SSL connections).

If no proxy is configured, WinHTTP sends credentials only to local intranet sites. If an HTTP proxy program is running on the client, or if no proxy server entry is configured, and you try to connect to a resource by using an FQDN such as `http://server.company.com`, you should use the **AuthForwardServerList** registry key as described in [KB 943280](https://support.microsoft.com/help/943280) to explicitly list the servers that you want to be treated as internal so that you can pass credentials for them.

[943280](https://support.microsoft.com/help/943280) Prompt for Credentials When Accessing FQDN Sites From a Windows Vista or Windows 7 Computer

[941050](https://support.microsoft.com/help/941050) Error message on a Windows Vista-based computer when you try to access a network drive that is mapped to a Web share: "The operation being requested was not performed because the user has not been authenticated"

## References

[WebDAV Redirector Registry Settings](/archive/blogs/robert_mcmurray/webdav-redirector-registry-settings)
