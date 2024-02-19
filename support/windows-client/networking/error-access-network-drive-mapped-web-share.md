---
title: User has not been authenticated error when you access a network drive mapped to a web share
description: Describes an issue that triggers an error on a Windows-based computer when you try to access a mapped web share. Provides a resolution.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: amanjain, kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
---
# Error when you try to access a network drive that's mapped to a web share: User has not been authenticated

This article provides a resolution for an issue that occurs on a Windows-based computer when you try to access a mapped web share.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 941050

## Symptoms

Consider the following scenario on a Windows-based computer:

- You map a network drive to a web share that requires user credentials.
- You configure the drive to use the **Reconnect at logon** option.
- You enter the user credentials, and then you select the **Remember my password** check box when you access the drive.
- You restart the computer, or you log off from Windows.

In this scenario, when you log on to the computer again, you receive an error message that resembles the following when you try to access the mapped drive:
> An error occurred while connecting to **address**  
The operation being requested was not performed because the user has not been authenticated  
The connection has not been restored  

> [!NOTE]
> The mapped drive appears as disconnected after you log on to the computer again.

## Cause

This issue occurs because the Web Distributed Authoring and Versioning (WebDAV) redirector uses Windows HTTP Services (WinHTTP) instead of the Windows Internet (WinInet) API. In a non-proxy network configuration, WinHTTP sends user credentials only in response to requests that occur on a local intranet site. Therefore, if no proxy is configured, you may be unable to access a share that requires user credentials.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
 [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

To resolve this problem in Windows Vista, apply hotfix 943280. The hotfix is only for Windows Vista. For later versions of Windows, go to the next section to modify the registry keys.

> [!NOTE]
> This hotfix applies only to Windows Vista-based systems. However, the registry changes described later in this section apply to all the operating systems in the "Applies To" section. No hotfix is required for systems that are running Windows 7, Windows 8.1, or Windows 10. The registry changes alone fix the problem on these systems.

For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[943280](https://support.microsoft.com/help/943280) You are prompted to enter your credentials when you access an FQDN site by using a Windows Vista-based client computer that has no proxy configured

After you apply this hotfix, you must create a registry entry. To do this, follow these steps:

1. Click **Start**, type *regedit* in the **Start Search** box, and then press Enter.
2. Locate and then click the following subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters`
3. On the **Edit** menu, point to **New**, and then click **Multi-String Value**.
4. Type **AuthForwardServerList**, and then press Enter.
5. On the **Edit** menu, click **Modify**.
6. In the **Value date** box, type the URL of the server that hosts the web share, and then click **OK**.

    > [!NOTE]
    > You can also type a list of URLs in the **Value date** box. For more information, see the "Sample URL list" section.
7. Exit Registry Editor.

After this registry entry is created, the WebClient service will read the entry value. If the client computer tries to access a URL that matches any of the expressions in the list, the user credential will be successfully sent to authenticate the user even if no proxy is configured.

> [!NOTE]
> You must restart the WebClient service after you modify the registry.

### Sample URL list

The following is a sample URL list:

`https://*.Contoso.com`  

`http://*.dns.live.com`  

`*.microsoft.com`  

`https://172.169.4.6`  

This URL list enables the WebClient service to send credentials through the following channels.

> [!NOTE]
> After you configure this URL list, the credentials will automatically authenticate to the WebDAV servers even if these servers are on the Internet.
>
> - Any encrypted channel to a child domain of a domain whose name is `Contoso.com`.
> - Any nonsecure channel to a child domain of a domain whose name is `dns.live.com`.
> - Any channel to a server whose name ends with ".microsoft.com."
> - Any encrypted channel to a host whose IP address is 172.169.4.6.

### Things to avoid in the URL list

- Don't add an asterisk (*) at the end of a URL. When you do this, a security risk may result. For example, don't use the following:

    `http://*.dns.live.*`

- Don't add an asterisk (*) before or after a string. When you do this, the WebClient service can send user credentials to more servers. For example, don't use the following:

  - `http://Contoso.com`

  In this example, the service also sends user credentials to `http://**extra_characters** Contoso.com`.

  - `http://Contoso*.com`

  In this example, the service also sends user credentials to `http://Contoso **extra_characters**.com`.

- Don't type the UNC name of a host in the URL list. For example, don't use the following:

    `*.contoso.com@SSL`

- Don't include the share name or the port number to be used in the URL list. For example, don't use the following:
  - `http://*.dns.live.com/DavShare`
  - `http://*dns.live.com:80`
- Don't use IPv6 in the URL list.

> [!IMPORTANT]
> This URL list has no effect on the security zone settings, and this URL list is used only for the specific purpose of forwarding the credentials to WebDAV servers. Create the list as restrictively as possible to avoid any security issues. Also, notice that there is no specific deny list. Therefore, the credentials are forwarded to all the servers that match this list.

If Basic authentication or Digest authentication is implemented in the network, hotfix 943280 can't change this behavior. This behavior is by design in Basic authentication mode and in Digest authentication mode.

IIS doesn't support Windows authentication over the Internet. Therefore, this hotfix applies only to the Intranet scenarios.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
