---
title: WinHTTP SDP package information
description: This article outlines the manual steps required to disable WinHTTP tracing that was enabled using the SDP package.
ms.date: 03/23/2020
ms.custom: sap:WWW service and Svchost operation
ms.reviewer: huizhu
ms.topic: how-to
ms.technology: iis-www-service-svchost
---
# WinHTTP SDP package information

This article provides information about how to disable WinHTTP tracing that is enabled by using the Support Diagnostic Package (SDP) package.

_Original product version:_ &nbsp; Windows 7, Windows Server 2008 R2, Windows Server 2008  
_Original KB number:_ &nbsp; 2725072

## Summary

The SDP for WinHTTP is used to configure WinHTTP tracing on the machine that is experiencing an issue with the WinHTTP technology. The SDP package will collect a WinHTTP trace of an application using the WinHTTP API.

While the SDP package will usually take care of enabling the WinHTTP tracing and disabling the tracing, the trace will need to be manually stopped/disabled if the user decides to cancel the SDP package before the SDP package gets a chance to perform the necessary cleanup. This KB article outlines the steps required to disable WinHTTP tracing depending on the operating system the tracing package was run on.

To disable WinHTTP tracing manually, follow the steps below based on the operating system you were collecting the trace.

## Disable WinHTTP tracing manually on Windows Server 2008

1. Open an elevated command prompt (Run as administrator) and then type the command:

    ```console
    netsh winhttp reset tracing
    ```

2. For 64-bit operating systems, you need to disable tracing for 32-bit applications. To do that, open `cmd.exe` from an elevated command prompt (Run as administrator) from `%windir%\SysWOW64\cmd.exe` and then type the command:

    ```console
    netsh winhttp reset tracing
    ```

3. Restart your application that was experiencing the issue to ensure that the tracing stops for your application. You can delete the trace from the location where it was being collected. This trace location is specified when you use the SDP package. By default the SDP package creates the WinHTTP trace in the `C:\WinHttpTraces` folder.

## Disable WinHTTP tracing manually on Windows 7 and Windows Server 2008 R2

1. Open an elevated command prompt (Run as administrator) and then type the command:

    ```console
    netsh winhttp reset tracing
    ```

2. From the same command prompt, type:

    ```console
    netsh trace stop
    ```

   This will stop the ETL trace collection.

3. For 64-bit operating systems, you need to disable tracing for 32-bit applications. To do that, open cmd.exe from an elevated command prompt (Run as administrator) from `%windir%\SysWOW64\cmd.exe` and then type the command:

    ```console
    netsh winhttp reset tracing
    ```

4. You don't need to type the following command from the 32-bit command prompt:

    ```console
    netsh trace stop
    ```

5. Restart your application that was experiencing the issue to ensure that the tracing stops for your application. You can delete the trace from the location where it was being collected. This trace location is specified when you use the SDP package. By default the SDP package creates the WinHTTP trace in the `C:\WinHttpTraces` folder.

## References

- [Information about Microsoft Automated Troubleshooting Services and Support Diagnostic Platform](https://support.microsoft.com/help/2598970)

- [Collect WinHTTP traces](https://learn.microsoft.com/windows/win32/winhttp/collect-traces)

- [Netsh Commands for Windows Hypertext Transfer Protocol (WINHTTP)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731131(v=ws.10))

- [Netsh Commands for Network Trace in Windows Server 2008 R2 and Windows 7](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd878517(v=ws.10))
