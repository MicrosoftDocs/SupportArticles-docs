---
title: Event ID 8 is logged in Application log
description: Provides help to solve the Event ID 8 logged in the Application log.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# Event ID 8 is logged in the Application log

This article provides help to solve the Event ID 8 logged in the Application log.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 317541

## Symptoms

One or both of the following event messages may be logged in the Application log:

- Message 1

    > Event Type: Error  
    Event Source: crypt32  
    Event Category: None  
    Event ID: 8  
    Date: *date*  
    Time: *time*  
    User: *user name*  
    Computer: *computer name*  
    Description:  
    Failed auto update retrieval of third-party root list sequence number from: <`http://www.download.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootseq.txt`> with error: This operation returned because the timeout period expired.
    For more information, see Help and Support Center at `http://support.microsoft.com`.

- Message 2

    > Event Type: Error  
    Event Source: crypt32  
    Event Category: None  
    Event ID: 8  
    Date: *date*  
    Time: *time*  
    User: *user name*  
    Computer: *computer name*  
    Description:  
    Failed auto update retrieval of third-party root list sequence number from: <`http://www.download.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootseq.txt`> with error: The specified server cannot perform the requested operation.
    For more information, see Help and Support Center at `http://support.microsoft.com`.

## Cause

This behavior can occur if the Update Root Certificates component is turned on and the computer cannot connect to the Windows Update server on the Internet. The Update Root Certificates component automatically updates trusted root-certificate authorities from the Microsoft Update server at regular intervals.

## Resolution

To resolve this behavior, you must connect to the Internet or turn off the Update Root Certificates component. To turn off the Update Root Certificates component, follow these steps:

1. In Control Panel, double-click **Add/Remove Programs**.
2. Click **Add/Remove Windows Components**.
3. Clear the **Update Root Certificates** check box, and then continue with the Windows Components Wizard.

## Status

This behavior is by design.

## More information

The Update Root Certificates component uses the WinHTTP API to communicate with the Windows Update server. If your computer is behind a proxy server, you may have to set the proxy settings by using the Proxycfg.exe utility. To configure WinHTTP by using Proxycfg.exe, follow these steps:

1. Start the Proxycfg.exe utility from the \<Systemroot>\System32 folder. If you cannot locate the Proxycfg.exe utility in the \<Systemroot>\System32 folder, see [ProxyCfg.exe Proxy Configuration Tools](/windows/win32/winhttp/proxycfg-exe--a-proxy-configuration-tool).

2. Determine the proxy server name that you use.

3. At the command prompt, configure your computer by using the Proxycfg.exe utility with one of the following settings:

    - To see the current proxy settings for WinHTTP, type *proxycfg*, and then press RETURN. By default, the current proxy setting should be **Proxy Direct**. If you have Microsoft XML Parser (MSXML) 3.0 SP1 or earlier versions, the current proxy setting may be **Not Set**. In this scenario, type `proxycfg -d`, and then press RETURN to restore the default proxy settings for WinHTTP.

    - To not use any proxy servers when connecting server-to-server, type `proxycfg -d`, and then press RETURN.

    - To use a proxy server when connecting server-to-server, type `proxycfg -p`, type the proxy servers you want to use, and then press RETURN. Additionally, you can add optional bypass lists for servers that will not be accessed through a proxy. You can find acceptable proxy server formats or bypass formats in the the Proxycfg.exe utility ReadMe.txt file.

    - To import proxy information from the settings that Internet Explorer uses to connect to the Internet, also known as the WinInet settings, and to include this proxy information in the WinHTTP settings, type `proxycfg -u`, and then press RETURN.

4. Stop and restart Microsoft Internet Information Server (IIS).

The following are some command line examples using Proxycfg.exe:

- Example 1:

    ```console
    proxycfg -d -p my Proxy Server :80 "<local>"
    ```

    This example shows the most common use for Proxycfg.exe. This command specifies that both HTTP and HTTPS servers must be accessed through the proxy server that is named *my Proxy Server* with a port number of 80, unless the host name does not contain a period. In this case, the `-d` option has no effect.

- Example 2:

    ```console
    proxycfg -p my Proxy Server
    ```

    This example specifies that both HTTP and HTTPS servers must be accessed through the proxy server that is named my Proxy Server. It specifies no bypass list.

- Example 3:

    ```console
    proxycfg -p "http= http_proxy https= https_proxy" "<local>;*.microsoft.com"
    ```

    This example specifies that HTTP servers must be accessed through the *http_proxy*proxy, and that HTTPS servers must be accessed through *https_proxy*. Local intranet sites and host names that do not contain a period, and any site in the .microsoft.com domain, bypass the proxy.

For more information about how to troubleshoot problems with Internet connections, see [Fix Wi-Fi connection issues in Windows](https://support.microsoft.com/help/10741).
