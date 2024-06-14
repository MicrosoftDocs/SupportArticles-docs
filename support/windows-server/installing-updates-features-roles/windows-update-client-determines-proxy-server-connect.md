---
title: How the Windows Update client determines which proxy server to use
description: Describes proxy server detection methods that the Windows Update client uses to connect to the Windows Update website, and the situations where Windows Update uses a particular method.
ms.date: 06/14/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:Installing Windows Updates, Features, or Roles\Windows Update configuration, settings and management, csstroubleshoot
---
# How the Windows Update client determines which proxy server to use to connect to the Windows Update website

This article describes proxy server detection methods that the Windows Update client uses to connect to the Windows Update website, and the situations where Windows Update uses a particular method.

The Windows Update client requires the Windows HTTP Services (WinHTTP) to scan for available updates, and uses the Background Intelligent Transfer Service (BITS) or Delivery Optimization (DO) to download these updates. WinHTTP, BITS, and DO run independently in Microsoft Internet Explorer. These services must be able to detect the proxy server(s) that are available in your particular environment.

## The Automatic Updates service is configured to download and install updates from the Windows Update website

The Automatic Updates service automatically downloads and installs updates from the Windows Update website. It doesn't require user interaction because this service runs under the Local System account. This service affects system-wide level configuration and requires administrator level control. In this scenario, WinHTTP is more appropriate to be used in Internet Explorer than in WinINet.

The Automatic Updates service can only discover a proxy server by using one of the following methods:

- The proxy server is manually configured by using the `Netsh` command.
- The Web Proxy Auto Detect (WPAD) settings are configured in either of the following options in the network environment:

    - The Domain Name System (DNS) options
    - The Dynamic Host Configuration Protocol (DHCP) options

For Windows Update scan URLs (connect to [SimpleAuth Web Service](/openspecs/windows_protocols/ms-wusp/61235469-6c2f-4c08-9749-e35d52c16899), [Client Web Service](/openspecs/windows_protocols/ms-wusp/69093c08-da97-445e-a944-af0bef36e4ec)) which are used for update detection:

- The system proxy is attempted (WinHTTP).
- If the Windows Update Agent (WUA) fails to reach the service due to certain proxy, service, or authentication error codes, then the user proxy is attempted. (Generally, it's the signed-in user IE settings or WinINet.)

    For intranet WSUS update service URLs, you can use the [Specify intranet Microsoft update service location](/windows/deployment/update/waas-wu-settings#specify-intranet-microsoft-update-service-location) setting to choose the proxy behavior.

    :::image type="content" source="media/windows-update-client-determines-proxy-server-connect/specify-intranet-microsoft-update-service-location.png" alt-text="Screenshot of the Specify intranet Microsoft update service location window with Only use system proxy for detecting updates (default) selected.":::
  
For Windows Update URLs, which aren't used for update detection (for example, URLs used for reporting):

- The user proxy is attempted.
- If the WUA fails to reach the service due to certain proxy, service, or authentication error codes, then the system proxy is attempted.

## The Web Proxy Auto Detect (WPAD) feature

The WPAD feature enables services to locate an available proxy server by querying a DHCP option or by locating a particular DNS record.

## The Netsh.exe tool

The *Netsh.exe* tool is used to configure a system-wide static proxy. You can use commands in the `netsh winhttp` context to configure proxy and tracing settings for Windows HTTP. The `Netsh` commands for `winhttp` can be run manually at the `netsh` prompt or in scripts and batch files. The *Netsh.exe* tool is useful if you can't implement WPAD.

### To configure a proxy server by using the Netsh.exe tool

To use the *Netsh.exe* tool to configure a proxy server, follow these steps:

1. Select **Start** > **Run**, type *cmd*, and then select **OK**.
2. At the command prompt, run the following command and then press <kbd>Enter</kbd>.

    ```consle
    netsh winhttp set proxy <proxyservername>:<portnumber>
    ```

In this command, replace \<proxyservername\> with the fully qualified domain name of the proxy server. Replace \<portnumber\> with the port number for which you want to configure the proxy server. For example, replace \<proxyservername\>:\<portnumber\> with `proxy.domain.example.com:80`.

### To remove a proxy server by using the Netsh.exe tool

To use the *Netsh.exe* tool to remove a proxy server and to configure "direct access" to the Internet, follow these steps:

1. Select **Start** > **Run**, type *cmd*, and then select **OK**.
2. At the command prompt, run the following command and then press <kbd>Enter</kbd>.

    ```consle
    netsh winhttp reset proxy 
    ```

### To verify the current proxy configuration by using the Netsh.exe tool

To use the *Netsh.exe* tool to verify the current proxy configuration, follow these steps:

1. Select **Start** > **Run**, type *cmd*, and then select **OK**.
2. At the command prompt, run the following command and then press <kbd>Enter</kbd>.

    ```consle
    netsh winhttp show proxy
    ```

## Supported .pac files

For more information about the supported types of `.pac` files, see [WinHTTP AutoProxy Support](/windows/win32/winhttp/winhttp-autoproxy-support).
